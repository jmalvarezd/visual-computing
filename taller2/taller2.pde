int showIllusion = 6; // Change logic with state instead of boolans

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
  drawIllusion();
}

void mouseClicked() {
  handleMouseClick();
}

void drawIllusion(){
  switch(showIllusion) {
    case 1: illusion1(); break;
    case 2: illusion2(); break;
    case 3: illusion3(); break;
    case 4: illusion4(); break;
    case 5: illusion5(); break;
    case 6: illusion6(); break;
    default: break;
  }
}

void handleMouseClick(){ //Implement these functions if your illusion uses mouseclicks
  switch(showIllusion) {
    case 1: doNothing(); break;
    case 2: mcillusion2(); break;
    case 3: mcillusion3(); break;
    case 4: doNothing(); break;
    case 5: doNothing(); break;
    case 6: mcillusion6(); break;
    default: break;
  }
}

void keyPressed() {
  switch(key) {
    case '1': showIllusion = 1; break;
    case '2': drawed = false; showIllusion = 2; break;
    case '3': showIllusion = 3; break;
    case '4': showIllusion = 4; break;
    case '5': showIllusion = 5; break;
    case '6': background(255); showIllusion = 6; break;
    default: showIllusion = 1; break;
  }
}
void doNothing(){
  //I'm a function!
}
