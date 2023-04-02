void triRays(float x, float y) {  
  // Randomly choose the number of ray sets 3-5
  int sets = round(random(2.5, 5.5));
  // Initialize 2D array to put the properties of each set in
  float[][] props = new float[sets][];
  // Initialize the start to hue range
  float hueStart = random(0,270);
  // Loop to set the properties of each set
  for (int i = 0; i < sets; i++) {
    // Initialize the size of set properties
    props[i] = new float[5];
    // Randomly choose the hue of the set
    props[i][0] = random(hueStart, hueStart + 90);
    // Randomly choose the step size
    props[i][1] = random(2, 5);
    // Set the down angle
    props[i][2] = random(PI/8, 7*PI/16);
    // Set the up angle
    props[i][3] = TWO_PI - random(PI/8, 7*PI/16);
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
      // Set stroke weight
      strokeWeight(1);
      
      // Calculate x, y coords for set at current frame
      float xc = x + fr * step * LRFlag;
      float yd = y + ((fr*step) * tan(angleDown));
      float yu = y + ((fr*step) * tan(angleUp));
      
      // Plot the line
      line(xc, yu, xc, yd);
    }
    
    if (save) {
      // Save frame
      save(str(frame) + ".png");
      // Increment frame num
      frame++;
    }
  }
  
  // Only for testing purposes
  //delay(1000);
}
