int showIllusion = 4; // Change logic with state instead of boolans

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
    case 5: illusion4(); break;
    case 6: illusion4(); break;
    default: break;
  }
}

void handleMouseClick(){ //Implement these functions if your illusion uses mouseclicks
  switch(showIllusion) {
    case 1: mcillusion1(); break;
    case 2: mcillusion2(); break;
    case 3: mcillusion3(); break;
    case 5: illusion4(); break;
    case 6: illusion4(); break;
    default: break;
  }
}
