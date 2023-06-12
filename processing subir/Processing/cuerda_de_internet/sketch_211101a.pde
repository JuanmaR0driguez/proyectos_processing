ArrayList<Spring> springs;
PVector grab, grabVel;
PVector wind;
boolean selected=false;
boolean pause = false;
boolean windOn = false;
boolean gravityOn = true;
float windStrength = 10;
float num = 10;
Spring chain;
void setup() {
  size(400, 400, P3D);
  springs = new ArrayList<Spring>();
  chain = new Spring(new PVector(), new PVector());
  chain.len=6;
  springs.add(chain);
  for(int i = 0; i < 8; i++){
  Spring newChain = new Spring(springs.get(springs.size()-1).v2,new PVector());
  newChain.vel1=springs.get(springs.size()-1).vel2;
  newChain.d1=true;
  newChain.len=6;
  springs.add(newChain);
  }
  wind = new PVector();
}
void draw() {
  noCursor();
  //add random wind
  wind.mult(.99);
  PVector p = PVector.random3D();
  p.mult(.1);
  wind.add(p);
  background(255);
  lights();
  for (int i = 0; i < springs.size(); i++) {
    if(!pause){
    springs.get(i).update();
    springs.get(i).display();
    }
  }
  chain.v1.x=mouseX;
  chain.v1.y=mouseY;
  chain.vel1.x+=mouseX-pmouseX;
  chain.vel1.y+=mouseY-pmouseY;
  chain.v1.z=0;
}
void keyReleased() {
  if (key==' ') {
    pause=!pause;
  }
  if (key=='1') {
    makeBox(new PVector(mouseX, mouseY, random(-100, 100)));
  }
  if (key=='g'||key=='G') {
    gravityOn=!gravityOn;
  }
  if (key=='w'||key=='W') {
    windOn=!windOn;
  }
}
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  windStrength-=e;
  if (windStrength<1) {
    windStrength=1;
  }
}
class Spring {
  PVector v1, v2;
  PVector vel1, vel2;
  float len = num*3;
  float damp = 1;
  float groundFriction = .34;
  float tightness = 1;
  boolean d1, d2;
  Spring(PVector V1, PVector V2) {
    v1 = V1;
    v2 = V2;
    vel1 = new PVector();
    vel2 = new PVector();
    d1 = false;
    d2 = false;
  }
  void update() {
    PVector w = wind.copy();
    w.mult((windStrength*4)/100);
    //since two springs can share the same PVector
    //we need to 'deactivate' one of them to prevent
    //double updating where we don't want it
    if (!d1) {
      if (gravityOn)vel1.y+=.34;
      if (windOn)vel1.add(w);
      vel1.mult(.9);
      v1.add(vel1);
    }

    if (!d2) {
      if (gravityOn)vel2.y+=.34;
      if (windOn)vel2.add(w);
      vel2.mult(.9);
      v2.add(vel2);
    }


    //spring math
    float ex = len-dist(v1.x, v1.y, v1.z, v2.x, v2.y, v2.z)*.5;
    PVector dir = v2.copy();
    dir.sub(v1);
    dir.normalize();
    dir.mult(ex);
    v1.sub(PVector.mult(dir, tightness));
    v2.add(PVector.mult(dir, tightness));
    vel1.sub(PVector.mult(dir, damp));
    vel2.add(PVector.mult(dir, damp));
  }
  void display() {
    if (v1.y>height-25) {
      v1.y=height-25;
      vel1.mult(groundFriction);
    }
    if (v2.y>height-25) {
      v2.y=height-25;
    }
    if (v1.x>width) {
      v1.x=width;
    }
    if (v2.x>width) {
      v2.x=width;
    }
    if (v1.x<0) {
      v1.x=0;
    }
    if (v2.x<0) {
      v2.x=0;
    }
    fill(255, 0, 0);
    noStroke();
    if (!d1) {
      pushMatrix();
      translate(v1.x, v1.y, v1.z);
      sphere(4);
      popMatrix();
    }
    if (!d2) {
      pushMatrix();
      translate(v2.x, v2.y, v2.z);
      sphere(4);
      popMatrix();
    }
    stroke(0);
    line(v1.x, v1.y, v1.z, v2.x, v2.y, v2.z);
  }
}
void connectSpring(PVector p1, PVector v1, PVector p2, PVector v2) {
  Spring spr = new Spring(p1, p2);
  spr.vel2=v2;
  spr.vel1=v1;
  spr.d1=true; //deactivates some properties
  spr.d2=true; //deactivates some properties
  springs.add(spr);
}
void makeBox(PVector pos) {
  num=10;
  PVector p0 = new PVector(pos.x, pos.y, pos.z);
  PVector p1 = new PVector(pos.x, pos.y, pos.z+10);
  PVector p2 = new PVector(pos.x, pos.y, pos.z-10);
  PVector p3 = new PVector(pos.x+10, pos.y, pos.z);
  PVector p4 = new PVector(pos.x-10, pos.y, pos.z);
  PVector p5 = new PVector(pos.x+10, pos.y, pos.z+10);
  PVector p6 = new PVector(pos.x-10, pos.y, pos.z+10);
  PVector p7 = new PVector(pos.x-10, pos.y, pos.z-10);
  PVector p8 = new PVector(pos.x+10, pos.y, pos.z-10);
  //for edges
  Spring spr0 = new Spring(p0, p1);
  Spring spr1 = new Spring(p1, p2);
  Spring spr2 = new Spring(p3, p4);
  Spring spr3 = new Spring(p5, p6);
  Spring spr4 = new Spring(p7, p8);
  springs.add(spr0);
  springs.add(spr1);
  springs.add(spr2);
  springs.add(spr3);
  springs.add(spr4);
  connectSpring(p1, spr1.vel1, p5, spr3.vel1);
  connectSpring(p2, spr1.vel2, p6, spr3.vel2);
  connectSpring(p3, spr2.vel1, p7, spr4.vel1);
  connectSpring(p4, spr2.vel2, p8, spr4.vel2);
  connectSpring(p1, spr1.vel1, p3, spr2.vel1);
  connectSpring(p2, spr1.vel2, p4, spr2.vel2);
  connectSpring(p5, spr3.vel1, p7, spr4.vel1);
  connectSpring(p6, spr3.vel2, p8, spr4.vel2);
  num=sqrt(2)*10; 

}
