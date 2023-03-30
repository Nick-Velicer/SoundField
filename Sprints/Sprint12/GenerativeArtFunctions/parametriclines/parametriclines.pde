// parametric lines 

float t;
float s;
float v;
int index;
float hue;
float sat;
float br;
int i;

void setup() {
  background(255);
  size(500,500);
  index = 0;
  frameRate(10);
  colorMode(HSB, 100);
  t = random(100);
  s = random(100);
  v = random(100);
  hue = random(100);
  sat = random(100);
  br = random(100);
  i = 1;
}

void draw() {
  background(100);
  stroke(0);
  strokeWeight(5);
  
  translate(width/2, height/2);
  
  //stroke(hue, 60, 70);
  
  if(hue > 100) {
    i= i*-1 ;
  }
  if(hue < 0) {
    i= i*-1;
  }
  
  hue = hue+i;
  println(hue);
  createLine(t, 18, hue);
  t++;
  
    
  
  //stroke (200, 15, 170);
  //createLine(s, 10);
  //s++;
  
  //stroke(20, 150, 200);
  //createLine(v, 25);
  //v++;
}

float x1(float t) {
  return sin(t/10) * 100 + sin(t/5)*20;
}

float y1(float t) {
  // recall, inner param controls frequency of wave and outside changes amplitude
  return cos(t/10) * 100;
}

float x2(float t) {
  return sin(t/10) * 200 + sin(t)*2;
}

float y2(float t) {
  // recall, inner param controls frequency of wave and outside changes amplitude
  return cos(t/20) * 200 + cos(t/12)*20;
}

void createLine(float t, int n, float hue) {
  for(int i = 0; i < n; i++) {
    hue = hue+1;
    //gr = gr+1;
    //bl = bl+1;
    //if(hue > 100) {
    //  hue = 0;
    //}
    //else {
    //  hue = hue+1
    //}
    //if(gr > 255) {
    //  gr = 0;
    //}
    //if(bl > 255) {
    //  bl = 0;
    //}
      
    stroke(hue, 60, 70);
    line(x1(t), y1(t), x2(t), y2(t));
    t++;
    
  }
  //t = t-(17);
}
