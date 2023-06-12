import queasycam.*;

QueasyCam cam;
Point[] points;
Point[] cubeCorners;
Triangle[] tri;
March marching;
int cols, rows, lays;
float xOff;
public void setup(){
  lights();
  cam = new QueasyCam(this);
  cam.speed = 10;              // default is 3
  cam.sensitivity = 0.5;      // default is 2
  cols=rows=lays=10;
  xOff = 0;
  tri = new Triangle[cols*rows*lays*20];
  marching = new March();
  points = new Point[cols*rows*lays];
  cubeCorners = new Point[8];
  size(displayWidth, displayHeight, P3D);
  //camera(30,30,1000,0,0,-100,0,1,0);
  /* 
  perspective();
  background(255);
  translate(200, 200, 0);
rotateX(-PI/6);
rotateY(PI/3);
*/
  for(int i =0; i < points.length; i++){
    points[i] = new Point(i);
  }
  
  for(int i =0; i < tri.length; i++){
    tri[i] = new Triangle();
  }
  
  for(int a =0; a < rows-1; a++){
    for(int b =0; b < rows-1; b++){
      for(int i =0; i < rows-1; i++){
        marching.march(i, b, a);
        marching.show(i);
      }
    }
  }

}

public void draw(){
  lights();
  noStroke();
  background(255);
      fill(255,192,203);
      
      for(int i = 0; i < tri.length; i++){
  beginShape();
       vertex(tri[i].vertexA.x, tri[i].vertexA.y, tri[i].vertexA.z);
       vertex(tri[i].vertexB.x, tri[i].vertexB.y, tri[i].vertexB.z);
       vertex(tri[i].vertexC.x, tri[i].vertexC.y, tri[i].vertexC.z);
       vertex(tri[i].vertexA.x, tri[i].vertexA.y, tri[i].vertexA.z);
  endShape();
      }
      strokeWeight(10);
      stroke(0);
      line(cam.position.x,cam.position.y,cam.position.z,tri[1].vertexA.x,tri[1].vertexA.y,tri[1].vertexA.z);
  }
  
