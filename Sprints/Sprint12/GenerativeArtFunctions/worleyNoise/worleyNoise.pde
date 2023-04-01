PVector[] points = new PVector[10];

void setup() {
  size(600, 600);
  
  for (int i = 0; i < points.length; i++) {
    points[i] = new PVector(random(width), random(height));
  }
}

void draw() {
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      
      float[] distances = new float[points.length];
      for (int i = 0; i < points.length; i++) {
        distances[i] = dist(x, y, points[i].x, points[i].y);
      }
      int n = 0;
      float[] sorted = sort(distances);
      float noise = map(sorted[n], 0, 200, 255, 0);
      int index = x + y * width;
      pixels[index] = color(noise);
    }
  }
  updatePixels();
}
