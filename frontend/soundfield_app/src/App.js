import './App.css';
//import {useState, useEffect} from "react";

//This is the main front end file, which renders
//our current page as well as a dummy backend
//call to make sure the services can talk to each other

//Last edited by Nick Velicer, Feb 11

//temporary new function for trying new front end
function TakeCSVForm(props) {
  return (
    <><div id="root">
      <h1 className="title">SoundField</h1>
      <h2 className="subtitle">Creating art from the active brain.</h2>
      <h2 style={{ marginLeft: "9%" }}>_____________________________________</h2>
      <div id="columns" style={{ width: "100%" }}>
        <div id="column1">
          <h1>Our Team:</h1>
          <h2>Anna Burns</h2>
          <h2>Davis Johnson</h2>
          <h2>Zach Misic</h2>
          <h2>Michael Perry</h2>
          <h2>Nick Velicer</h2>
        </div>
        <div id="column2" style={{ float: "right", marginRight: "30%" }}>
          <h1>Upload a csv file</h1>
          <form>
            <input type={"file"} accept={".csv"} />
          </form>
        </div>
      </div>
    
      </div></>
  );
}

//temporary new function for trying new front end
/*function TakeCSVForm(props) {
  return (
    <div style={{ textAlign: "center" }}>
        <h1>Upload a csv file</h1>
        <form>
            <input type={"file"} accept={".csv"} />
        </form>
    </div>
  );
}*/

//old front end
function App() {
  
  /*const [holder, setData] = useState([]);

  useEffect(() => {
    getData()
  }, [])

  const getData = async() => {
    const response = await fetch("http://localhost:8000/api/v2/");
    setData(await response.json());
  }*/
  

  //Main return statement for the actual html
  return (
    <div id="root">
      <TakeCSVForm></TakeCSVForm>
    </div>
  );
}

export default App;
