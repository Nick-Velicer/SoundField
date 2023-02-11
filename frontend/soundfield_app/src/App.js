import './App.css';
import {useState, useEffect} from "react";

//This is the main front end file, which renders
//our current page as well as a dummy backend
//call to make sure the services can talk to each other

//Last edited by Nick Velicer, Feb 11

function App() {

  const [holder, setData] = useState([]);

  useEffect(() => {
    getData()
  }, [])

  const getData = async() => {
    const response = await fetch("http://localhost:8000/api/v2/");
    setData(await response.json());
  }

  //Main return statement for the actual html
  return (
    <div id="root">
      <h1 className="title">SoundField</h1>
      <h2 className="subtitle">Creating art from the active brain.</h2>
      <h2 style={{marginLeft: "9%"}}>_____________________________________</h2>
      <div id="columns" style={{width: "100%"}}>
          <div id="column1">
              <h1 style={{marginBottom: "20px"}}>Our Data:</h1>
              <video src={"Videos/EEGBaseAnimation.mp4"} width="600" height="200" autoPlay={true} muted={true} type="video/mp4"/>
              <h1>Our Team:</h1>
              <h2>Anna Burns</h2>
              <h2>Davis Johnson</h2>
              <h2>Zach Misic</h2>
              <h2>Michael Perry</h2>
              <h2>Nick Velicer</h2>
          </div>
          <div id="column2" style={{float: "right", marginRight: "10%"}}>
              <h1 style={{marginTop: "-2px"}}>Our Art:</h1>
              <video src={"Videos/harmonograph.mp4"} width="480" height="480" autoPlay={true} muted={true} type="video/mp4"/>
          </div>
      </div>
      <p style={{color: "white"}}>Temporary API testing:</p>
      <ol>
        <li>{holder.idNum}</li>
        <li>{holder.ch1}</li>
      </ol>
    </div>
  );
}

export default App;
