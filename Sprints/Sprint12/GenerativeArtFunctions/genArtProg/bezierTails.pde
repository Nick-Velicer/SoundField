void bezierTails(float x, float y) {
  colorMode(HSB, 360);
  
  // Initialize the center and outer strength of the curve
  float cStr = random(20,100);
  float oStr = random(50,100);
  // Initialize the center and outer strength steps
  float cStrStep = random(1,5);
  float oStrStep = random(8,13);
  
  // Initialize the angle and distance to outer point
  float angOut = random(0,TWO_PI);
  float oDist = random(200, 350);
  // Initialize the center and outer angles of the curve
  float cAng = random(0,TWO_PI);
  float oAng = random(0,TWO_PI);
  
  // Randomly select the hue
  float hue = random(0,360);
  
  // Iterate through all 24 frames
  for (int fr = 0; fr < 24; fr++) {
    // Set the center points
    float csx = x;
    float csy = y;
    float cex = csx + (cStr + fr*cStrStep) * cos(cAng);
    float cey = csy + (cStr + fr*cStrStep) * sin(cAng);
    // Set the outer points
    float osx = x + oDist * cos(angOut);
    float osy = y + oDist * sin(angOut);
    float oex = osx + (oStr + fr*oStrStep) * cos(oAng);
    float oey = osy + (oStr + fr*oStrStep) * sin(oAng);
    // Plot the bezier curve
    noFill();
    stroke(hue, 360-(fr*5), 360, 360);
    strokeWeight(2);
    bezier(csx, csy, cex, cey, oex, oey, osx, osy);
    
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
