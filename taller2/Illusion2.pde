int lineW = 9;
int squareW = 59;

void drawLinesToGrid(int lineW, int squareW) {
  drawedLines = true;
  // Draw vertical lines
  pushStyle();
  stroke(225);
  strokeWeight(0);
  fill(229);
  for(int i = squareW/2; i < width; i+=lineW+squareW) {
    rect(i, 0, lineW, height);
  }
  
  //Draw horizontal lines
  for(int i = squareW/2; i < height; i+=lineW+squareW) {
    rect(0, i, width, lineW);
  }
  popStyle();
}

void drawCurveLines(int lineW, int squareW) {
  drawedLines = false;
  pushStyle();
  float completeCycle = TWO_PI*2/float(width);
  float waveSpeed = (width/squareW)/2;
  float amplitude = 14;
  stroke(225);
  strokeWeight(0);
  fill(229);
  // Draw vertical lines
  for(int i = squareW/2; i < width; i+=lineW+squareW) {
    float temps = 0;
    float variationX = 0;
    for (int j = 1; j < height; j++) {
      temps += waveSpeed;
      variationX = sin((j+temps)*completeCycle);
      variationX*=(amplitude*0.2);
      rect((variationX+i), j, lineW, 5);
    }
  }
  //Draw horizontal lines
  for(int i = squareW/2; i < height; i+=lineW+squareW) {
    float temps = 0;
    float variationY = 0;
    for (int j = 1; j < height; j++) {
      temps += waveSpeed;
      variationY = sin((j+temps)*completeCycle);
      variationY*=(amplitude*0.2);
      rect(j, (variationY+i), 5, lineW);
    }
  }
  popStyle();
}
boolean drawedLines = false;
boolean drawed = false;
void illusion2() {
  if(!drawed) {
    background(0);
    drawLinesToGrid(lineW, squareW);
    drawed = true;
  }
}
void mcillusion2() {
  background(0);
  if (drawedLines) {
    drawCurveLines(lineW, squareW);
  } else {
    drawLinesToGrid(lineW, squareW);
  }
}
