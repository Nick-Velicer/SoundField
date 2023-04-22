void worleyLoop(float x, float y, float hu) {
  colorMode(HSB, 360);
  // Set the size of the Worley noise space
  int worleySize = 100;
  // Set the number of points in the Worley noise space
  int pointNum = 10;
  // Initialize array of PVectors for points
  PVector[] points = new PVector[pointNum];
  // Loop through and initialize points in space
  for (int i = 0; i < points.length; i++) {
    points[i] = new PVector(random(worleySize), random(worleySize));
  }
  
  // Randomly set the hue
  float hue = hu;
  // Set the radius range
  int minR = 10;
  int maxR = 140;
  // Set the radius step
  int stepR = 4;
  
  // Iterate through all 24 frames
  for (int fr = 0; fr < 24; fr++) {
    // Set the color for this frame
    stroke(hue - (fr*2), 360, 360 - (fr*10), 180);
    // No fill on shape
    noFill();
    // Begin shape
    beginShape();
    // Iterate through all angles in the circle
    for (float a = 0; a < TWO_PI; a+=0.01) {
      // Get the x,y values for traversing the 
      // 2D Worley noise field in a circle
      float xoff = map(cos(a), -1, 1, 0, worleySize);
      float yoff = map(sin(a), -1, 1, 0, worleySize);
      // Iterate through and get the distances to points
      float[] distances = new float[points.length];
      for (int i = 0; i < points.length; i++) {
        distances[i] = dist(xoff, yoff, points[i].x, points[i].y);
      }
      // Sort distances
      float[] sorted = sort(distances);
      // Get the radius at the angle by mapping min distance
      // in the Worley noise field to the min and max radius 
      // plus the frame step
      float r = map(sorted[0], 0, 80, minR, maxR) + fr * stepR;
      // Get the x,y values for the plot
      float xc = x + r * cos(a);
      float yc = y + r * sin(a);
      // Set the vertex
      vertex(xc, yc);
    }
    // Close shape
    endShape(CLOSE);
    
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
