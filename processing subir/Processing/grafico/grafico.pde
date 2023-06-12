import controlP5.*;

ControlP5 cp5;
int myColor = color(0,0,0);

int sliderValue = 1;
float A,Q;
Slider abc;

float minz,maxz;
float bound;
float[] z;
int maxn = 3,n;
color mincol,maxcol;
boolean menuVisible = false;

void setup(){
  
  colorMode(HSB);
size(600,600,P3D);
cp5 = new ControlP5(this);
  
  // add a horizontal sliders, the value of this slider will be linked
  // to variable 'sliderValue' 
  cp5.addSlider("sliderValue")
     .setPosition(50,50)
     .setRange(0,10)
     .setCaptionLabel("Zoom")
     .setNumberOfTickMarks(10)
     .setSize(100,15)
     ;
     
   cp5.addSlider("Q")
     .setPosition(50,80)
     .setRange(1,10)
     .setNumberOfTickMarks(10)
     .setSize(100,15)
     ;
     
   cp5.addSlider("A")
     .setPosition(50,110)
     .setRange(1,10)
     .setNumberOfTickMarks(10)
     .setSize(100,15)
     ;
     
   cp5.addSlider("maxn")
     .setPosition(50,140)
     .setRange(1,10)
     .setCaptionLabel("n maximo")
     .setNumberOfTickMarks(10)
     .setSize(100,15)
     ;

bound = sliderValue;
z = new float[width*height];


for (int i = 0; i < width*height; i++) {
    z[i] = 0;
}




}

void draw(){
  background(0);
  
bound = sliderValue;
 int xoff = 0;
 for (float x = 0; x < bound; x += (bound/width)) {
   int yoff = 0;
   for (float y = 0; y < bound; y += (bound/height)) { 
    for(int n = 0; n < maxn; n++){
      if(xoff+yoff*width < width*height){
      z[xoff+yoff*width] +=  Q*sin(x*n*PI/A)*sin(y*n*PI/A);
      }
    }
     yoff++;
   }
     xoff++;
  }
  
maxz = max(z);
minz = min(z);

loadPixels();

 for (int xa = 0; xa < width; xa++) {
   for (int ya = 0; ya < height; ya++) {
      pixels[xa+ya*width]=color(map(z[xa+ya*width], minz, maxz, 0, 255), 255,255);
   }
  }

updatePixels();
noStroke();
  fill(0);
  if(menuVisible){
  rect(40,40,160,135);
  cp5.setVisible(true);
  }
  else{
  cp5.setVisible(false);
  }
}

void mouseClicked(){

  menuVisible = !menuVisible;

}
