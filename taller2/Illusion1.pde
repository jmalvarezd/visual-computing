PShape cube;

PVector p1;
PVector p13; 

PVector p21 ;
PVector p22 ;
PVector p23 ;
PVector p24 ;
PVector p25 ;
PVector p26 ;
PVector p27 ;

PVector p3; 
PVector p37; 

PVector p4 ;
PVector p5 ;
PVector p56;
PVector p6 ;
PVector p7;
PVector p8 ;

boolean goingRight;
void illusion1(){
  ortho(); //Force an orthogonal perspective, their distance to the camera doesnt affect their size
  directionalLight(128, 128, 128, 1, 1, 0); //we create two lights, the first one directional from the top left
  ambientLight(128, 128, 128); //the second one from everywhere
  translate(width/2,height/2+height/4,0); //We move the shape to the center of the screen
  background(255);
  noStroke();
  scale(3.0); //We make the object bigger
  rotateY(y); //Makes it animated, bouncing from left to right
  rotateX(-PI/12); //makes it show its topside to the camera
  rotateZ(PI/12); //makes it show its topside to the camera
  //TAKEN FROM https://forum.processing.org/two/discussion/26854/how-do-i-fill-a-3d-pshape-cube-with-color
  if(p1==null){ //if the vectors dont exist we create them
    println("Creating Vectors");
    //There is 8 basic points in a cube, p1 to p8, like so
    /*
      p3 - p2
      |  p7 + p6
      p4 + p1 |
         p8 - p5  
    */
    //Yes that was a drawing of a cube, deal with it
    //To draw the cube without one of its corner, we require 7 additional points for the cut curner, p21 to p27
    //To correctly render the cube using QUADS, we requiere 3 additional middle points, p13, p37 and p56
    p1 = new PVector(0, 0, 0);
    p13 = new PVector(-50,0,0); //the vector between point 1 and point 3
    //PVector p2 = new PVector(0, -100, 0); //The basic point that is cut when making the hole
    
    p21 = new PVector(0,-50,0);
    p22 = new PVector(-50,-50,0);
    p23 = new PVector(-50,-100,0);
    p24 = new PVector(-50,-100,-50);
    p25 = new PVector(0,-100,-50);
    p26 = new PVector(0,-50,-50);
    p27 = new PVector(-50,-50,-50);
    
    p3 = new PVector(-100, -100, 0);
    p37 = new PVector(-100, -100, -50); 
    
    p4 = new PVector(-100, 0, 0);
    p5 = new PVector(0, 0, -100); 
    p56 = new PVector(0, -50, -100); 
    p6 = new PVector(0, -100, -100);
    p7 = new PVector(-100, -100, -100);
    p8 = new PVector(-100, 0, -100);
  }
  
  if(cube==null){
    println("Creating cube");
    cube = createShape();
    cube.beginShape(QUADS); //Every four vertex make a face
    cube.fill(0, 25, 255);
    //Do not touch, cursed code ahead
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
    
    //We finally have a cube
    cube.endShape();
    noStroke();
  }  
  noStroke();
  shape(cube);
  if(y>=-0.7){
    if(y==0){
      y=-PI/4; //hell yeah switching notations halfway into the code is what's up
    }
    goingRight = false;
  }
  if(y<=-0.9){
    goingRight = true;
  }
  if(goingRight){
    y+=0.001;
  }
  else{
    y-=0.001;
  }

}
