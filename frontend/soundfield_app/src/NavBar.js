import React, { useState } from 'react';
import UploadSection from './UploadSection';
import AboutUs from './AboutUs';
import './App.css';

function Navbar() {
  const [activeTab, setActiveTab] = useState('upload'); // Default active tab is 'Upload'

  const handleTabClick = (tab) => {
    setActiveTab(tab);
  }

  return (
    <nav>
      <div className="columns" style={{ width: "100%" }}>
        <div style={{ float: "left" }}>
          <ul>
            <li className={activeTab === 'upload' ? 'active' : ''} onClick={() => handleTabClick('upload')}>
              Upload
            </li>
            <li className={activeTab === 'about' ? 'active' : ''} onClick={() => handleTabClick('about')}>
              About Us
            </li>
            <li className={activeTab === 'rendering' ? 'active' : ''} onClick={() => handleTabClick('rendering')}>
              Your Rendering
            </li>
          </ul>
        </div>
        <div className="content" style={{ float: "right", marginRight: "30%" }}>
          {activeTab === 'upload' && <UploadSection />}
          {activeTab === 'about' && <AboutUs />}
          {activeTab === 'rendering' && <YourRenderingComponent />}
        </div>
      </div>
    </nav>
  );
}

function YourRenderingComponent() {
  return <div>Your Rendering Component</div>;
}

export default Navbar;