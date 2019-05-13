void illusion5(){
  background(255);
  stroke(0);
  strokeWeight(2);
  float angle = 20;
  hint(DISABLE_OPTIMIZED_STROKE);
  int distanceLeftRight = int(tan(radians(angle))*height);
  int distanceBetweenRectangles = 80;
  //line(0,height,50,0);
  //line(10,height,60,0);
  for (int i = -distanceLeftRight; i < width;i+=20){
    line(i,height,distanceLeftRight+i,0);
  }
  noStroke();
  fill(255,255,0);
  for(int i = 10; i<width + distanceBetweenRectangles; i += distanceBetweenRectangles){
    rect(i,0,mouseX%distanceBetweenRectangles,height);
  }
}
