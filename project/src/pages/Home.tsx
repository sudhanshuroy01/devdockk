import React from 'react';
import { Link } from 'react-router-dom';
import { Users, Code, Globe } from 'lucide-react';

function Home() {
  return (
    <div className="max-w-4xl mx-auto">
      <div className="text-center mb-12">
        <h1 className="text-4xl font-bold text-gray-900 mb-4">
          Find Your Perfect Hackathon Teammate
        </h1>
        <p className="text-xl text-gray-600">
          Connect with developers, designers, and creators who share your passion for building amazing projects.
        </p>
      </div>

      <div className="grid md:grid-cols-3 gap-8 mb-12">
        <div className="bg-white p-6 rounded-lg shadow-md">
          <Users className="h-12 w-12 text-indigo-600 mb-4" />
          <h3 className="text-xl font-semibold mb-2">Create Your Profile</h3>
          <p className="text-gray-600">
            Showcase your skills, experience, and the hackathons you're interested in.
          </p>
        </div>

        <div className="bg-white p-6 rounded-lg shadow-md">
          <Code className="h-12 w-12 text-indigo-600 mb-4" />
          <h3 className="text-xl font-semibold mb-2">Find Teammates</h3>
          <p className="text-gray-600">
            Search and filter potential teammates based on skills and interests.
          </p>
        </div>

        <div className="bg-white p-6 rounded-lg shadow-md">
          <Globe className="h-12 w-12 text-indigo-600 mb-4" />
          <h3 className="text-xl font-semibold mb-2">Connect & Collaborate</h3>
          <p className="text-gray-600">
            Message potential teammates and start building amazing projects together.
          </p>
        </div>
      </div>

      <div className="text-center">
        <Link
          to="/auth"
          className="inline-block bg-indigo-600 text-white px-8 py-3 rounded-lg font-semibold hover:bg-indigo-700 transition-colors"
        >
          Get Started
        </Link>
      </div>
    </div>
  );
}

export default Home;