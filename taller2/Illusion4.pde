int circles = 12;
void illusion4() {
  float heightM = height*0.5;
  float widthM = width*0.5;
  pushMatrix();
  pushStyle();
  background(255);
  translate(heightM, widthM);
  rotate(frameCount/40.0);
  fill(0,0,255);
  noStroke();
  ellipse(0,0, width-width*(1.0/circles), height-height*(1.0/circles));
  boolean dark = false;
  strokeWeight(0.5);
  for ( int i = 2; i < circles; i ++) {
    if(dark) {
      fill(0,0,255);
    } else {
      fill(255,255,0);
    }
    dark = !dark;
    translate(20.6, 20.6);
    ellipse(0,0, width-width*(i*1.0/circles), height-height*(i*1.0/circles));
  }
  popStyle();
  popMatrix();
}
