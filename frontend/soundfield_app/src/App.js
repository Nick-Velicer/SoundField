import './App.css';

function App() {
  return (
    <div id="root">
      <h1 class="title">SoundField</h1>
      <h2 class="subtitle">Creating art from the active brain.</h2>
      <h2 style={{marginLeft: "9%"}}>_____________________________________</h2>
      <div id="columns" style={{width: "100%"}}>
          <div id="column1">
              <h1 style={{marginBottom: "20px"}}>Our Data:</h1>
              <h1>Our Team:</h1>
              <h2>Anna Burns</h2>
              <h2>Davis Johnson</h2>
              <h2>Zach Misic</h2>
              <h2>Michael Perry</h2>
              <h2>Nick Velicer</h2>
          </div>
          <div id="column2" style={{float: "right", marginRight: "10%"}}>
              <h1 style={{marginTop: "-2px"}}>Our Art:</h1>
          </div>
      </div>
    </div>
  );
}

export default App;
