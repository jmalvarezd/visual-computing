import processing.video.*;

PGraphics canvas_initial;
PGraphics canvas_trans;

PImage image;
Movie video;

float[][] edgeDetection = {{0, 1, 0}, {1, -4, 1}, {0,1,0}};
float[][] edgeDetection2 = {{-1, -1, -1}, {-1, 8, -1}, {-1,-1,-1}};
float[][] sharpen = {{0, -1, 0}, {-1, 5, -1}, {0,-1,0}};
float[][] boxBlur = {{0, -1, 0}, {-1, 5, -1}, {0,-1,0}};
float[][] gaussianBlur = {{0.1111, 0.1111, 0.1111}, {0.1111, 0.1111, 0.1111}, {0.1111, 0.1111, 0.1111}};
// int[][] gaussianBlur5 = {{1/9, 1/9, 1/9}, {1/9, 1/9, 1/9}, {1/9,1/9,1/9}};

boolean showImage = true;
boolean showGray = true;
boolean showMask = false;
boolean showHisto = false;

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

void movieEvent(Movie m) {
  m.read();
  m.loadPixels();
  canvas_trans.beginDraw();
  PImage image_gray;
  image_gray = createImage(m.width, m.height, RGB);
  image_gray.loadPixels();
  for (int i = 0; i < m.pixels.length; i++) {
    float green = green(m.pixels[i]);
    float blue = blue(m.pixels[i]);
    float red = red(m.pixels[i]);
    image_gray.pixels[i] = color((green + blue + red)/3);
  }
  image_gray.updatePixels();
  canvas_trans.image(image_gray, 0, 0, 450, 450);
  canvas_trans.endDraw();
  image(canvas_trans, 550, 50);
}

void draw() {
  // ScaleOfGray(canvas_initial, image);
  // ConvolutionMask(canvas_initial, image);
  if (!showImage) {
    canvas_initial.beginDraw();
    canvas_initial.image(video, 0, 0, 450, 450);
    canvas_initial.endDraw();
    image(canvas_initial, 50, 50);
  }
}
