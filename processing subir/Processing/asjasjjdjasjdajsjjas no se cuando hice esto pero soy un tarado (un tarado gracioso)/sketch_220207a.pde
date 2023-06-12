PVector location;
PVector velocity;
PVector textloc;
PVector textvel;
PVector gravity;
PFont comic;
int col;

void settings(){

  fullScreen();

}


void setup(){

  surface.setSize(300, 300);
  location = new PVector(100,100);
  velocity = new PVector(random(-2,2),random(-2,2));
  textloc = new PVector(100,100);
  textvel = new PVector(random(-2,2),random(-2,2));
  gravity= new PVector(0,0.1);
  colorMode(HSB);
}

void draw(){
  background(0);
  velocity.add(gravity);
location.add(velocity);
textloc.add(textvel);
if ((location.x+width > displayWidth) || (location.x < 0)) {
    velocity.x = velocity.x * -1;
  }
  if ((location.y+height > displayHeight)) {
    velocity.y = velocity.y * -0.95;
    location.y = displayHeight-height;
  }
  
  if ((textloc.x + 120 > width) || (textloc.x +5 < 0)) {
    textvel.x = textvel.x * -1;
  }
  if ((textloc.y> height) || (textloc.y -30 < 0)) {
    textvel.y = textvel.y * -1;
  }
  surface.setLocation(int(location.x),int(location.y));
  comic = loadFont("ComicSansMS-48.vlw");
  textFont(comic);
  fill(color(col, 255,255));
  col++;
  if ( col >= 255){
  col = 0;
  }
  text("sexoo", textloc.x, textloc.y);
}
