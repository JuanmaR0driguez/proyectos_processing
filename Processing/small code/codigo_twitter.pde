float t;
PVector[] o=new PVector[150];
void setup() {
  size(800, 400);
}
void draw() {
  background(255);
  strokeWeight(1.5);
  for (int i=0; i<150; i++) {
    o[i]=new PVector(0, floor(i)+401);
    if (i%2!=0) {
      o[i].y*=2;
    }
    o[i].x=400+50*cos(t+i*PI+i);
    if (i%2!=0)line(o[i].x, o[i].y, o[i-1].x, o[i-1].y);
  }
  t+=0.05;
}
