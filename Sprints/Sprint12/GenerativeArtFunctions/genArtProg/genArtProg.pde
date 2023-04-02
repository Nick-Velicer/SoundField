int w = 1920;
int h = 1080;

int frame = 0;
boolean save = false;

void settings() {
  size(w, h);
}

void setup() {
  colorMode(HSB, 360);
  frameRate(24);
}

void draw() {
  background(0);
  
  stroke(0,0,360,360);
  strokeWeight(2);
  
  int seconds = 271;
  int count = 0;
  
  for (float s = 0; s < 1920; s+= 1920.0/seconds) {
    float x = s;
    float y = (1.0/2560.0)*s*s - (3.0/4.0)*s + 720.0;
    
    point(x,y);
    
    int randFunc = int(random(0,9));
    
    if (randFunc == 0) {
      bezierTails(x,y);
    } else if (randFunc == 1) {
      bubble(x,y);
    } else if (randFunc == 2) {
      curveFunc(x,y);
    } else if (randFunc == 3) {
      normalFlowCluster(x,y);
    } else if (randFunc == 4) {
      perlinLoop(x,y);
    } else if (randFunc == 5) {
      randomNormalScatter(x,y);
    } else if (randFunc == 6) {
      triRays(x,y);
    } else if (randFunc == 7) {
      worleyLoop(x,y);
    }
    
    //delay(500);
    println(count);
    count++;
  }
  
  noLoop();
}
