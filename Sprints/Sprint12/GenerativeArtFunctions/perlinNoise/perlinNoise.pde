float inc = 0.2;
float scl = 20;
int cols, rows;

float zoff = 0;

ArrayList<Particle> particles = new ArrayList<Particle>();
PVector[] flowfield;

void setup() {
  size(600, 600);
  colorMode(HSB, 255);
  cols = floor(600 / scl);
  rows = floor(600 / scl);
  
  flowfield = new PVector[cols * rows];
  
  for (int i = 0; i < 1000; i++) {
    particles.add(new Particle());
  }
  background(255);
}

void draw() {
  
  float yoff = 0;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      int index = x + y * cols;
      float angle = noise(xoff, yoff, zoff) * TWO_PI * 4;
      PVector v = PVector.fromAngle(angle);
      v.setMag(0.25);
      flowfield[index] = v;
      xoff += inc;
      stroke(0, 50);
      //push();
      //translate(x * scl, y * scl);
      //rotate(v.heading());
      //strokeWeight(1);
      //line(0, 0, scl, 0);
      //pop();
    }
    yoff += inc;
  }
  zoff += 0.002;
  
  for (int i = 0; i < particles.size(); i++) {
    particles.get(i).follow(flowfield);
    particles.get(i).update();
    particles.get(i).edges();
    particles.get(i).show();
  }
}
