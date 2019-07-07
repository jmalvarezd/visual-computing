PShape can;
float angle;

PShader lightShader;

void setup() {
  size(1000, 800, P3D);
  can = createCan(100, 200, 32);
  lightShader = loadShader("lightfrag.glsl", "lightvert.glsl");
}

void draw() {    
  background(0);
  float x1,y1,z1;

  shader(lightShader);
  ambientLight(100,100,100);
  x1 = width/2;
  y1 = 1.5*height/4.0;
  z1 = 200;
  pushMatrix();
  translate(x1, y1, z1);
  fill(255,255,0);
  noStroke();
  //sphere(10);
  popMatrix();
  //pointLight(255, 0, 0, x1, y1, -z1);
  pointLight(0, 255, 0,0, height/2, 0);
  // pointLight(0, 255, 0, width/2, height, 200);


  translate(width/2, height/2);
  rotateY(angle);  
  fill(0,0,0);
  shape(can);  
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
    sh.normal(x, 0, z);
    sh.vertex(x * r, -h/2, z * r, u, 0);
    sh.vertex(x * r, +h/2, z * r, u, 1);    
  }
  sh.endShape(); 
  return sh;
}
