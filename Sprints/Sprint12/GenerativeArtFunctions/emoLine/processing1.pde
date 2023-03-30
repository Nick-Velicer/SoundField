/**
 * Read text file and output some art
 *
 */

String[] lines;
int index = 0;

float rd;
float gr;
float bl;
float time; 
float valence;
float arousal;
float lineStartX; 
float lineStartY;
float lineEndX;
float lineEndY;
float timeMap;
float prevX;
float prevY;
float y;


void setup() {
  size(640, 360);
  background(0);
  strokeWeight(5);
  //colorMode(RGB, 1.0);
  frameRate(8);
  lineStartX = 0;
  lineStartY = 200;
  lineEndX = 0;
  lines = loadStrings("output_file.txt");
  rd = 0.5;
  gr = 0.5;
  bl = 0.5;
  y = 0;
}

void draw() {
  //background(0);
  if (index < lines.length) {
    String[] pieces = split(lines[index], ',');
      if (pieces.length == 3) {
        prevX = time;
        prevY = y;
        // Scale the coordinates to match the size of the sketch window
        float x = map(float(pieces[1]),0,1,0,width);
        //stroke(0.83, 0.01, 0.4);
        //setVars(pieces);
        //println(x, y);
        setVars(pieces);
        
        //stroke(0.83, 0.01, 0.4);
        //println(bl, gr, rd);
        stroke(rd, gr, bl);
        println(prevX, prevY, time, y);
        line(prevX, prevY, time, y);
        //point(time, y);
        //createCurve(time, y, index);
       
      }
    //lineEndX = lineStartX;
    //lineEndY = lineStartY;
    //line(lineStartX, lineStartY, lineEndX, lineEndY);
    //lineStartX = lineEndX;
    //lineStartY = lineEndY;
    //createLine(lineEndX, lineEndY, index);
    // Go to the next line for the next run through draw()
    index = index + 1;
  }
}

void createLine(float lineEndX, float lineEndY, float index) {
  noFill();
  beginShape();
  vertex(index, 300); //first point 
  //bezierVertex((100*valence), (25*arousal), (100*arousal), (50*valence), lineEndX, lineEndY);
  bezierVertex((100+index), (25+index), (100+index), (50+index), lineEndX, lineEndY);
  endShape();
}

void setVars(String[] pieces) {
  // Scale the coordinates to match the size of the sketch window
      //float x = map(float(pieces[1]),0,1,0,width);
      //float y = map(float(pieces[2]),0,1,0,height);
      
      time = float(pieces[0]);
      valence = float(pieces[1]);
      arousal = float(pieces[2]);
      timeMap = map(float(pieces[0]),0,1,0,1);
      
      y = map(float(pieces[2]),0,1,0,height);
      
      bl = 255- (timeMap*0.1);
      gr = 255 - (200*arousal);
      rd = 100 + (100*arousal);
      //println(bl, gr, rd);
      
}

//void createCurve(float X, float Y, int index) {
//  if(index == 0) {
//    beginShape();
//    curveVertex(X,Y);
//    curveVertex(X,Y);
//    println("start");
//    endShape();
//  }
//  else if (index == lines.length-2) {
//    beginShape();
//    curveVertex(X,Y);
//    curveVertex(X,Y);
//    endShape();
//    println("end");
//  }
//  else {
//    beginShape();
//    curveVertex(X,Y);
//    println(X, Y);
//    endShape();
//  }
//}

//float x(float valen
 
