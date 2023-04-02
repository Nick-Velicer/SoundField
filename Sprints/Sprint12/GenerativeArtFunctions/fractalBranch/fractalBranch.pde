int x=300;
int y=300;

void setup(){
  size(600,600);
  frameRate(1);
}

void branch(float rad, color c){
  //params
  float decay = .84;
  float angle = PI/6;
  //color c = color(random(0,360),0,360);
  //run
  stroke(c,rad*2);
  line(0, 0, 0, -rad);
  translate(0, -rad);
  angle = random(angle-(TWO_PI/12), angle+(TWO_PI/12));
  
  if (rad > 4) {
    push();
    rotate(angle);
    branch(rad*decay,c);
    pop();

    push();
    rotate(-angle);
    branch(rad*decay,c);
    pop();
  }
}


void initBranch(int x, int y){
  //setup
  int radius = 40;
  float current_angle = 0;
  colorMode(HSB,360);
  color c = color(random(0,360),360,360);
  
  //generate
  pushMatrix();
  translate(x,y);
  
  stroke(255);
  
  for(int i=0;i<12;i++){
    if(random(0,1)>.3){
      push();
      float randomRotate = random((TWO_PI/12)*-.45, (TWO_PI/12)*.45);
      rotate(current_angle+randomRotate);
      branch(radius,c);
      pop();
    }
    current_angle += TWO_PI/12;
  }
  popMatrix();
}



void draw(){
  background(0);
  initBranch(x,y);
}
