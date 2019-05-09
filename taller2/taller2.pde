boolean showIllusion1 = true;
boolean showIllusion2 = false;
boolean showIllusion3 = false;
boolean showIllusion4 = false;
boolean showIllusion5 = false;
boolean showIllusion6 = false;

PGraphics canvas_initial;
void setup(){
  textSize(18);
  size(700, 700, P3D);
  background(255);
  canvas_initial = createGraphics(450, 450);
  drawIllusion();
  
}

void drawIllusion(){
  if(showIllusion1){
    illusion1();
  }
  if(showIllusion2){
    illusion1();
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
}
void illusion1(){
  
}
