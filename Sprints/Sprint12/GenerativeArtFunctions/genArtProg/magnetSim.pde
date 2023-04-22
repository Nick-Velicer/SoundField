void magnetSim(float x, float y, float hu){
  //setup
  colorMode(HSB,360);
  noiseSeed(int(random(MAX_INT)));
  float[][] magnets = new float[25][25];
  float[][] forces = new float[25][25];
  boolean[][] shown = new boolean[25][25];
  color a = color(hu+randomGaussian()*10,random(0,255),random(0,255));
  color b = color(hu,random(0,360),random(0,360));
  int threshold = 8;
  strokeWeight(4);
  for (int i=0;i<25;i++){
    for (int j=0;j<25;j++){
      magnets[i][j] = random(2*PI);
      forces[i][j] = 0.0;
      shown[i][j] = true;
    }
  }
  
  //generate
  pushMatrix();
  translate(x-250,y-250);
  for (int itr = 0; itr < 120; itr++) {
  
    for (int i=0;i<25;i++){
      for (int j=0;j<25;j++){
        int score = abs(i-12) + abs(j-12);
        forces[i][j] = 2*(noise(i,j)-.5);
        if(score < threshold){
          shown[i][j] = true;
        }else{
          shown[i][j] = false;
        }
      }
    }
    for (int i=0;i<25;i++){
      for (int j=0;j<25;j++){
        pushMatrix();
        translate(10*2*i,10*2*j);
        int score = abs(i-12) + abs(j-12);
        
        if(shown[i][j]){
          rotate(magnets[i][j]);
          strokeWeight(2*2);
          stroke(hue(b)*(abs(magnets[i][j]) % 3.14),saturation(b)*(abs(magnets[i][j]) % 3.14),brightness(b)*(abs(magnets[i][j]) % 3.14),255-score*31);
          line(10*2,0,0,0);
          if (abs(magnets[i][j]) % 3.14 < .2) {
            stroke(a);
            line(10*2,0,0,0);
          }
        }
        if (i<9) {forces[i][j] -= magnets[i][j] - magnets[i+1][j];}
        if (i>0) {forces[i][j] -= magnets[i][j] - magnets[i-1][j];}
        if (j<9) {forces[i][j] -= magnets[i][j] - magnets[i][j+1];}
        if (j>0) {forces[i][j] -= magnets[i][j] - magnets[i][j-1];}
        magnets[i][j] += 0.3*forces[i][j];
        
        popMatrix();
      }
    }
    
    if ((itr + 1) % 5 == 0) {
      if (save) {
        // Save frame
        save("frames/" + str(frame) + ".png");
        // Increment frame num
        frame++;
      }
    }
  }
  popMatrix();
}
