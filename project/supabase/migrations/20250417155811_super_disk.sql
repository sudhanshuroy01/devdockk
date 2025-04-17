/*
  # Initial Schema Setup for Teammate Finder

  1. New Tables
    - `profiles`
      - `id` (uuid, primary key, matches auth.users)
      - `username` (text, unique)
      - `full_name` (text)
      - `avatar_url` (text)
      - `bio` (text)
      - `location` (text)
      - `created_at` (timestamp)
      - `updated_at` (timestamp)
    
    - `skills`
      - `id` (uuid, primary key)
      - `name` (text, unique)
      - `category` (text)

    - `user_skills`
      - `profile_id` (uuid, references profiles)
      - `skill_id` (uuid, references skills)
      - Primary key is (profile_id, skill_id)

    - `hackathons`
      - `id` (uuid, primary key)
      - `name` (text)
      - `location` (text)
      - `is_online` (boolean)
      - `start_date` (date)
      - `end_date` (date)
      - `created_at` (timestamp)

    - `user_hackathons`
      - `profile_id` (uuid, references profiles)
      - `hackathon_id` (uuid, references hackathons)
      - Primary key is (profile_id, hackathon_id)

    - `messages`
      - `id` (uuid, primary key)
      - `sender_id` (uuid, references profiles)
      - `receiver_id` (uuid, references profiles)
      - `content` (text)
      - `created_at` (timestamp)
      - `read_at` (timestamp)

  2. Security
    - Enable RLS on all tables
    - Add policies for authenticated users
*/

-- Create profiles table
CREATE TABLE profiles (
  id uuid PRIMARY KEY REFERENCES auth.users,
  username text UNIQUE NOT NULL,
  full_name text,
  avatar_url text,
  bio text,
  location text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create skills table
CREATE TABLE skills (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text UNIQUE NOT NULL,
  category text NOT NULL
);

-- Create user_skills table
CREATE TABLE user_skills (
  profile_id uuid REFERENCES profiles ON DELETE CASCADE,
  skill_id uuid REFERENCES skills ON DELETE CASCADE,
  PRIMARY KEY (profile_id, skill_id)
);

-- Create hackathons table
CREATE TABLE hackathons (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  location text,
  is_online boolean DEFAULT false,
  start_date date NOT NULL,
  end_date date NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Create user_hackathons table
CREATE TABLE user_hackathons (
  profile_id uuid REFERENCES profiles ON DELETE CASCADE,
  hackathon_id uuid REFERENCES hackathons ON DELETE CASCADE,
  PRIMARY KEY (profile_id, hackathon_id)
);

-- Create messages table
CREATE TABLE messages (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  sender_id uuid REFERENCES profiles ON DELETE CASCADE,
  receiver_id uuid REFERENCES profiles ON DELETE CASCADE,
  content text NOT NULL,
  created_at timestamptz DEFAULT now(),
  read_at timestamptz
);

-- Enable RLS
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE skills ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_skills ENABLE ROW LEVEL SECURITY;
ALTER TABLE hackathons ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_hackathons ENABLE ROW LEVEL SECURITY;
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;

-- Policies
CREATE POLICY "Public profiles are viewable by everyone"
  ON profiles FOR SELECT
  USING (true);

CREATE POLICY "Users can update own profile"
  ON profiles FOR UPDATE
  USING (auth.uid() = id);

CREATE POLICY "Skills are viewable by everyone"
  ON skills FOR SELECT
  USING (true);

CREATE POLICY "User skills are viewable by everyone"
  ON user_skills FOR SELECT
  USING (true);

CREATE POLICY "Users can manage their own skills"
  ON user_skills FOR ALL
  USING (auth.uid() = profile_id);

CREATE POLICY "Hackathons are viewable by everyone"
  ON hackathons FOR SELECT
  USING (true);

CREATE POLICY "User hackathons are viewable by everyone"
  ON user_hackathons FOR SELECT
  USING (true);

CREATE POLICY "Users can manage their own hackathon interests"
  ON user_hackathons FOR ALL
  USING (auth.uid() = profile_id);

CREATE POLICY "Users can view their own messages"
  ON messages FOR SELECT
  USING (auth.uid() = sender_id OR auth.uid() = receiver_id);

CREATE POLICY "Users can send messages"
  ON messages FOR INSERT
  WITH CHECK (auth.uid() = sender_id);

-- Insert some initial skills
INSERT INTO skills (name, category) VALUES
  ('React', 'Frontend'),
  ('TypeScript', 'Frontend'),
  ('Node.js', 'Backend'),
  ('Python', 'Backend'),
  ('Figma', 'Design'),
  ('UI/UX', 'Design'),
  ('AWS', 'DevOps'),
  ('Docker', 'DevOps'),
  ('PostgreSQL', 'Database'),
  ('MongoDB', 'Database');