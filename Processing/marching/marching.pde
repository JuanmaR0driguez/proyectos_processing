Point[] points;
Triangle tri;
March marching;
int cols, rows, lays;

float xOff;

public void setup(){
  lights();
  cols=rows=lays=4;
  xOff = 0;
  tri = new Triangle();
  marching = new March();
  points = new Point[cols*rows*lays];
   size(800, 600, P3D);
   camera(width/2+30,height/2+30,200,width/2,height/2,-100,0,1,0);
  background(255);
  for(int i =0; i < points.length; i++){
    points[i] = new Point(i);
    //points[i].show();
    marching.march(i);
    marching.show(i);
    xOff = xOff+ 0.1;
  }
  //println(cube[32].pos.z);
  
  //perspective(PI/2, width/height, 1, 100);
  //frustum(width/2-10, width/2+10, height/2-10, height/2+10, 1, 200);
/*
for(int i =0; i < points.length; i++){

    }
    */
}

public void draw(){
  }


  /*
  public void show(){
    stroke(0);
    strokeWeight(4);
    for(int u =0; u < points.length; u++){
    if(pointNoise >= 0.4){
     stroke(255,0,0);
    }
    else{
      stroke(0,255,0);
    }
    point(pos.x,pos.y,pos.z);
    
    //point(pos.x-2.5+5*corPos[u].x, pos.y-2.5+5*corPos[u].y, pos.z-2.5+5*corPos[u].z);
    }
  }
  */
 
