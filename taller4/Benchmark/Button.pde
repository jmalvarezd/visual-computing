class Button{
  int x,y,f;
  String text;
  Button(int x, int y,int f, String text){    
    this.x = x;
    this.y = y;
    this.f = f;
    this.text = text;
  }
  boolean click(){
    boolean bx = x < mouseX && x + 120 > mouseX;
    boolean by = y < mouseY && y + 50 > mouseY;
    return bx && by?true:false;
  }
  void draw() {
    pushStyle();
    fill(color(0,56,80));
    rect(x, y, 125, 50, 7);
    textSize(12);
    fill(255);
    text(text,x+10,y+30);   
    fill(255);
    popStyle();
  }
}
