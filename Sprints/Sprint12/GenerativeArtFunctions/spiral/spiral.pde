int sz = 1080;
int w = sz;
int h = sz;
float step = 0.025;
int len = 540;
int x_center = w/2;
int y_center = h/2;

int t = 0;

float electrode_amp = 35;
float amplitude = 10;

Table table;
int electrode_idx = 0;

void preload() {
  table = loadTable("/Users/michaelperry/Documents/Code/Processing/mandlebrot-2D/assets/S01G1AllChannels.csv", "csv, header");
}
 
void setup() {
  size(1080, 1080);
  colorMode(HSB, len);
  
  preload();
  println(table.getRowCount() + " total rows in table");
  println("There are " + table.getColumnCount() + " columns in the table");
}

void draw() {
  background(0);
  translate(x_center, y_center);
  
  var channel_vals = table.getStringColumn(0);
  
  for (float t = 10; t < len; t += step) {
    var old_idx = electrode_idx;
    var new_idx = old_idx + 1;
    println(t);
    println(float(channel_vals[old_idx]));
    var old_amp = map(float(channel_vals[old_idx]), -electrode_amp, electrode_amp, -amplitude, amplitude);
    var new_amp = map(float(channel_vals[new_idx]), -electrode_amp, electrode_amp, -amplitude, amplitude);
    
    var x_old = cos(t) * (t+old_amp);
    var y_old = sin(t) * (t+old_amp);
    var x_new = cos(t+step) * (t+step+new_amp);
    var y_new = sin(t+step) * (t+step+new_amp);
    
    stroke(t, 0, len);
    strokeWeight(2);
    line(x_old, y_old, x_new, y_new);
    
    electrode_idx += 1;
  }
  
  noLoop();
  //background(51); 
  //fill(255, 204);
  //rect(mouseX, height/2, mouseY/2+10, mouseY/2+10);
  //fill(255, 204);
  //int inverseX = width-mouseX;
  //int inverseY = height-mouseY;
  //rect(inverseX, height/2, (inverseY/2)+10, (inverseY/2)+10);
}
