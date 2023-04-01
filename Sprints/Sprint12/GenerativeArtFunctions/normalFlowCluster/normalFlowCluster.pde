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
  normalFlowCluster(x_center, y_center);
  //noLoop();
}

void normalFlowCluster(int x, int y) {
  // Randomly choose color ranges
  int colorChoice = int(random(0,5));
  int colMin, colMax;
  
  if (colorChoice == 0) {        // red to yellow
    colMin = 0;
    colMax = 60;
  } else if (colorChoice == 1) { // blue to light blue
    colMin = 180;
    colMax = 250;
  } else if (colorChoice == 2) { // purple to pink
    colMin = 270;
    colMax = 300;
  } else {                       // green to turquoise
    colMin = 120;
    colMax = 175;
  }
  
  // Set noise scale
  float scl = 0.002;
  
  // Iterate through all 24 frames
  for (int fr = 0; fr < 24; fr++) {
    // Loop through each cluster for frame
    for (int c = 0; c < 3; c++) {
      // Set the center point of the cluster
      float xcluster = randomGaussian() * 60;
      float ycluster = randomGaussian() * 60;
      // Iterate through item in cluster
      for (int i = 0; i < 20; i++) {
        // Set the point around the cluster
        float xoff = randomGaussian() * 10;
        float yoff = randomGaussian() * 10;
        // Calculate the absolute coordinates
        float xc = x + xcluster + xoff;
        float yc = y + ycluster + yoff;
        // Set the perlin noise vector
        float angle = noise(xc*scl, yc*scl) * TWO_PI * 4;
        PVector v = PVector.fromAngle(angle);
        v.setMag(random(6,15));
        // Plot line
        push();
        stroke(random(colMin, colMax), 360, 360, 240);
        translate(xc, yc);
        strokeWeight(2);
        point(0, 0);
        line(0, 0, v.mag() * cos(angle), v.mag() * sin(angle));
        pop();
      }
    }
    
    // Save frame
    
    // Increment frame num
    
  }
  
  // Only for testing purposes
  delay(1000);
}
