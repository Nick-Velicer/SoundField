void randomNormalScatter(float x, float y) {
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
  
  for (int fr = 0; fr < 24; fr++) {
    for (int i = 0; i < 100; i++) {
      float xoff = randomGaussian() * 60;
      float yoff = randomGaussian() * 60;
      
      float xc = x + xoff;
      float yc = y + yoff;
      
      stroke(random(colMin,colMax),360,360,240);
      strokeWeight(int(random(2,6)));
      point(xc, yc);
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
