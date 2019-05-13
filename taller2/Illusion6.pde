int lengthOfArrows;
PShape movingArrow;
int centerLastClicked;

void illusion6(){
  pushStyle();
  fill(255);
  noStroke();
  rect(width/4,height/3-20,300,50);
  popStyle();
  fill(0,0,255);
  textSize(20);
  textAlign(CENTER);
  text("Click the center of the line", width/2,height/3);
  stroke(0,0,255);
  strokeWeight(5);
  lengthOfArrows = 50;
  line(width/5,height/2,width*(4.0/5.0),height/2);
  line(width/5-lengthOfArrows,height/2-lengthOfArrows,width/5,height/2);
  line(width/5-lengthOfArrows,height/2+lengthOfArrows,width/5,height/2);
  line(width*(4.0/5.0)-lengthOfArrows,height/2-lengthOfArrows,width*(4.0/5.0),height/2);
  line(width*(4.0/5.0)-lengthOfArrows,height/2+lengthOfArrows,width*(4.0/5.0),height/2);
}
void mcillusion6(){
  background(255);
  centerLastClicked = mouseX;
  movingArrow = createShape();
  movingArrow.beginShape(LINES);
  movingArrow.vertex(mouseX+lengthOfArrows,height/2-lengthOfArrows);
  movingArrow.vertex(mouseX,height/2);
  movingArrow.vertex(mouseX+lengthOfArrows,height/2+lengthOfArrows,mouseX,height/2);
  movingArrow.vertex(mouseX,height/2);
  movingArrow.endShape();
  shape(movingArrow);
  int distanceToCenter = abs((centerLastClicked - width/2)/2);
  textAlign(CENTER);
  text("You are off by " + distanceToCenter + "%", width/2,height*(3.0/4.0));
  pushStyle();
  stroke(0,255,0);
  point(width/2,height/2+10);
  popStyle();
}
