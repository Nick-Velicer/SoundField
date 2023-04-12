import './App.css';
import {useState} from 'react';
//import {useEffect} from 'react';
import { Button, CircularProgress } from '@material-ui/core';

//import 'child_process';
//import 'electron';

//This is the main front end file, which renders
//our current page as well as any API calls to pass
//csv data around

//Last edited by Nick Velicer, March 22


//the following is temp tutorial code from
//https://www.pluralsight.com/guides/uploading-files-with-reactjs


function TakeCSVForm() {
  //handlers for showing and uploading the file
  const [selectedFile, setSelectedFile] = useState();
  const [isFilePicked, setIsFilePicked] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  //const { ipcRenderer } = require("electron");

	const changeHandler = (event) => {
		setSelectedFile(event.target.files[0]);
		setIsFilePicked(true);
	};

  const handleSubmission = (event) => {
    setIsLoading(true);
    const formData = new FormData();
    formData.append('file', selectedFile);
    fetch("http://localhost:8000/api/v2/upload/", {
      method: 'POST',
      body: formData,
    })
    .then(response => response.blob())
    .then(blob => {
      //processing the returned response and extracting the file
      const url = window.URL.createObjectURL(new Blob([blob]));
      const link = document.createElement('a');
      link.href = url;
      link.setAttribute('download', 'output.csv');
      document.body.appendChild(link);
      link.click();
      setIsLoading(false);
      //ipcRenderer.send("runScript");
    });
  };
  return(
    <div>
      <form encType="multipart/form-data" onSubmit={(event) => event.preventDefault()}>
      	<input type="file" name="file" onChange={changeHandler} />
        {!isLoading ? (
          <Button variant="contained" color="default" onClick={handleSubmission} disabled={isLoading}>Submit</Button>

        ) : (
         <CircularProgress/>
        )}
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

function UploadSection() {

  return (
    <div id="root" style={{ marginTop: "10%" }}>
      <TakeCSVForm></TakeCSVForm>
    </div>
  );
}

export default UploadSection;
