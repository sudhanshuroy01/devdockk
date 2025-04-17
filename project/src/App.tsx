import React, { useEffect } from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Navbar from './components/Navbar';
import AuthRequired from './components/AuthRequired';
import Home from './pages/Home';
import Profile from './pages/Profile';
import Search from './pages/Search';
import Messages from './pages/Messages';
import Auth from './pages/Auth';
import { useAuthStore } from './lib/store';

function App() {
  const { loadProfile } = useAuthStore();

  useEffect(() => {
    loadProfile();
  }, [loadProfile]);

  return (
    <Router>
      <div className="min-h-screen bg-gray-50">
        <Navbar />
        <main className="container mx-auto px-4 py-8">
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/auth" element={<Auth />} />
            <Route path="/profile" element={<AuthRequired><Profile /></AuthRequired>} />
            <Route path="/search" element={<AuthRequired><Search /></AuthRequired>} />
            <Route path="/messages" element={<AuthRequired><Messages /></AuthRequired>} />
          </Routes>
        </main>
      </div>
    </Router>
  );
}

export default App;