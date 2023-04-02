int w = 1920;
int h = 1080;

int frame = 0;
boolean save = false;

Table table;

void settings() {
  size(w, h);
}

void setup() {
  colorMode(HSB, 360);
  
  table = loadTable("output.csv", "csv");
  println(table.getRowCount() + " total rows in table");
  println("There are " + table.getColumnCount() + " columns in the table");
}

void draw() {
  background(0);
  
  stroke(0,0,360,360);
  strokeWeight(2);
  
  int seconds = table.getRowCount();
  float xstep = 1920.0/seconds;
  int count = 0;
  
  for (float s = 0; s < seconds; s+=1) {
    float x = s * xstep;
    float y = (1.0/2560.0)*x*x - (3.0/4.0)*x + 720.0;
    
    point(x,y);
    
    TableRow row = table.getRow(int(s));
    
    float valence = row.getFloat(0);
    float arousal = row.getFloat(1);
    int pnn = row.getInt(2);
    
    PVector v = new PVector(valence-0.5, arousal-0.5);
    float ang = v.heading();
    float mag = v.mag();
    
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
    } else if (randFunc == 8) {
      magnetSim(x,y);
    }
    
    //delay(500);
    println(count);
    println(valence-0.5, arousal-0.5, pnn, ang, mag);
    count++;
  }
  
  noLoop();
}
