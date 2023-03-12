import './App.css';
import {useState} from 'react';
//import { useForm } from "react-hook-form";

//This is the main front end file, which renders
//our current page as well as a dummy backend
//call to make sure the services can talk to each other

//Last edited by Nick Velicer, Feb 11

export async function getCSV() {

  try{
      const response = await fetch("http://localhost:8000/api/processedCSV");
      return await response.json();
  }catch(error) {
      return [];
  }
  
}

//the following is temp tutorial code from
//https://www.pluralsight.com/guides/uploading-files-with-reactjs

function TakeCSVForm() {
  const [selectedFile, setSelectedFile] = useState();
  const [isFilePicked, setIsFilePicked] = useState(false);

	const changeHandler = (event) => {
		setSelectedFile(event.target.files[0]);
		setIsFilePicked(true);
	};

  const handleSubmission = async (data) => {
    const formData = new FormData();
    formData.append("file", selectedFile);

    const res = await fetch("http://localhost:8000/api/v2/upload/", {
        method: "POST",
        body: formData,
    }).then((res) => res.json());
    alert(JSON.stringify(`${res.message}, status: ${res.status}`));
  };
  /*
	const handleSubmission = () => {
		const formData = new FormData();
    console.log("in handleSubmission");
		formData.append('File', selectedFile);
		fetch(
			'http://localhost:8000/api/v2/upload/',
			{
				method: 'POST',
				body: formData,
			}
		)
			.then((response) => response.json())
			.then((result) => {
				console.log('Success:', result);
			})
			.catch((error) => {
				console.error('Error:', error);
			});
    
	};
  */
  return(
    <div>
      <form encType="multipart/form-data" onSubmit={(event) => event.preventDefault()}>
      	<input type="file" name="file" onChange={changeHandler} />
	   		<button type= "submit" onClick={handleSubmission}>Submit</button>
	    </form>
        {isFilePicked ? (
				<div>
					<p>Filename: {selectedFile.name}</p>
					<p>Filetype: {selectedFile.type}</p>
					<p>Size in bytes: {selectedFile.size}</p>
					<p>
						lastModifiedDate:{' '}
						{selectedFile.lastModifiedDate.toLocaleDateString()}
					</p>
				</div>
			) : (
				<p>Select a file to show details</p>
			)}
      
    </div>
   )
}  

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
      </div>
      <div id="column2" style={{ float: "right", marginRight: "30%" }}>
        <TakeCSVForm></TakeCSVForm>
      </div>
    </div>
  );
}

export default App;
