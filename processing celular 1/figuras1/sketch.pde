float t=0;
float[] x;
float[] y;
float mousex, mousey;
int number;
void setup(){
  
  size(displayWidth, displayHeight, P2D);
  number = 10000;
  x = new float[number];
  y = new float[number];
  
  for(int i = 0; i < number; i++){
   t=0;
   x[i] = width/2+ 300* cos((t)*(i+t));
  
  y[i] = height/2+ 300*sin((t)*(i+t));
   t+=0.2;
    }
  background(255);
  
  stroke(0);
  
  strokeWeight(1);
  
  mousex = 0;
  mousey = 0;
  
  }

void draw(){
   
  
  
  if(mousex != mouseX || mousey != mouseY){
   background(255);
    mousex = mouseX;
    mousey = mouseY;
    }
  
  for(int i = 0; i < number; i++){
   
   x[i] = width/2+ 300*cos((mouseX)*(i+t));
  
   y[i] = height/2+ 300*sin((mouseY)*(i+t));
   t+=0.2;
    }
  
  
  
  for(int i = 1; i < number; i++){
  
  
  if(i !=1 ){
 
 
  point(x[i],y[i]);
  }
  }
  
  }