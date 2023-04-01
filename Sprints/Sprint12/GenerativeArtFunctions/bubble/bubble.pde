int w = 600;
int h = 600;
int nw = 1;
int sw = 4;// 

void settings() {
  size(w, h);
}

void setup() {
  colorMode(HSB, 360);
}

void draw() {
  background(0);
  bubble(300, 300);
  //noLoop();
}

void bubble(int x, int y) {
  // Each frame in the function
  fill(120, 300, 360, 180);
  noStroke();
  for (int fr = 0; fr < 24; fr++) {
    for (int i = 0; i < 5; i++) {
      float x_noise = random(-pow(fr+1, 2)*nw, pow(fr+1, 2)*nw);
      float y_noise = random(-pow(fr+1, 2)*nw, pow(fr+1, 2)*nw);
      float size = random(-pow(24 - fr, 1.1)*sw, pow(24 - fr, 1.1)*sw);
      circle(x + x_noise, y + y_noise, size);
    }
    
    // Save frame
    
    // Increment frame num
  }
  
  // Only for testing purposes
  delay(1000);
}
