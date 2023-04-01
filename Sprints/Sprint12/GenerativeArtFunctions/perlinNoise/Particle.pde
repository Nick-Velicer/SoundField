class Particle {
  PVector pos = new PVector(random(599), random(599));
  PVector vel = new PVector(0,0);
  PVector acc = new PVector(0,0);
  float maxspeed = 2.0;
  int h = 0;
  PVector prevPos = pos.copy();
  
  void update() {
    this.vel.add(this.acc);
    this.vel.limit(this.maxspeed);
    this.pos.add(vel);
    this.acc.mult(0);
  }
  
  void follow(PVector[] vectors) {
    int x = floor(this.pos.x / scl);
    int y = floor(this.pos.y / scl);
    int index = x + y * cols;
    PVector force = vectors[index];
    this.applyForce(force);
  }
  
  void applyForce(PVector force) {
    this.acc.add(force); 
  }
  
  void show() {
    stroke(this.h, 255, 255, 25);
    this.h = this.h + 1;
    if (this.h > 255) {
      this.h = 0;
    }
    strokeWeight(1);
    line(this.pos.x, this.pos.y, this.prevPos.x, this.prevPos.y);
    this.updatePrev();
  }
  
  void updatePrev() {
    this.prevPos.x = this.pos.x;
    this.prevPos.y = this.pos.y;
  }
  
  void edges() {
    if (this.pos.x > 600) {
      this.pos.x = 0;
      this.updatePrev();
    }
    if (this.pos.x < 0) {
      this.pos.x = 599;
      this.updatePrev();
    }
    if (this.pos.y > 599) {
      this.pos.y = 0;
      this.updatePrev();
    }
    if (this.pos.y < 0) {
      this.pos.y = 599;
      this.updatePrev();
    }
  }
}
