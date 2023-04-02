int n = 25;
int x = 300;
int y = 300;
float[][] magnets = new float[n][n];
float[][] forces = new float[n][n];
boolean[][] shown = new boolean[n][n];
int scale = 2;
color a = color(random(0,255),random(0,255),random(0,255));
float b_r = random(0,255);
float b_g = random(0,255);
float b_b = random(0,255);
int threshold = 18;


void setup(){
  size(600,600);
  frameRate(1);
  background(0);
  strokeWeight(2*scale);
  for (int i=0;i<n;i++){
    for (int j=0;j<n;j++){
      magnets[i][j] = random(2*PI);
      forces[i][j] = 0.0;
      shown[i][j] = true;
    }
  }
}

void draw(){
  magnetSim(x,y);
}

void magnetSim(int x, int y){
  
  pushMatrix();
  translate(x-250,y-250);
  for (int itr = 0; itr < 30; itr++) {
  
    for (int i=0;i<n;i++){
      for (int j=0;j<n;j++){
        int score = abs(i-12) + abs(j-12);
        forces[i][j] = 2*(noise(i,j)-.5);
        if(score < random(0,threshold)){
          shown[i][j] = true;
        }else{
          shown[i][j] = false;
        }
      }
    }
  
    for (int i=0;i<n;i++){
      for (int j=0;j<n;j++){
        pushMatrix();
        translate(10*scale*i,10*scale*j);
        
        if(shown[i][j]){
          rotate(magnets[i][j]);
          strokeWeight(2*scale);
          stroke(b_r*(abs(magnets[i][j]) % 3.14),b_g*(abs(magnets[i][j]) % 3.14),b_b*(abs(magnets[i][j]) % 3.14),255);
          line(10*scale,0,0,0);
          if (abs(magnets[i][j]) % 3.14 < .2) {
            stroke(a);
            line(10*scale,0,0,0);
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
