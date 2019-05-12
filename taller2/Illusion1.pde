PShape cube;
void illusion1(){
  //TAKEN FROM https://forum.processing.org/two/discussion/26854/how-do-i-fill-a-3d-pshape-cube-with-color
  directionalLight(128, 128, 128, 1, 1, 0);
  ambientLight(128, 128, 128);
  translate(width/2,height/2+70,400);
  background(0);
  //stroke(255);
  rotateY(y);
  rotateX(-PI/12);
  rotateZ(PI/12);
  
  PVector p1 = new PVector(0, 0, 0);
  PVector p13 = new PVector(-50,0,0);
  //PVector p2 = new PVector(0, -100, 0);
  
  PVector p21 = new PVector(0,-50,0);
  PVector p22 = new PVector(-50,-50,0);
  PVector p23 = new PVector(-50,-100,0);
  PVector p24 = new PVector(-50,-100,-50);
  PVector p25 = new PVector(0,-100,-50);
  PVector p26 = new PVector(0,-50,-50);
  PVector p27 = new PVector(-50,-50,-50);
  
  PVector p3 = new PVector(-100, -100, 0);
  PVector p37 = new PVector(-100, -100, -50); 
  
  PVector p4 = new PVector(-100, 0, 0);
  PVector p5 = new PVector(0, 0, -100); 
  PVector p56 = new PVector(0, -50, -100); 
  PVector p6 = new PVector(0, -100, -100);
  PVector p7 = new PVector(-100, -100, -100);
  PVector p8 = new PVector(-100, 0, -100);
  
  cube = createShape();
  cube.beginShape(QUADS); //Every four vertex make a face
  cube.fill(0, 25, 255);
  cube.vertex(p1.x, p1.y, p1.z);
  cube.vertex(p21.x, p21.y, p21.z);
  cube.vertex(p22.x, p22.y, p22.z);
  cube.vertex(p13.x,p13.y,p13.z);
  
  cube.vertex(p4.x, p4.y, p4.z);
  cube.vertex(p3.x, p3.y, p3.z);
  cube.vertex(p23.x, p23.y, p23.z);
  cube.vertex(p13.x,p13.y,p13.z);
  
  cube.vertex(p1.x, p1.y, p1.z);
  cube.vertex(p21.x, p21.y, p21.z);
  cube.vertex(p56.x, p56.y, p56.z);
  cube.vertex(p5.x, p5.y, p5.z);
  
  cube.vertex(p56.x, p56.y, p56.z);
  cube.vertex(p26.x, p26.y, p26.z);
  cube.vertex(p25.x, p25.y, p25.z);
  cube.vertex(p6.x, p6.y, p6.z);

  
  cube.vertex(p6.x, p6.y, p6.z);
  cube.vertex(p7.x, p7.y, p7.z);
  cube.vertex(p37.x, p37.y, p37.z);
  cube.vertex(p25.x, p25.y, p25.z);
  
  cube.vertex(p3.x, p3.y, p3.z);
  cube.vertex(p7.x, p7.y, p7.z);
  cube.vertex(p24.x, p24.y, p24.z);
  cube.vertex(p23.x, p23.y, p23.z);
 
  cube.vertex(p21.x, p21.y, p21.z);
  cube.vertex(p22.x, p22.y, p22.z);
  cube.vertex(p27.x, p27.y, p27.z);
  cube.vertex(p26.x, p26.y, p26.z);
  
  
  cube.vertex(p22.x, p22.y, p22.z);
  cube.vertex(p23.x, p23.y, p23.z);
  cube.vertex(p24.x, p24.y, p24.z);
  cube.vertex(p27.x, p27.y, p27.z);
  
  
  cube.vertex(p26.x, p26.y, p26.z);
  cube.vertex(p25.x, p25.y, p25.z);
  cube.vertex(p24.x, p24.y, p24.z);
  cube.vertex(p27.x, p27.y, p27.z);
  
 
  cube.vertex(p3.x, p3.y, p3.z);
  cube.vertex(p7.x, p7.y, p7.z);
  cube.vertex(p8.x, p8.y, p8.z);
  cube.vertex(p4.x, p4.y, p4.z);
 
  cube.vertex(p8.x, p8.y, p8.z);
  cube.vertex(p5.x, p5.y, p5.z);
  cube.vertex(p6.x, p6.y, p6.z);
  cube.vertex(p7.x, p7.y, p7.z);
 
  cube.vertex(p8.x, p8.y, p8.z);
  cube.vertex(p4.x, p4.y, p4.z);
  cube.vertex(p1.x, p1.y, p1.z);
  cube.vertex(p5.x, p5.y, p5.z);
  
  cube.endShape();
  noStroke();
  shape(cube);
  if(y>=-0.6){
    y= -1;
  }
  y+=0.001;

}
void mcillusion1(){

}
