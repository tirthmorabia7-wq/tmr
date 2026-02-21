import React from 'react';
import { GameProvider, useGame } from './context/GameContext';
import LandingPage from './components/LandingPage';
import Dashboard from './components/Dashboard';

function AppContent() {
  const { currentPage } = useGame();
  return currentPage === 'landing' ? <LandingPage /> : <Dashboard />;
}

export default function App() {
  return (
    <GameProvider>
      <AppContent />
    </GameProvider>
  );
}
