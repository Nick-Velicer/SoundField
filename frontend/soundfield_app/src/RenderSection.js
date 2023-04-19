import React, { useState, useEffect } from 'react';
import './App.css';

function RenderSection() {
  const [activeTab, setActiveTab] = useState('none'); // Default render state is 'none'

  const handleRenderState = (tab) => {
    setActiveTab(tab);
  }

  useEffect(() => {
    const filePath = "rendering.txt"; // replace with paths in /local later
    fetch(filePath)
      .then((response) => {
        if (response.ok) {
          setActiveTab("rendering");
        }
        else {
          setActiveTab("none");
        }
      })
      .catch(() => setActiveTab("none"));
    //repeat this for other file checks to see which page we should upload
  }, []);

  return (
    <div>
      {activeTab === 'none' && <NoRender />}
      {activeTab === 'rendering' && <Rendering />}
      {activeTab === 'complete' && <FinishedRender />}
    </div>
  );
}

function NoRender() {
  return <p>Render process not started. If you have sent in a CSV, make sure it is placed in Soundfield's "local" folder</p>;
}

function Rendering() {
  return <p>Currently rendering, this will refresh with the final output.</p>;
}

function FinishedRender() {
  return <p>Finished render video goes here</p>;
}

export default RenderSection;