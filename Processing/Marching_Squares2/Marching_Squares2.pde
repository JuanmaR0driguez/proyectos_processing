import queasycammod.*;
QueasyCamMod cam;
Point[] points;
Point[] cubeCorners;
PVector [][] triangles;
Attractor a;
March marching;
int cols, rows, lays, triangleCount;
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
  cam = new QueasyCamMod(this,0.01,5000,PI/2);
  cam.speed = 5;              // default is 3
  cam.sensitivity = 0.5;
  cols=rows=lays=20;
  xOff = 0;
  triangleCount = 0;
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
  triangles = new PVector[points.length * 12][3];
  size(displayWidth, displayHeight, P3D);
  for(int i =0; i < points.length; i++){
    points[i] = new Point(i);
  }
  for(int i =0; i < triangles.length; i++){
    for(int j = 0; j < triangles[i].length; j++){
      triangles[i][j] = new PVector(-1,-1,-1);
    }
  }
   for(int a =0; a < rows-1; a++){
    for(int b =0; b < rows-1; b++){
      for(int i =0; i < rows-1; i++){
        marching.march(i, b, a);
      }
    }
  }
  for(int i =0;triangles[i][1].x!=-1 && triangles[i][1].y!=-1 && triangles[i][1].z!=-1 && triangles[i][2].x!=-1 && triangles[i][2].y!=-1 && triangles[i][2].z!=-1 && triangles[i][0].x!=-1 && triangles[i][0].y!=-1 && triangles[i][0].z!=-1;i++){
triangleCount += 1;
  }
  println(triangleCount);
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
  normal = new PVector(-a.attract(cam).x,-a.attract(cam).y, -a.attract(cam).z);
  negVel = new PVector(-velocity.x, -velocity.y, -velocity.z);
        for(int i = 0; i < triangleCount; i++){
        marching.show(i);
        cameraCalculation(i);
        }  
        velocity.add(gravity);
        cam.position.add(velocity);
  fill(0,145,255,50);
  pushMatrix();
  translate(spherePos.x,spherePos.y, spherePos.z);
  sphere(750);
  popMatrix();
}
  
