import processing.video.*;

PGraphics canvas_initial;
PGraphics canvas_trans;

PImage image;
Movie video;

int maskSelected = 1;
float[][] edgeDetection = {{0, 1, 0}, {1, -4, 1}, {0,1,0}};
float[][] edgeDetection2 = {{-1, -1, -1}, {-1, 8, -1}, {-1,-1,-1}};
float[][] sharpen = {{0, -1, 0}, {-1, 5, -1}, {0,-1,0}};
float[][] boxBlur = {{0, -1, 0}, {-1, 5, -1}, {0,-1,0}};
float[][] gaussianBlur = {{0.1111, 0.1111, 0.1111}, {0.1111, 0.1111, 0.1111}, {0.1111, 0.1111, 0.1111}};
// int[][] gaussianBlur5 = {{1/9, 1/9, 1/9}, {1/9, 1/9, 1/9}, {1/9,1/9,1/9}};

boolean showImage = true;
boolean showGray = false;
boolean showMask = false;
boolean showHisto = false;

int[] heightsOfBars = new int[256];
int starting = 550;
int ending = 1000;

float[][] getMask() {
  switch(maskSelected) {
    case 1: return edgeDetection;
    case 2: return edgeDetection2;
    case 3: return sharpen;
    case 4: return boxBlur;
    case 5: return gaussianBlur;
    default: return edgeDetection;
  }
}

void chargeMedia(boolean media, PGraphics canvas) {
  canvas.beginDraw();
  if(media) {
    image = loadImage("Leopard.jpg");
    image.loadPixels();
    canvas.image(image, 0, 0, 450, 450);
  } else {
    video = new Movie(this, "Landscape.mp4");
    canvas.image(video, 0, 0, 450, 450);
    video.play();
  }
  canvas.endDraw();
  image(canvas, 50, 50);
}

void setup() {
  size(1050, 600);
  canvas_initial = createGraphics(450, 450);
  canvas_trans = createGraphics(450, 450);
  chargeMedia(showImage, canvas_initial);
}


void ScaleOfGray(PGraphics canvas, PImage image) {
  canvas.beginDraw();
  PImage image_gray;
  image_gray = createImage(image.width, image.height, RGB);
  image_gray.loadPixels();
  for (int i = 0; i < image.pixels.length; i++) {
    float green = green(image.pixels[i]);
    float blue = blue(image.pixels[i]);
    float red = red(image.pixels[i]);
    image_gray.pixels[i] = color((green + blue + red)/3);
  }
  image_gray.updatePixels();
  canvas.image(image_gray, 0, 0, 450, 450);
  canvas.endDraw();
  image(canvas, 550, 50);
}

void showHistogram(PGraphics canvas, PImage image, boolean redrawSection){
  canvas.beginDraw();
  PImage image_duplicate;
  image_duplicate = createImage(image.width, image.height, RGB);
  int startingMapped = 0, endingMapped=255;
  color redrawColor= color(0);
  if(redrawSection){
    startingMapped = int(map(starting, 550, 1000, 0, 255));
    endingMapped = int(map(ending, 550, 1000, 0, 255));
    redrawColor = color(0,255,0);
  }
  //Duplicate the image. If this is a redraw, show only the selected pixels
  for (int i = 0; i < image.pixels.length; i++) {
    image_duplicate.pixels[i] = image.pixels[i];
    if(redrawSection){
      int brightnessOfPixel = int(brightness(image.pixels[i]));
      if(brightnessOfPixel > endingMapped || brightnessOfPixel < startingMapped){
        image_duplicate.pixels[i] = redrawColor;
      }
    }
  }
  image_duplicate.updatePixels();
  //PImage image_duplicate = image;
  canvas.image(image_duplicate,0,0,450,450);
  canvas.endDraw();
  image(canvas,550,50);
  
  int[] hist = new int[256];
  for (int i = 50; i < 50+canvas.width; i++) {
    for (int j = 50; j < 50+canvas.height; j++) {
      int bright = int(brightness(get(i, j)));
      hist[bright]++; 
    }
  }
  int histMax = max(hist);

  stroke(0);
  for (int i = 550; i < 550+canvas.width; i+=1) {
    int which = int(map(i, 550, 550+canvas.width, 0, 255));
    // Convert the histogram value to a location between 
    // the bottom and the top of the picture
    heightsOfBars[which] = int(map(hist[which], 0, histMax, canvas.height, 50));
    if(i%2 == 0){
      if(redrawSection){
        if(i >= starting && i <= ending){
            stroke(255);
          }
          else{
            stroke(0);
          }
        }
      line(i, 50+canvas.height, i, heightsOfBars[which]);
    }
  }
}

void ConvolutionMask(PGraphics canvas, PImage image, float[][] convolutionMask) {
  canvas.beginDraw();
  PImage image_with_mask;
  image_with_mask = createImage(image.width, image.height, RGB);
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
  canvas.image(image_with_mask, 0, 0, 450, 450);
  canvas.endDraw();
  image(canvas, 550, 50);
}



void draw() {
  if (!showImage) {
    if (video.available()) {
      video.read();
      video.loadPixels();
      if(showGray) {
        ScaleOfGray(canvas_trans, video);
      }
      if(showMask) {
        ConvolutionMask(canvas_trans, video, getMask()); 
      }
      canvas_initial.beginDraw();
      canvas_initial.image(video, 0, 0, 450, 450);
      canvas_initial.endDraw();
      image(canvas_initial, 50, 50);
    }
  }
}

//Handles mouse dragging across histogram
void mousePressed(){
  if(showHisto){
    if(mouseX>550 && mouseX<1000 && mouseY>50 && mouseY < 500){
      //print("mousex: " + mouseX + " mouse y: " + mouseY + "\n");
      //int which = int(map(mouseX, 550, 1000, 0, 255));
      starting = mouseX;
      //print("heightofbars mousey: " + heightsOfBars[which] + "\n");
    }
  }
}
void mouseReleased(){
  if(showHisto){
    if(mouseX>550 && mouseX<1000 && mouseY>50 && mouseY < 500){
      ending = mouseX;
      showHistogram(canvas_trans, image,true);
    }
  }
}

void applyConvolution() {
  showMask = true;
  showGray = false;
  showHisto = false;
  if(showImage) ConvolutionMask(canvas_trans, image, getMask());
  //Video will be process in movieEvent
}

void keyPressed() {
  if(key == 'm') {
    showImage = false;
    showGray = false;
    showHisto = false;
    chargeMedia(showImage, canvas_initial);
  }
  if(key == 'i') {
    showImage = true;
    showGray = false;
    showMask = false;
    showHisto = false;
    chargeMedia(showImage, canvas_initial);
  }
  if(key == 'g') {
    showGray = true;
    showMask = false;
    showHisto = false;
    if(showImage) ScaleOfGray(canvas_trans, image);
    //Video will be process in movieEvent
  }
  if(key == 'h') {
    showImage = true;
    showGray = false;
    showMask = false;
    showHisto = true;
    //chargeMedia(showImage, canvas_initial);
    showHistogram(canvas_trans, image,false);
    //Video will be process in movieEvent
  }
  if(key == '1') {
    maskSelected = 1;
    applyConvolution();
  }
  if(key == '2') {
    maskSelected = 2;
    applyConvolution();
  }
  if(key == '3') {
    maskSelected = 3;
    applyConvolution();
  }
  if(key == '4') {
    maskSelected = 4;
    applyConvolution();
  }
  if(key == '5') {
    maskSelected = 5;
    applyConvolution();
  }
}
