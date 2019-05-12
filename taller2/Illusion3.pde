int polygonShape = 5;
boolean circleDrawed = false;

void createAPolygon(float x, float y, float r, int sides) {
  pushStyle();
  float angle = TWO_PI / sides;
  beginShape();
  fill(0,0,128);
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * r;
    float sy = y + sin(a) * r;
    vertex(sx, sy);
  }
  endShape(CLOSE);
  beginShape();
  fill(255);
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * (r-25);
    float sy = y + sin(a) * (r-25);
    vertex(sx, sy);
  }
  endShape(CLOSE);
  popStyle();
}
void illusion3() {
  float middleW = width*0.5;
  float middleH = height*0.5;
  background(0);
  if (circleDrawed) {
    fill(255,255,0);
    ellipse(middleW, middleH, 300, 300);
  }
  pushMatrix();
  translate(middleW, middleH);
  rotate(frameCount/25.0);
  createAPolygon(0, 0, 100, polygonShape);
  popMatrix();
  stroke(0);
  line((middleW-2), (middleH-2),(middleW+2), (middleH+2));
  line((middleW-2), (middleH+2),(middleW+2), (middleH-2));
}
void mcillusion3() {
  circleDrawed = !circleDrawed;
}
