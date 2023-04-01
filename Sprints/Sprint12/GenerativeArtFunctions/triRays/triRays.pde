int w = 600;
int h = 600;
int x_center = w / 2;
int y_center = h / 2;

void settings() {
  size(w, h);
}

void setup() {
  colorMode(HSB, 360);
}

void draw() {
  background(0);
  triRays(x_center, y_center);
  //noLoop();
}

void triRays(int x, int y) {  
  // Randomly choose the number of ray sets 3-5
  int sets = round(random(2.5, 5.5));
  // Initialize 2D array to put the properties of each set in
  float[][] props = new float[sets][];
  // Loop to set the properties of each set
  for (int i = 0; i < sets; i++) {
    // Initialize the size of set properties
    props[i] = new float[5];
    // Randomly choose the hue of the set
    props[i][0] = random(0, 360);
    // Randomly choose the step size
    props[i][1] = random(2, 5);
    // Set the down angle
    props[i][2] = random(PI/8, 3*PI/8);
    // Set the up angle
    props[i][3] = TWO_PI - random(PI/8, 3*PI/8);
    // Choose if it goes left or right
    if (random(1) > 0.5) { // Right
      // Set the flag
      props[i][4] = 1;
    } else {               // Left
      // Set the flag
      props[i][4] = -1;
    }
  }
  
  // Iterate through all 24 frames
  for (int fr = 0; fr < 24; fr++) {
    // Iterate through each set up rays
    for (int i = 0; i < sets; i++) {
      // Pull all properties for the set
      float hue = props[i][0];
      float step = props[i][1];
      float angleDown = props[i][2];
      float angleUp = props[i][3];
      float LRFlag = props[i][4];
      
      // Set color of set
      stroke(hue, 360, 360, 180);
      
      // Calculate x, y coords for set at current frame
      float xc = x + fr * step * LRFlag;
      float yd = y + ((fr*step) * tan(angleDown));
      float yu = y + ((fr*step) * tan(angleUp));
      
      // Plot the line
      line(xc, yu, xc, yd);
    }
    
    // Save frame
    
    // Increment frame num
    
  }
  
  // Only for testing purposes
  delay(1000);
}
