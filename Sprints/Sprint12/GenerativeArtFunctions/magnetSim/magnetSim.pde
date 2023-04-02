//Modified Based On: https://openprocessing.org/sketch/92421
//License: https://creativecommons.org/licenses/by-sa/3.0/
int x = 300;
int y = 300;

void setup(){
  size(600,600);
  frameRate(1);
  background(0);
}

void draw(){
  background(0);
  magnetSim(x,y);
}

void magnetSim(int x, int y){
  //setup
  colorMode(RGB,255);
  noiseSeed(int(random(MAX_INT)));
  float[][] magnets = new float[25][25];
  float[][] forces = new float[25][25];
  boolean[][] shown = new boolean[25][25];
  color a = color(random(0,255),random(0,255),random(0,255));
  float b_r = random(0,255);
  float b_g = random(0,255);
  float b_b = random(0,255);
  int threshold = 18;
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
        
        if(shown[i][j]){
          rotate(magnets[i][j]);
          strokeWeight(2*2);
          stroke(b_r*(abs(magnets[i][j]) % 3.14),b_g*(abs(magnets[i][j]) % 3.14),b_b*(abs(magnets[i][j]) % 3.14),255);
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
  
  }
  popMatrix();
}