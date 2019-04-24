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

void draw() {
  ScaleOfGray(canvas_image, image);
  
}
 
