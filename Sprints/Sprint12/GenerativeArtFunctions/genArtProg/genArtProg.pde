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
  
  FloatList yvals = new FloatList();
  float scl = 0.003;
  noiseSeed(int(random(MAX_INT)));
  for (float s = 0; s < seconds; s+=1) {
     float x = s * xstep;
     yvals.append(map(noise(x*scl), 0, 1, 250, 830));
  }
  
  for (float s = 0; s < seconds; s+=1) {
    float x = s * xstep;
    //float y = (1.0/2560.0)*x*x - (3.0/4.0)*x + 720.0;
    float y = yvals.get(int(s));
    
    point(x,y);
    
    TableRow row = table.getRow(int(s));
    
    float valence = row.getFloat(0);
    float arousal = row.getFloat(1);
    int pnn = row.getInt(2);
    
    PVector v = new PVector(valence-0.5, arousal-0.5);
    float ang = v.heading();
    float mag = v.mag();
    
    float angStep = TWO_PI / 12.0;
    
    float[] colorRange = new float[2];
    float hue = 0.0;
    
    if (pnn == 0) { // Negative
      colorRange[0] = 315;
      colorRange[1] = 405;
      hue = map(mag, 0.0, 0.707, 315, 405);
      if (hue > 360) {
        hue -= 360;
      }
    } else if (pnn == 1) { // Neutral
      colorRange[0] = 225;
      colorRange[1] = 315;
      hue = map(mag, 0.0, 0.707, 225, 315);
    } else if (pnn == 2) { // Positive
      colorRange[0] = 135;
      colorRange[1] = 225; 
      hue = map(mag, 0.0, 0.707, 135, 225);
    }
    
    if (ang < -PI + angStep*1) {
      initBranch(x,y,hue);
    } else if (ang < -PI + angStep*2) {
      magnetSim(x,y,hue);
    } else if (ang < -PI + angStep*3) {
      normalFlowCluster(x,y,hue);
    } else if (ang < -PI + angStep*4) {
      worleyLoop(x,y,hue);
    } else if (ang < -PI + angStep*5) {
      bezierTails(x,y,hue);
    } else if (ang < -PI + angStep*6) {
      perlinLoop(x,y,hue);
    } else if (ang < -PI + angStep*7) {
      curveFunc(x,y,hue);
    } else if (ang < -PI + angStep*8) {
      triRays(x,y,hue);
    } else if (ang < -PI + angStep*9) {
      bubble(x,y,hue);
    } else if (ang < -PI + angStep*10) {
      rose(x,y,hue);
    } else if (ang < -PI + angStep*11) {
      diamonds(x,y,hue);
    } else if (ang < -PI + angStep*12) {
      randomNormalScatter(x,y,hue);
    }
    
    //delay(500);
    println(count);
    //println(valence-0.5, arousal-0.5, pnn, ang, mag);
    count++;
  }
  //delay(500);
  noLoop();
}
