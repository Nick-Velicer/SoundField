void curveFunc(float x, float y) {
  colorMode(HSB, 360);
  int dis = int(random(1, 5));
  int xoff = int(random(20, 50));
  int strength_center = int(random(10, 100));
  int strength_edge = int(random(10, 100));
  float hue = random(0, 360);
  
  int right = 1;
  if (random(1) > 0.5) {
    right = -1;
  }
  
  int up = 1;
  if (random(1) > 0.5) {
    up = 0;
  }
  
  for (int fr = 0; fr < 24; fr++) {
    if (fr % 2 == 0) {
      float x_1 = x;
      float y_1 = y;
      float x_2 = x_1 + strength_center * right;
      float y_2 = y_1;
  
      float x_3 = x + ((xoff + (dis * fr)) * right);
      float y_3 = 0 + (h * up);
      float x_4 = x_3;
      float y_4 = strength_edge + ((h - strength_edge) * up);
      
      noFill();
      stroke(hue, 300, 360, 100);
      strokeWeight(1);
      bezier(x_1, y_1, x_2, y_2, x_4, y_4, x_3, y_3);
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
