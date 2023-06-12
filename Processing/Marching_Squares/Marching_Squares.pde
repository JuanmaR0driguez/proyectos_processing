import queasycammod.*;
QueasyCamMod cam;
Point[] points;
Point[] cubeCorners;
Triangle tri;
Attractor a;
March marching;
int cols, rows, lays;
float xOff;
boolean turnoff = true;
PVector spherePos = new PVector(1000,1000,1000);
PVector velocity;
PVector gravity;
PVector normal;
PVector zero;
PVector attract;
PVector dif;
PVector negVel;
public void setup(){
  cam = new QueasyCamMod(this,0.01,5000);
  cam.speed = 5;              // default is 3
  cam.sensitivity = 0.5;
  cols=rows=lays=20;
  xOff = 0;
  tri = new Triangle();
  a = new Attractor(spherePos);
  marching = new March();
  velocity = new PVector(0,0,0);
  gravity = new PVector(0,0,0);
  normal = new PVector(0,0,0);
  zero = new PVector(0,0,0);
  attract = new PVector(0,0,0);
  dif = new PVector(0,0,0);
  negVel = new PVector(0,0,0);
  points = new Point[cols*rows*lays];
  cubeCorners = new Point[8];
  size(displayWidth, displayHeight, P3D);
  for(int i =0; i < points.length; i++){
    points[i] = new Point(i);
  }
   for(int a =0; a < rows-1; a++){
    for(int b =0; b < rows-1; b++){
      for(int i =0; i < rows-1; i++){
        marching.march(i, b, a);
      }
    }
  }
}
void keyPressed(){if(key == 'l')turnoff = !turnoff;}
public void draw(){
 lights();
  noStroke();
  background(0);
  noCursor();
  fill(185,255,203);
  
    PVector wCheck = PVector.sub(spherePos, cam.position);
  if(wCheck.mag() <= 750){
    ambientLight(0,0,155);
    cam.speed = 1.5;
  }
  else{
    ambientLight(0,0,0);
    cam.speed = 5;
  }
  
 
  if(turnoff)pointLight(50, 50, 50, cam.position.x, cam.position.y, cam.position.z);
    for(int a =0; a < rows-1; a++){
    for(int b =0; b < rows-1; b++){
      for(int i =0; i < rows-1; i++){
        marching.march(i, b, a);
        marching.show(i);
      }
    }
  }
  
   gravity = a.attract(cam);
  normal = new PVector(-a.attract(cam).x,-a.attract(cam).y, -a.attract(cam).z);
  negVel = negVel.add(normal);
  velocity.add(gravity);
  cam.position.add(velocity);
  PVector crossprod = a.attract(cam).cross(cam.getRight());
  cam.setUp(crossprod);
  fill(0,145,255,50);
  pushMatrix();
  translate(spherePos.x,spherePos.y, spherePos.z);
  sphere(750);
  popMatrix();
}
  
