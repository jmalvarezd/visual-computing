
void drawLinesToGrid(int lineW, int squareW) {
  // Draw vertical lines
  pushStyle();
  stroke(225);
  for(int i = squareW/2; i < width; i+=lineW+squareW) {
    rect(i, 0, lineW, height);
  }
  
  //Draw horizontal lines
  for(int i = squareW/2; i < height; i+=lineW+squareW) {
    rect(0, i, width, lineW);
  }
  popStyle();
}
boolean drawed = true;
void illusion2() {
  if (drawed) {
    background(0);
    drawLinesToGrid(10, 40);
    drawed = false;
  }
}
