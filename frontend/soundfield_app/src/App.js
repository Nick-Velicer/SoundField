import './App.css';
//import {useState, useEffect} from "react";

//This is the main front end file, which renders
//our current page as well as a dummy backend
//call to make sure the services can talk to each other

//Last edited by Nick Velicer, Feb 11

//temporary new function for trying new front end
function TakeCSVForm(props) {
  return (
    <div style={{ textAlign: "center" }}>
        <h1>Upload a csv file</h1>
        <form>
            <input type={"file"} accept={".csv"} />
        </form>
    </div>
  );
}

//old front end
function App() {
  /*
  const [holder, setData] = useState([]);

  useEffect(() => {
    getData()
  }, [])

  const getData = async() => {
    const response = await fetch("http://localhost:8000/api/v2/");
    setData(await response.json());
  }
  */

  //Main return statement for the actual html
  return (
    <div id="root">
      <TakeCSVForm></TakeCSVForm>
    </div>
  );
}

export default App;
