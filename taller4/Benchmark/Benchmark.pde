import processing.video.*;

//Media
Movie video;
PImage image;
PImage image_with_mask;
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
Button b1 = new Button(25, 565, 1, "Video");
Button b2 = new Button(175, 565, 1, "Hadware");
Button b3 = new Button(325, 565, 1, "Edge Detection");
Button b4 = new Button(475, 565, 1, "Edge Detection 2");
Button b5 = new Button(25, 625, 1, "Sharpen");
Button b6 = new Button(175, 625, 1, "Box Blur");
Button b7 = new Button(325, 625, 1, "Gaussian Blur 3x3");
Button b8 = new Button(475, 625, 1, "Gaussian Blur 5x5");

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


void ConvolutionMask(PImage image, float[][] convolutionMask) {
  if(!isImage) {
    image_with_mask = createImage(image.width, image.height, RGB);
    image.loadPixels();
  }
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
}
String getMaskString() {
  switch(maskSelected) {
    case 1: return "Edge Dectection"; 
    case 2: return "Edge Dectection2";
    case 3: return "Sharpen"; 
    case 4: return "Box Blur";  
    case 5: return "Gaussian Blur 3x3"; 
    case 6: return "Gaussian Blur 5x5"; 
    default: return "Edge Dectection";
  }
}

void drawResults() {
  pushStyle();
  float hadPorcentage  = sumGPUFrameRate / aveGPUtFrameRate;
  float softPorcentage = sumSoftFrameRate / aveSoftFrameRate;
  pushStyle();
  fill(125);
  noStroke();
  rect(0, 0, 1100, 35);
  fill(255);
  textSize(19);
  text("Results for " + getMaskString(), 450, 30);
  text("By software " + softPorcentage + " %", 625, 580);
  text("By Hadware " + hadPorcentage + " %", 625, 600);
  text("Difference " + (hadPorcentage - softPorcentage) + " %", 625, 620);
  text("Choose one mask to start the benchmark", 625, 640);
  popStyle();
}


void myEoS() {
  resetShader();
  if (played == 2 ) {  
    println("Voy a parar");
    video.stop();
    played++;
  } else {
    played++;
    println("Hadware");
    background(125);
    pushStyle();
    fill(125);
    noStroke();
    rect(0, 0, 1100, 35);
    fill(255);
    textSize(19);
    // text("Video with "+ getMaskString() +" mask by Hadware", 350, 30);
    popStyle();
    shader = true;
  }
}
void initVideo() {
  resetShader(); 
  video.stop();
  played = 1;
  shader = false;
  sumSoftFrameRate = 0;
  aveSoftFrameRate = 0;
  sumGPUFrameRate = 0;
  aveGPUtFrameRate = 0;
  video.loop();
  background(125);
  pushStyle();
  textSize(19);
  // text("Video with "+ getMaskString() +" mask by Software", 350, 30);
  popStyle();
}
void mouseReleased(){
  if(b1.click()) {
    b1.isSelected = !b1.isSelected;
    if (b1.isSelected) {
      b1.text = "Imagen";
    } else {
      b1.text = "Video";
    }
    isImage = !isImage;
  }
  if(b2.click()) {
    b2.isSelected = !b2.isSelected;
    if (b2.isSelected) {
      b2.text = "Software";
    } else {
      b2.text = "Hadware";      
    }
    handleKeyPress('s');
  }
  if(b3.click()) {
    handleKeyPress('1');
  }
  if(b4.click()) {
    handleKeyPress('2');
  }
  if(b5.click()) {
    handleKeyPress('3');
  }
  if(b6.click()) {
    handleKeyPress('4');
  }
  if(b7.click()) {
    handleKeyPress('5');
  }  
  if(b8.click()) {
    handleKeyPress('6');
  }
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
  size(1200, 700, P3D);
  image = loadImage("Leopard.jpg");
  image.resize(500, 500);
  image.loadPixels();
  image_with_mask = createImage(image.width, image.height, RGB);
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
    image(image, 25, 50, 550, 500);
    if (shader) {
      shader(convShader);
      convShader.set("maskSelected", maskSelected);
      convShader.set("showMask", showMask);
      showMedia(image, 600, 50, 550, 500);
      resetShader();
    } else {
      if (showMask) {
        ConvolutionMask(image, getMask());
      }
      image(image_with_mask, 600, 50, 550, 500);
    }
    pushStyle();
    textSize(19);
    text("Convolution mask by " + ((shader) ? "Hadware" : "Software") + " for " + getMaskString(), 625, 580);
    text("Frame rate : " + aux + " % ", 625, 600);
    popStyle();
  } else {
    if (played == 0) {
      pushStyle();
      fill(125);
      noStroke();
      rect(610, 550, 600, 200);
      fill(255);
      textSize(19);
      text("Choose one mask to start the benchmark", 625, 580);
      popStyle();
    } else if (played == 3) {
      drawButtons();
      drawResults();
      played++;
    } else if(video.available()) {
       video.read();
       float aux = frameRate/initialFrameRate*100;
       if (shader) {
         shader(convShader);
         convShader.set("maskSelected", maskSelected);
         convShader.set("showMask", showMask);
         showMedia(video, 100, 50, 1000, 500);
         sumGPUFrameRate += aux;
         aveGPUtFrameRate++;
         resetShader();
       } else {
         ConvolutionMask(video, getMask());
         image(image_with_mask,  100, 50, 1000, 500);
         sumSoftFrameRate += aux;
         aveSoftFrameRate++;
       }
    }
  }
}
