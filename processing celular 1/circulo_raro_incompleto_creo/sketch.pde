Point[] points;
float t;

void setup(){
  
  t=0;
  size(800,800,P3D);
 
  points = new Point[width*height];
  background(255);
  stroke(0);
  strokeWeight (2);
  
  for(int i = 0; i < points.length; i++){
    
    points[i] = new Point();
    points[i].create();
    t += 0.1;
    }
    
    camera(width/2+3000,height/2+3000,3000, width/2, height/2, 0, 0,0,1);
  
  }
void draw(){
  
  
  
  }

class Point{
  
  int numberOfBranch;
  
  PVector pos;
  
  boolean isConnected;
  
  Point(){
    
    pos = new PVector(width/2+30*(sin(t)), height/2+30*(cos(t)), t);
    
    }
  
  void create(){
    
    point(pos.x, pos.y, pos.z);
    
    }
  
  
  }
  
  void thickeningLine(float sx, float sy, float ex, float ey, int sws, int swe){
  int dsw = int(swe - sws);
  float amt = 1.0/dsw;
  for(int i = 0; i < dsw; i++){
    strokeWeight(sws+i);
    line(lerp(sx,ex,i*amt),lerp(sy,ey,i*amt),lerp(sx,ex,(i+1)*amt),lerp(sy,ey,(i+1)*amt));
  }
}