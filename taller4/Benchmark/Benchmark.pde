import processing.video.*;

//Media
Movie video;
PImage image;

// Shader!
PShader convShader;

// Masks
int maskSelected = 1;
float[][] edgeDetection = {{0, 1, 0}, {1, -4, 1}, {0, 1, 0}};
float[][] edgeDetection2 = {{-1, -1, -1}, {-1, 8, -1}, {-1,-1,-1}};
float[][] sharpen = {{0, -1, 0}, {-1, 5, -1}, {0,-1,0}};
float[][] boxBlur = {{0.1111, 0.1111, 0.1111}, {0.1111, 0.1111, 0.1111}, {0.1111, 0.1111, 0.1111}};
float[][] gaussianBlur = {{0.0625, 0.125, 0.0625}, {0.125, 0.25, 0.125}, {0.0625, 0.125, 0.0625}};
float[][] gaussianBlur5 = {
  {0.00390625, 0.015625, 0.0234375, 0.015625, 0.00390625}, 
  {0.015625, 0.0625, 0.09375, 0.0625, 0.015625}, 
  {0.0234375, 0.09375, 0.125, 0.09375, 0.0234375}, 
  {0.015625, 0.0625, 0.09375, 0.0625, 0.015625},
  {0.00390625, 0.015625, 0.0234375, 0.015625, 0.00390625}
};

// Load twice video.
int played = 0;

// Use the shader to mask!
boolean shader = false;
boolean showMask = true;
boolean isImage = true;

// Initial frame rate to do a benchmark
int initialFrameRate = 60;

// Benchmark FrameRate
float sumSoftFrameRate = 0;
int aveSoftFrameRate = 0;
float sumGPUFrameRate = 0;
int aveGPUtFrameRate = 0;

//Buttons
Button b1 = new Button(50, 565, 1, "Video");
Button b2 = new Button(200, 565, 1, "Software");
Button b3 = new Button(350, 565, 1, "Edge Detection");
Button b4 = new Button(500, 565, 1, "Edge Detection 2");
Button b5 = new Button(50, 625, 1, "Sharpen");
Button b6 = new Button(200, 625, 1, "Box Blur");
Button b7 = new Button(350, 625, 1, "Gaussian Blur 3x3");
Button b8 = new Button(500, 625, 1, "Gaussian Blur 5x5");

float[][] getMask() {
  switch(maskSelected) {
    case 1: return edgeDetection;
    case 2: return edgeDetection2;
    case 3: return sharpen;
    case 4: return boxBlur;
    case 5: return gaussianBlur;
    case 6: return gaussianBlur5;
    default: return edgeDetection;
  }
}

PImage ConvolutionMask(PImage image, float[][] convolutionMask) {
  PImage image_with_mask;
  image_with_mask = createImage(image.width, image.height, RGB);
  image.loadPixels();
  for(int i = 0; i < image.height; i++){
    for(int j = 0; j < image.width; j++) {
      float avgR = 0, avgG = 0, avgB = 0;
      for(int n = 0; n < convolutionMask.length; n++) {
        for(int m = 0; m < convolutionMask[0].length; m++) {
          int x = i + n - convolutionMask.length/2;
          int y = j + m - convolutionMask.length/2;
          if( x < image.height && x >= 0 && y < image.width && y >= 0) {  
            int index = x * image.width + y;
            avgR += red(image.pixels[index]) * convolutionMask[n][m];
            avgG += green(image.pixels[index]) * convolutionMask[n][m];
            avgB += blue(image.pixels[index]) * convolutionMask[n][m];
          }
        }
      }
      image_with_mask.pixels[i * image.width + j] = color(avgR, avgG, avgB);
    }
  }
  image_with_mask.updatePixels();
  return image_with_mask;
}

void drawResults() {
  pushStyle();
  String title = "Results for ";
  switch(maskSelected) {
    case 1: title += "Edge Dectection"; break;
    case 2: title += "Edge Dectection2"; break;
    case 3: title += "Sharpen"; break;
    case 4: title += "Box Blur"; break; 
    case 5: title += "Gaussian Blur 3x3"; break;
    case 6: title += "Gaussian Blur 5x5"; break;
    default: title += "Edge Dectection";
  }
  
  float hadPorcentage  = sumGPUFrameRate / aveGPUtFrameRate;
  float softPorcentage = sumSoftFrameRate / aveSoftFrameRate;
  
  fill(0);
  textSize(25);
  text(title, 600, 50);
  textSize(20);
  text("By software " + softPorcentage + " %", 600, 150);
  text("By Hadware " + hadPorcentage + " %", 600, 250);
  text("Difference " + (hadPorcentage - softPorcentage) + " %", 600, 350);
  popStyle();
}


void myEoS() {
  if (played == 1) {  
    video.stop();
    played++;
  } else {
    played++;
    shader = true;
  }
}
void initVideo() {
  video.stop();
  played = 0;
  shader = false;
  sumSoftFrameRate = 0;
  aveSoftFrameRate = 0;
  sumGPUFrameRate = 0;
  aveGPUtFrameRate = 0;
  background(120);
  video.loop();
  
}

void keyPressed() {
  handleKeyPress(key);
}

void handleKeyPress(char pressed){
  if(pressed == '1') {
    maskSelected = 1;
    if (!isImage) {
      initVideo();
    }
  }
  if(pressed == '2') {
    maskSelected = 2;
    if (!isImage) {
      initVideo();
    }
  }
  if(pressed == '3') {
    maskSelected = 3;
    if (!isImage) {
      initVideo();
    }
  }
  if(pressed == '4') {
    maskSelected = 4;
    if (!isImage) {
      initVideo();
    }
  }
  if(pressed == '5') {
    maskSelected = 5;
    if (!isImage) {
      initVideo();
    }
  }
  if(pressed == '6') {
    maskSelected = 6;
    if (!isImage) {
      initVideo();
    }
  }
  if(pressed == 's') {
    shader = !shader;
  }
  if(pressed == 'm') {
    showMask = !showMask;
  }
}
void showMedia(PImage image, float x, float y, float iWidth, float iHeight) {
  textureMode(NORMAL); // Normalize the coordinates in texture [0,1]
  PShape wd = createShape();
  wd.beginShape(QUAD_STRIP); // First 4 coordinates generate an rectangle the next two too.
  wd.noStroke();
  wd.texture(image);
  wd.normal(1, 0, 1);
  
  // Create the window (rectangle with 4 vertex)
  wd.vertex(x, y, 1, 0, 0);
  wd.vertex(x+iWidth, y, 1, 1, 0);
  wd.vertex(x, y+iHeight, 1, 0, 1);
  wd.vertex(x+iWidth, y+iHeight, 1, 1, 1);
  
  wd.endShape();
  shape(wd);
}

/* void drawTitle() {
  pushStyle();
  textAlign(CENTER,CENTER);
  textSize(18);
  color(0);
  if (shader) {
    text("Convolution mask by Hadware", 500, 30);
  } else {
    text("Convolution mask by Software", 500, 30);
  }
  popStyle();
} */
void drawButtons() {
  b1.draw();
  b2.draw();
  b3.draw();
  b4.draw();
  b5.draw();
  b6.draw();
  b7.draw();
  b8.draw();
}
void setup() { 
  size(1100, 700, P2D);
  image = loadImage("Leopard.jpg");
  image.loadPixels();
  video = new Movie(this, "Landscape.mp4") {
    @ Override public void eosEvent() {
      super.eosEvent();
      myEoS();
    }
  };
  background(125);
  convShader = loadShader("convfrag.glsl");
  frameRate(initialFrameRate);
}

void draw() {
  if (isImage) {
    background(125);
    drawButtons();
    float aux = frameRate/initialFrameRate*100;
    if (shader) {
      shader(convShader);
      convShader.set("maskSelected", maskSelected);
      convShader.set("showMask", showMask);
      showMedia(image, 50, 50, 500, 500);
    } else {
      image(showMask ? ConvolutionMask(image, getMask()) : image, 50, 50, 500, 500);
    }
    pushStyle();
    resetShader();
    fill(0);
    textSize(20);
    text("Convolution mask by " + ((shader) ? "Hadware" : "Software"), 600, 100);
    text("Frame rate : " + aux + " % ", 600, 150);
    popStyle();
  } else {
    if (played == 2) {
      resetShader();
      drawResults();
      played++;
    }
    if (video.available()) {
       video.read();
       float aux = frameRate/initialFrameRate*100;
       if (shader) {
         shader(convShader);
         convShader.set("maskSelected", maskSelected);
         convShader.set("showMask", showMask);
         showMedia(video, 50, 50, 500, 500);
         sumGPUFrameRate += aux;
         aveGPUtFrameRate++;
       } else {
         image(showMask ? ConvolutionMask(video, getMask()) : video, 50, 50, 500, 500);
         sumSoftFrameRate += aux;
         aveSoftFrameRate++;
       }
    }
  }
}
