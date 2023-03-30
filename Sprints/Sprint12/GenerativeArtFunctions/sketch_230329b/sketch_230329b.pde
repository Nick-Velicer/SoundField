int cols, rows;
int scl = 20;
int w = 1600;
int h = 1200;

float flying = 0;
float[][] terrain;

void setup() {
  size(600, 600, P3D);
  
  cols = w / scl;
  rows = h / scl;
  
  terrain = new float[cols][];
  for (int i = 0; i < cols; i++) {
    terrain[i] = new float[rows];
  }
}

void draw() {
  flying -= 0.1;
  
  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -150, 150);
      xoff += 0.09;
    }
    yoff += 0.09;
  }
  
  background(0);
  stroke(255);
  noFill();
  
  rotateX(PI/3);
  translate(-h/2+100, -w/2+100, -400);
  
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }
}
