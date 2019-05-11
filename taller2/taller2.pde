boolean showIllusion1 = false;
boolean showIllusion2 = false;
boolean showIllusion3 = true;
boolean showIllusion4 = false;
boolean showIllusion5 = false;
boolean showIllusion6 = false;

PGraphics canvas_initial;
void setup(){
  textSize(18);
  size(700, 700, P3D);
  background(255);
  canvas_initial = createGraphics(450, 450);  
}

void draw() {
  drawIllusion();
}

void mouseClicked() {
  if (showIllusion2) {
    if (drawedLines ) {
      background(0);
      drawCurveLines(lineW, squareW);
    } else {
      background(0);
      drawLinesToGrid(lineW, squareW);
    }
  }
  if (showIllusion3) {
    circleDrawed = !circleDrawed;
  }
}

void drawIllusion(){
  if(showIllusion1){
    illusion1();
  }
  if(showIllusion2){
    illusion2();
  }
  if(showIllusion3){
    illusion3();
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
}
void illusion1(){
  
}