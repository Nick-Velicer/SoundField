void diamonds(float x, float y, float hu) {
  int nw = 1;
  int sw = 4;
  float hue = hu; 
  // Each frame in the function
  fill(hue, 300, 360, 180);
  noStroke();
  for (int fr = 0; fr < 24; fr++) {
    for (int i = 0; i < 5; i++) {
      float x_noise = random(-pow(fr+1, 2)*nw, pow(fr+1, 2)*nw);
      float y_noise = random(-pow(fr+1, 2)*nw, pow(fr+1, 2)*nw);
      float vert = random(-pow(24 - fr, 1.1)*sw, pow(24 - fr, 1.1)*sw);
      float horiz = random(-pow(24 - fr, 1.1)*sw, pow(24 - fr, 1.1)*sw);
      quad(x+x_noise+horiz, y+y_noise, x+x_noise, y+y_noise+vert, x+x_noise-horiz, y+y_noise, x+x_noise, y+y_noise-vert);
    }
    
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
