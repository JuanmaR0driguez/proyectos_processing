Point[] points;
Point[] cubeCorners;
Triangle tri;
March marching;
int cols, rows, lays;
float xOff;
public void setup(){
  lights();
  cols=rows=lays=5;
  xOff = 0;
  tri = new Triangle();
  marching = new March();
  points = new Point[cols*rows*lays];
  cubeCorners = new Point[8];
  size(displayWidth, displayHeight, P3D);
  //camera(30,30,1000,0,0,-100,0,1,0);
   
  perspective();
  background(255);
  translate(200, 200, 0);
rotateX(-PI/6);
rotateY(PI/3);
  for(int i =0; i < points.length; i++){
    points[i] = new Point(i);
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
  }
  




