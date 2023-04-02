void bubble(float x, float y) {
  int nw = 1;
  int sw = 4;
  // Each frame in the function
  fill(random(0,360), 300, 360, 180);
  noStroke();
  for (int fr = 0; fr < 24; fr++) {
    for (int i = 0; i < 5; i++) {
      float x_noise = random(-pow(fr+1, 2)*nw, pow(fr+1, 2)*nw);
      float y_noise = random(-pow(fr+1, 2)*nw, pow(fr+1, 2)*nw);
      float size = random(-pow(24 - fr, 1.1)*sw, pow(24 - fr, 1.1)*sw);
      circle(x + x_noise, y + y_noise, size);
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
