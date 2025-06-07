import React, { useState, useEffect } from 'react';
import './App.css';
import config from './config';

function App() {
  const [message, setMessage] = useState('');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [environment, setEnvironment] = useState(config.env);

  useEffect(() => {
    const fetchData = async () => {
      try {
        // Use the API URL from config
        const response = await fetch(`${config.apiUrl}/health/`);

        if (!response.ok) {
          throw new Error(`HTTP error! Status: ${response.status}`);
        }

        const data = await response.json();
        setMessage(data.status);
        setLoading(false);
      } catch (error) {
        setError('Failed to connect to the API. Please try again later.');
        setLoading(false);
        console.error('Error fetching data:', error);
      }
    };

    fetchData();
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        <h1>Microservice Web Platform</h1>
        <p className="environment-badge">Environment: {environment}</p>
        {loading ? (
          <p>Loading...</p>
        ) : error ? (
          <p className="error">{error}</p>
        ) : (
          <div>
            <p>API Status: {message}</p>
          </div>
        )}
      </header>
    </div>
  );
}

export default App;
