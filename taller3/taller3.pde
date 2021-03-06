import nub.timing.*;
import nub.primitives.*;
import nub.core.*;
import nub.processing.*;

// 1. Nub objects
Scene scene;
Node node;
Vector v1, v2, v3;
// timing
TimingTask spinningTask;
boolean yDirection;
// scaling is a power of 2
int n = 4;

// 2. Hints
boolean triangleHint = true;
boolean gridHint = true;
boolean debug = true;

// 3. Use FX2D, JAVA2D, P2D or P3D
String renderer = P3D;

// 4. Window dimension
int dim = 9;

void settings() {
  size(int(pow(2, dim)), int(pow(2, dim)), renderer);
}

void setup() {
  scene = new Scene(this);
  if (scene.is3D())
    scene.setType(Scene.Type.ORTHOGRAPHIC);
  scene.setRadius(width/2);
  scene.fit(1);

  // not really needed here but create a spinning task
  // just to illustrate some nub.timing features. For
  // example, to see how 3D spinning from the horizon
  // (no bias from above nor from below) induces movement
  // on the node instance (the one used to represent
  // onscreen pixels): upwards or backwards (or to the left
  // vs to the right)?
  // Press ' ' to play it
  // Press 'y' to change the spinning axes defined in the
  // world system.
  spinningTask = new TimingTask() {
    @Override
    public void execute() {
      scene.eye().orbit(scene.is2D() ? new Vector(0, 0, 1) :
        yDirection ? new Vector(0, 1, 0) : new Vector(1, 0, 0), PI / 100);
    }
  };
  scene.registerTask(spinningTask);

  node = new Node();
  node.setScaling(width/pow(2, n));

  // init the triangle that's gonna be rasterized
  randomizeTriangle();
}

void draw() {
  background(0);
  stroke(0, 255, 0);
  if (gridHint)
    scene.drawGrid(scene.radius(), (int)pow(2, n));
  if (triangleHint)
    drawTriangleHint();
  pushMatrix();
  pushStyle();
  scene.applyTransformation(node);
  triangleRaster();
  popStyle();
  popMatrix();
}

// Implement this function to rasterize the triangle.
// Coordinates are given in the node system which has a dimension of 2^n
void triangleRaster() {
  // node.location converts points from world to node
  // here we convert v1 to illustrate the idea
  if (debug) {
    pushStyle();
    stroke(255, 255, 0, 125);
    rectMode(CENTER);
    strokeWeight(0);
    int leftMost = -1*int(pow(2,n+1)/2); //it's also topmost
    int rightMost = -leftMost;  //it's also bottommost
    float area = pointLeftOfVertex(node.location(v1).x(), node.location(v1).y(), node.location(v2).x(), node.location(v2).y(), node.location(v3).x(), node.location(v3).y());
    for(float i = leftMost; i <= rightMost; i++) {
      for (float j = leftMost; j <= rightMost; j++) {
        Vector point = new Vector(i, j,0);
        float scale = 4;
        int sum = 0;
        float step = 1/scale;
        for (float h = i - (1-step); h <= i + (1-step); h += 2*step) {
          for (float l = j - (1-step); l <= j + (1-step); l += 2*step) {
            Vector subPoint = new Vector(h, l,0);
            if (isPointInsideTriangle(node.location(v1), node.location(v2), node.location(v3), subPoint)) {
              sum += 1; // Weight of subsquares in pixel
            }
          }
        }
        pushStyle();
        float wa = pointLeftOfVertex(node.location(v2).x(), node.location(v2).y(), node.location(v3).x(), node.location(v3).y(), point.x(), point.y()) / area;
        float wb = pointLeftOfVertex(node.location(v3).x(), node.location(v3).y(), node.location(v1).x(), node.location(v1).y(), point.x(), point.y()) / area;
        float wc = pointLeftOfVertex(node.location(v1).x(), node.location(v1).y(), node.location(v2).x(), node.location(v2).y(), point.x(), point.y()) / area;
        float anti = sum / (scale*scale);
        fill(255*wa, 255*wb, 255*wc, 255*anti );
        rect(i, j, 1, 1);
        popStyle();
      }
    }
    popStyle();
  }
}

boolean isPointInsideTriangle(Vector a,Vector b,Vector c,Vector p){
  return  pointLeftOfVertex(a.x(),a.y(),b.x(),b.y(),p.x(),p.y()) > 0 &&
          pointLeftOfVertex(c.x(),c.y(),a.x(),a.y(),p.x(),p.y()) > 0 &&
          pointLeftOfVertex(b.x(),b.y(),c.x(),c.y(),p.x(),p.y()) > 0 ;
}

float pointLeftOfVertex(float ax,float ay,float bx,float by, float px, float py){
  float determinant = ((ay-by)*px)+((bx-ax)*py)+(ax*by-ay*bx);
  return determinant; //If its exactly 0, the triangle is degenerate
}

void randomizeTriangle() {
  int low = -width/2;
  int high = width/2;
  v1 = new Vector(random(low, high), random(low, high));
  v2 = new Vector(random(low, high), random(low, high));
  v3 = new Vector(random(low, high), random(low, high));
  if(pointLeftOfVertex(v1.x(),v1.y(),v2.x(),v2.y(),v3.x(),v3.y()) <= 0){
    //The triangle is wound clockwise, swap two edges
    Vector v4 = v1;
    v1 = v2;
    v2 = v4;
  }
}

void drawTriangleHint() {
  pushStyle();
  noFill();
  strokeWeight(2);
  stroke(255, 0, 0);
  triangle(v1.x(), v1.y(), v2.x(), v2.y(), v3.x(), v3.y());
  strokeWeight(5);
  stroke(0, 255, 255);
  point(v1.x(), v1.y());
  point(v2.x(), v2.y());
  point(v3.x(), v3.y());
  popStyle();
}

void keyPressed() {
  if (key == 'g')
    gridHint = !gridHint;
  if (key == 't')
    triangleHint = !triangleHint;
  if (key == 'd')
    debug = !debug;
  if (key == '+') {
    n = n < 7 ? n+1 : 2;
    node.setScaling(width/pow( 2, n));
  }
  if (key == '-') {
    n = n >2 ? n-1 : 7;
    node.setScaling(width/pow( 2, n));
  }
  if (key == 'r')
    randomizeTriangle();
  if (key == ' ')
    if (spinningTask.isActive())
      spinningTask.stop();
    else
      spinningTask.run(20);
  if (key == 'y')
    yDirection = !yDirection;
}
