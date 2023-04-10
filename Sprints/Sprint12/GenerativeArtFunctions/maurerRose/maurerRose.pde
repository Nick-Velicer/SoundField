int x=300;
int y=300;

void setup(){
  size(600,600);
  frameRate(1);
}

void rose(int x, int y) {
  //setup
  float d = random(0,180);
  float n = random(0,20);
  colorMode(HSB,360);
  color c1 = color(random(0,360),360,360);
  color c2 = color(random(0,360),360,360);
  
  //generate
  pushMatrix();
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
  
  popMatrix();
}

void draw(){
  background(0);
  rose(x,y);
}
