void rose(float x, float y, float hu) {
  //setup
  float d = random(0,180);
  float n = random(0,20);
  colorMode(HSB,360);
  float h1 = hu + randomGaussian() * 10;
  float h2 = hu + randomGaussian() * 10;
  color c1 = color(h1,360,360);
  color c2 = color(h2,360,360);
  
  //generate
  pushMatrix();
  push();
  translate(x,y);
  
  stroke(c1);
  noFill();
  beginShape();
  strokeWeight(1);
  for (int i = 0; i <= 360; i++) {
    float k = i * d;
    float r = 150 * sin(n*k);
    float x_local = r * cos(k);
    float y_local = r * sin(k);
    vertex(x_local,y_local);
  }
  endShape();
  if (save) {
    for (int i = 0; i < 12; i++) {
      // Save frame
      save("frames/" + str(frame) + ".png");
      // Increment frame num
      frame++;
    }
  }

  noFill();
  stroke(c2, 180);
  strokeWeight(4);
  beginShape();
  for (int i = 0; i <= 360; i++) {
    int k = i;
    float r = 150 * sin(n*k);
    float x_local = r * cos(k);
    float y_local = r * sin(k);
    vertex(x_local,y_local);    
  }
  endShape();
    if (save) {
    for (int i = 0; i < 12; i++) {
      // Save frame
      save("frames/" + str(frame) + ".png");
      // Increment frame num
      frame++;
    }
  }
  
  pop();
  popMatrix();
}
