
/**
 * Read text file and output some art
 *
 */

String[] lines;
int index = 0;

float col_hue;
float col_sat;
float col_bright;

void setup() {
  size(640, 360);
  background(0);
  strokeWeight(10);
  colorMode(HSB, 1.0);
  frameRate(12);
  lines = loadStrings("output_file.txt");
}

void draw() {
  if (index < lines.length) {
    String[] pieces = split(lines[index], ',');
    if (pieces.length == 3) {
      // Scale the coordinates to match the size of the sketch window
      float x = map(float(pieces[1]),0,1,0,width);
      float y = map(float(pieces[2]),0,1,0,height);
      //println(x, y);
      col_hue = float(pieces[1]);
      col_sat = float(pieces[2]);
      stroke(col_hue, col_sat, 0.6);
      point(x, y);
     
    }
    // Go to the next line for the next run through draw()
    index = index + 1;
  }
}
