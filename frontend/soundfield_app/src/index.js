import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import Navbar from './NavBar';
import reportWebVitals from './reportWebVitals';


const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <div style={{ display: "flex" }}>
      <div style={{ marginLeft: "9%" }}>
        <h1 className="title">SoundField</h1>
        <h2 className="subtitle">Creating art from the active brain.</h2>
        <h2>_____________________________________</h2>
      </div>
      <div>
        <img src={require('./logo.png')} style={{width: "160px", marginBottom: "-20px", marginLeft: "100px", marginTop: "20px", paddingLeft: "60px", borderLeft: "1px solid white"}} />
      </div>
    </div>
    <Navbar />
  </React.StrictMode>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
