import java.util.*;

Random g;
int x,y,w,h;
int global_counter;

void setup(){
  size(600,600);
  frameRate(1);
  g= new Random();
  x=300;
  y=300;
  global_counter = 1;
  y=height/2;
}

//
//Vertical Dots
void beginvertDots(int xCo, int yCo) {
  dotsUp(xCo, yCo, global_counter);
  dotsDown(xCo, yCo, global_counter);
  return;
}
void dotsDown(int xCo, int yCo, int counter) {
  if(counter<=0){return;}
  int neg = xCo;
  for(int v=0;v<40;v+=4){
    xCo = xCo + counter/2;
    neg = neg - counter/2;
    ellipse(xCo,yCo+v,5,5);
    ellipse(neg,yCo+v,5,5);
  }
  dotsDown(xCo, yCo+20, counter-1);
  dotsDown(neg, yCo+20, counter-1);
  return;
}
void dotsUp(int xCo, int yCo, int counter) {
  if(counter<=0){return;}
  int neg = xCo;
  for(int v=0;v<40;v+=4){
    xCo = xCo + counter/2;
    neg = neg - counter/2;
    ellipse(xCo,yCo-v,5,5);
    ellipse(neg,yCo-v,5,5);
  }
  dotsUp(xCo, yCo-20, counter-1);
  dotsUp(neg, yCo-20, counter-1);
  return;
}

void draw(){
  //int direction = 1;
  //x=x+direction;
  //if(x>width || x<0){direction *= -1;}
  //w=g.nextInt(width/3);
  //h=g.nextInt(height/3);
  beginvertDots(x,y);
  global_counter+=1;
  
}
