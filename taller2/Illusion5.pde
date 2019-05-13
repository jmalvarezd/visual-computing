void illusion5(){
  background(255);
  stroke(0);
  hint(ENABLE_DEPTH_TEST);
  int distanceLeftRight = 100;
  int distanceBetweenRectangles = 200;
  //line(0,height,50,0);
  //line(10,height,60,0);
  for (int i = -distanceLeftRight; i < width;i+=10){
    line(i,height,distanceLeftRight+i,0);
  }
  noStroke();
  fill(255,255,0);
  for(int i = 0; i<width + distanceBetweenRectangles; i += distanceBetweenRectangles){
    rect(i,0,mouseX%distanceBetweenRectangles,height);
  }
}
