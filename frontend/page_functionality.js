/*
Attempted functionality to display the EEG data embedded
as html elements for page visuals, ultimately unsuccessful
but still here just in case we want to try again later

Last edited by
Name: Nick Velicer
Date: mid Octoberish
*/

csv_data = []

//.csv read from:
//https://www.js-tutorials.com/javascript-tutorial/reading-csv-file-using-javascript-html5/

window.onload = () => {
let picker = document.getElementById("file_in");
picker.onchange = () => {
    let selected = picker.files[0];
 
    // (B2) READ CSV INTO ARRAY
    let reader = new FileReader();
    reader.addEventListener("loadend", () => {
      // (B2-1) SPLIT ROWS & COLUMNS
      //added this line to remove quotation marks from keys
      let temp = reader.result.replaceAll('"', '')
      temp = temp.split("\r\n");
      for (let i in temp) {
        temp[i] = temp[i].split(",");
      }
 
      // (B2-2) REARRANGE KEYS & VALUES
      let data = {};
      for (let i in temp[0]) {
        data[temp[0][i]] = [];
        for (let j=1; j<temp.length; j++) {
          data[temp[0][i]].push(temp[j][i]);
        }
      }
 
      // (B2-3) DONE!
      csv_data = data;
    });
    reader.readAsText(selected);
};
};

//Temp implementation of sleep from:
//https://www.sitepoint.com/delay-sleep-pause-wait/
function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

async function showData() {
  for (var i = 0; i < csv_data.AF3.length; i++) {
      //I know there's a better way to do this
      //but it's 2 a.m. and I don't care
      console.log(csv_data.AF3[i]);
      document.getElementById("AF3").innerHTML = csv_data.AF3[i];
      document.getElementById("AF4").innerHTML = csv_data.AF4[i];
      document.getElementById("F3").innerHTML = csv_data.F3[i];
      document.getElementById("F4").innerHTML = csv_data.F4[i];
      document.getElementById("F7").innerHTML = csv_data.F7[i];
      document.getElementById("F8").innerHTML = csv_data.F8[i];
      document.getElementById("FC5").innerHTML = csv_data.FC5[i];
      document.getElementById("FC6").innerHTML = csv_data.FC6[i];
      document.getElementById("O1").innerHTML = csv_data.O1[i];
      document.getElementById("O2").innerHTML = csv_data.O2[i];
      document.getElementById("P7").innerHTML = csv_data.P7[i];
      document.getElementById("P8").innerHTML = csv_data.P8[i];
      document.getElementById("T7").innerHTML = csv_data.T7[i];
      document.getElementById("T8").innerHTML = csv_data.T8[i];
      //adjust this value to make values change slower or faster
      await sleep(210);
  }
}



