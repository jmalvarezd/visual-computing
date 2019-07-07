import nub.primitives.*;
import nub.core.*;
import nub.processing.*;
Scene scene;
boolean drawAxes = false, bullseye = false;

Node[] lights = new Node[8];
color[] colors = new color[8];
PShape can, sphere;
float angle;
int nlights = 1;

PShader lightShader;
PImage texture;
PImage normalMap;

void setup() {
  size(1000, 700, P3D);
  
  scene= new Scene(this);
  scene.setFrustum(new Vector(0, 0, 0), new Vector(800, 800, 800));
  //scene.togglePerspective();
  scene.fit();
  
  colors[0] = color(255,255, 255); 
  colors[1] = color(255, 97, 3);  
  for(int i = 2;i < 8;i++){
    colors[i] = color(random(255), random(255), random(255));
  }   
  for(int i = 0;i < 8;i++){
    lights[i] = new Sphere(scene, colors[i], 50);
    lights[i].setPosition(new Vector(random(-2*width/4,2*width/4), random(-height/2,height/2), 100));
    lights[i].setPickingThreshold(50);
    lights[i].cull(true);
  }  
  can = createCan(400, 600, 32);
  lightShader = loadShader("lightfrag.glsl", "lightvert.glsl");  
  noStroke();
  sphere = createShape(BOX,500);
  texture = loadImage("brickwall.jpg");
  lightShader.set("textureBrick", texture);
  //normalMap = loadImage("brickwall_normal.jpg");
  //lightShader.set("normalMap", normalMap);

}

void draw() {    
  background(32);
  ambientLight(64, 64, 64);

  shader(lightShader);
  
  for(int i = 0;i < nlights;i++){
    lights[i].cull(false);
    Vector lightv = lights[i].position();
    //lightSpecular(red(colors[i]), green(colors[i]), blue(colors[i]));
    pointLight(red(colors[i]), green(colors[i]), blue(colors[i]), lightv.x(), lightv.y(), lightv.z());
  }
  scene.drawAxes();
  scene.render();

  translate(width/2, height/2);
  //rotateY(angle);  
  fill(0,0,0);
  shape(sphere);
  //shape(can);  
  translate(width/2,0);
  angle += 0.01;
}

PShape createCan(float r, float h, int detail) {
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUAD_STRIP);
  //sh.fill(255, 0, 255);
  sh.noStroke();
  for (int i = 0; i <= detail; i++) {
    float angle = TWO_PI / detail;
    float x = sin(i * angle);
    float z = cos(i * angle);
    float u = float(i) / detail;
    sh.normal(-x, 0, -z);
    sh.vertex(x * r, -h/2, z * r, u, 0);
    sh.vertex(x * r, +h/2, z * r, u, 1);    
  }
  sh.endShape(); 
  return sh;
}

void mouseMoved() {
  scene.cast();
}

void mouseDragged() {
  if (mouseButton == LEFT)
    scene.spin();
  else if (mouseButton == RIGHT)
    scene.translate();
  else
    scene.scale(mouseX - pmouseX);
}
void mouseWheel(MouseEvent event) {
  scene.moveForward(event.getCount() * 20);
}
