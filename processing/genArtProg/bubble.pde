//void bubble(float x, float y) {
//  colorMode(HSB, 360);
//  int nw = 1;
//  int sw = 4;
//  // Each frame in the function
//  fill(random(0,360), 300, 360, 180);
//  noStroke();
//  for (int fr = 0; fr < 24; fr++) {
//    for (int i = 0; i < 5; i++) {
//      float x_noise = random(-pow(fr+1, 2)*nw, pow(fr+1, 2)*nw);
//      float y_noise = random(-pow(fr+1, 2)*nw, pow(fr+1, 2)*nw);
//      float size = random(-pow(24 - fr, 1.1)*sw, pow(24 - fr, 1.1)*sw);
//      circle(x + x_noise, y + y_noise, size);
//    }
    
//    //println("Frame:", fr);
//    if (save) {
//      // Save frame
//      save("frames/" + str(frame) + ".png");
//      // Increment frame num
//      frame++;
//    }
//  }
  
//  // Only for testing purposes
//  //delay(1000);
//}

void bubble(float x, float y, float hu) {
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
    props[i][0] = hu + randomGaussian() * 5;
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
    
    //println("Frame:", fr);
    if (save) {
      // Save frame
      save("frames/" + str(frame) + ".png");
      // Increment frame num
      frame++;
    }
  }
  
  // Only for testing purposes
  //delay(1000);
}
