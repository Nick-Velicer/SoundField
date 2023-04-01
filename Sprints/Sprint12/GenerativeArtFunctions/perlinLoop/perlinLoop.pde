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
  perlinLoop(x_center, y_center);
  //noLoop();
}

void perlinLoop(int x, int y) {
  // Set random noise seed
  noiseSeed(int(random(MAX_INT)));
  
  // Set perlin noise range
  float noiseMax = 2;
  // Randomly set the hue
  float hue = random(0, 360);
  // Set the radius range
  int minR = 2;
  int maxR = 150;
  // Set the radius step
  int stepR = 4;
  
  // Iterate through all 24 frames
  for (int fr = 0; fr < 24; fr++) {
    
    // Set the color for this frame
    stroke(hue, 360 - (fr*10), 360, 360);
    // No fill on shape
    noFill();
    // Begin Shape
    beginShape();
    // Iterate through all angles in the circle
    for (float a = 0; a < TWO_PI; a+=0.01) {
      // Get the x,y values for tranversing the 
      // 2D noise field in a circle
      float xoff = map(cos(a), -1, 1, 0, noiseMax);
      float yoff = map(sin(a), -1, 1, 0, noiseMax);
      // Get the radius at angle in noise field plus frame step
      float r = map(noise(xoff, yoff), 0, 1, minR, maxR) + fr * stepR;
      // Get the x,y values for the plot
      float xc = x + r * cos(a);
      float yc = y + r * sin(a);
      // Set the vertex
      vertex(xc, yc);
    }
    // Close shape
    endShape(CLOSE);
    
    // Save Frame
    
    // Increment frame num
    
  }
  
  // Only for testing purposes
  delay(1000);
}
