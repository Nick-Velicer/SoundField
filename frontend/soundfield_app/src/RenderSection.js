import './App.css';

function RenderSection() {
  
  return (
    <div>
      <p>Your rendering will appear below once complete.</p>
      <p>If it fails to import here, the final video can also be found at:</p>
      <p>*Soundfield Directory*/frontend/soundfield_app/src/output.mp4</p>
      <video src="output.mp4" autoplay muted loop/>
    </div>
  );
}

export default RenderSection;