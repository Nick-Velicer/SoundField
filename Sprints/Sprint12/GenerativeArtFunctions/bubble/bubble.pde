int w = 600;
int h = 600;
int nw = 1;
int sw = 4;// 

void settings() {
  size(w, h);
}

void setup() {
  colorMode(HSB, 360);
}

void draw() {
  background(0);
  bubble(300, 300);
  //noLoop();
}

void bubble(float x, float y) {
  // Set the colormode
  colorMode(HSB, 360);
  // Randomly choose the number of arms
  int sets = round(random(2.5, 5.5));
  // Initialize 2D array to put the properties of each set in
  float[][] props = new float[sets][];
  // Initialize the start to hue range
  float hueStart = random(0,270);
  // Loop to set the properties of each set
  for (int i = 0; i < sets; i++) {
    // Initialize the size of set properties
    props[i] = new float[2];
    // Randomly choose the hue of the set
    props[i][0] = random(hueStart, hueStart + 90);
    // Set the angle
    props[i][1] = random(0, TWO_PI);
  }
  // Set the step of the arms
  float step = 12.0;
  
  // Each frame in the function
  //fill(random(0,360), 300, 360, 180);
  //noStroke();
  for (int fr = 0; fr < 24; fr++) {
    // Iterate though each set of arms
    for (int i = 0; i < sets; i++) {
      // Pull all properties for the set
      float hue = props[i][0];
      float ang = props[i][1];
      
      // Set color of set
      fill(hue, 360, 360, 180);
      
      // Calculate x, y coords for set at current frame
      PVector vec = PVector.fromAngle(ang);
      vec.setMag(fr*step);
      float xc = x + vec.x;
      float yc = y + vec.y;
      
      // Iterate through the cluster of the set
      for (int c = 0; c < 15; c++) {
        // Set the point around the cluster
        float xoff = xc + randomGaussian() * 80;
        float yoff = yc + randomGaussian() * 80;
        
        // Get Distance from center of cluster
        float dis = sqrt(pow(xc - xoff, 2) + pow(yc - yoff, 2));
        // Get radius of circle based off distance
        float r = 30*exp(-0.02*dis);
        
        // Plot the circle
        fill(hue, 360, 360, 180);
        noStroke();
        circle(xoff, yoff, r);
      }
    }
    
    // Save frame
    
    // Increment frame num
  }
  
  // Only for testing purposes
  delay(1000);
}
