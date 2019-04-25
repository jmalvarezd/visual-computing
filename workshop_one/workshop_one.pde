import processing.video.*;

Movie video;
PGraphics canvas_image;
PGraphics canvas_trans;
PImage image; 

void setup() {
  size(1050, 600);
  canvas_image = createGraphics(450, 450);
  canvas_image.beginDraw();
  image = loadImage("Leopard.jpg");
  image.loadPixels();
  canvas_image.image(image, 0, 0, 450, 450);
  /*video = new Movie(this, "Ocean.mp4");
  video.play();*/
  canvas_image.endDraw();
  canvas_trans = createGraphics(450, 450);
  image(canvas_image, 50, 50);  
}

/*void draw() {
  canvas_image.beginDraw();
  canvas_image.image(video, 0, 0, 450, 450);
  canvas_image.endDraw();
  image(canvas_image, 50, 50);
}*/

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

void ConvolutionMask(PGraphics canvas, PImage image) {
  canvas.beginDraw();
  PImage image_with_mask;
  image_with_mask = createImage(image.width, image.height, RGB);
  int[][] convolutionMask = {{0, 1, 0}, {1, -4, 1}, {0,1,0}};
  for(int i = 0; i < image.width; i++){
    for(int j = 0; j < image.height; j++) {
      int avgR = 0, avgG = 0, avgB = 0;
      for(int n = 0; n < convolutionMask.length; n++) {
        for(int m = 0; m < convolutionMask[0].length; m++) {
          int x = i + n - convolutionMask.length/2;
          int y = j + m - convolutionMask.length/2;
          if( x < image.width && x >= 0 && y < image.height && y >= 0) {
            int index = x * image.width + y;
            println(index);
            avgR += red(image.pixels[index]) * convolutionMask[n][m];
            avgG += green(image.pixels[index]) * convolutionMask[n][m];
            avgB += blue(image.pixels[index]) * convolutionMask[n][m];
            image_with_mask.pixels[index] = color(avgR, avgG, avgB);
          }
        }
      }      
    }
  }
  image_with_mask.updatePixels();
  canvas.image(image_with_mask, 0, 0, 450, 450);
  canvas.endDraw();
  image(canvas, 550, 50);
}

void draw() {
  // ScaleOfGray(canvas_image, image);
  ConvolutionMask(canvas_image, image);
}
 
