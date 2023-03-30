int w = 600;
int h = 600;

void settings() {
  size(w, h);
}

void setup() {
  colorMode(HSB, 360);
}

void draw() {
  //background(0);
  curveFunc(300, 300);
  //noLoop();
}

void curveFunc(int x, int y) {
  background(0);
  
  //noFill();
  //stroke(255, 102, 0);
  //line(120, 80, 320, 20);
  //line(320, 300, 120, 300);
  //stroke(0, 0, 0);
  //bezier(120, 80,  320, 20,  320, 300,  120, 300);
  
  int dis = int(random(1, 5));
  int xoff = int(random(20, 50));
  int strength_center = int(random(10, 100));
  int strength_edge = int(random(10, 100));
  float hue = random(0, 360);
  
  int right = 1;
  if (random(1) > 0.5) {
    right = -1;
  }
  
  int up = 1;
  if (random(1) > 0.5) {
    up = 0;
  }
  
  for (int fr = 0; fr < 24; fr++) {
    if (fr % 2 == 0) {
      continue;
    }
    
    int x_1 = x;
    int y_1 = y;
    int x_2 = x_1 + strength_center * right;
    int y_2 = y_1;

    int x_3 = x + ((xoff + (dis * fr)) * right);
    int y_3 = 0 + (h * up);
    int x_4 = x_3;
    int y_4 = strength_edge + ((h - strength_edge) * up);
    
    noFill();
    stroke(0, 0, 360, 360);
    strokeWeight(1);
    //line(x_1, y_1, x_2, y_2);
    //line(x_3, y_3, x_4, y_4);
    stroke(hue, 300, 360, 100);
    bezier(x_1, y_1, x_2, y_2, x_4, y_4, x_3, y_3);
  }
  delay(1000);
}
