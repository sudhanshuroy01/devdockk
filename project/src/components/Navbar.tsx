import React from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { Users, Search, MessageSquare, UserCircle, LogOut } from 'lucide-react';
import { useAuthStore } from '../lib/store';

function Navbar() {
  const { user, signOut } = useAuthStore();
  const navigate = useNavigate();

  const handleSignOut = async () => {
    await signOut();
    navigate('/');
  };

  return (
    <nav className="bg-white shadow-md">
      <div className="container mx-auto px-4">
        <div className="flex items-center justify-between h-16">
          <Link to="/" className="flex items-center space-x-2">
            <Users className="h-6 w-6 text-indigo-600" />
            <span className="text-xl font-bold text-gray-900">TeammateFinder</span>
          </Link>
          
          <div className="flex items-center space-x-4">
            {user ? (
              <>
                <Link to="/search" className="text-gray-600 hover:text-indigo-600">
                  <Search className="h-5 w-5" />
                </Link>
                <Link to="/messages" className="text-gray-600 hover:text-indigo-600">
                  <MessageSquare className="h-5 w-5" />
                </Link>
                <Link to="/profile" className="text-gray-600 hover:text-indigo-600">
                  <UserCircle className="h-5 w-5" />
                </Link>
                <button
                  onClick={handleSignOut}
                  className="text-gray-600 hover:text-indigo-600"
                >
                  <LogOut className="h-5 w-5" />
                </button>
              </>
            ) : (
              <Link
                to="/auth"
                className="bg-indigo-600 text-white px-4 py-2 rounded-md hover:bg-indigo-700 transition-colors"
              >
                Sign In
              </Link>
            )}
          </div>
        </div>
      </div>
    </nav>
  );
}

export default Navbar;