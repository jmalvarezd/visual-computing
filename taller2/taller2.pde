boolean showIllusion1 = true;
boolean showIllusion2 = true;
boolean showIllusion3 = false;
boolean showIllusion4 = false;
boolean showIllusion5 = false;
boolean showIllusion6 = false;

PGraphics canvas_initial;
float x,y,z;
import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
 
PeasyCam cam;
void setup(){
  x=0;
  y=0;
  z=0;
  textSize(18);
  size(700, 700, P3D);
  background(255);
}

void draw() {
  background(0);
  drawIllusion();
}

void drawIllusion(){
  if(showIllusion1){
    illusion1();
  }
  if(showIllusion2){
    illusion2();
  }
  if(showIllusion3){
    illusion1();
  }
  if(showIllusion4){
    illusion1();
  }
  if(showIllusion5){
    illusion1();
  }
  if(showIllusion6){
    illusion1();
  }
}void mouseClicked(){
  handleMouseClick();
}

void handleMouseClick(){ //Implement these functions if your illusion uses mouseclicks
  if(showIllusion1){
    mcillusion1();
  }
  if(showIllusion2){
    mcillusion2();
  }
  if(showIllusion3){
    mcillusion1();
  }
  if(showIllusion4){
    mcillusion1();
  }
  if(showIllusion5){
    mcillusion1();
  }
  if(showIllusion6){
    mcillusion1();
  }
}
