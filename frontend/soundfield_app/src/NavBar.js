import React, { useState } from 'react';
import UploadSection from './UploadSection';
import AboutUs from './AboutUs';
import RenderSection from "./RenderSection"
import './App.css';

function Navbar() {
  const [activeTab, setActiveTab] = useState('upload'); // Default active tab is 'Upload'

  const handleTabClick = (tab) => {
    setActiveTab(tab);
  }

  return (
    <nav>
      <div className="columns" style={{ width: "100%" }}>
        <div style={{marginLeft: "7%"}}>
          <ul>
            <li className={activeTab === 'upload' ? 'active' : ''} onClick={() => handleTabClick('upload')} style={{ display: "inline", marginRight: "110px"}}>
              Upload
            </li>
            <li className={activeTab === 'about' ? 'active' : ''} onClick={() => handleTabClick('about')} style={{ display: "inline", marginRight: "110px"}}>
              About Us
            </li>
            <li className={activeTab === 'rendering' ? 'active' : ''} onClick={() => handleTabClick('rendering')} style={{ display: "inline", marginRight: "110px"}}>
              Your Rendering
            </li>
          </ul>
        </div>
        <div className="content">
          {activeTab === 'upload' && <UploadSection />}
          {activeTab === 'about' && <AboutUs />}
          {activeTab === 'rendering' && <RenderSection />}
        </div>
      </div>
    </nav>
  );
  }

export default Navbar;