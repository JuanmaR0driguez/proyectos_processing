float t;
PVector[] o=new PVector[150];
void setup() {
  size(400, 400);
}
void draw() {
  background(255);
  strokeWeight(1.5);
  for (int i=0; i<150; i++) {
    o[i]=new PVector(0, floor(i)+40);
    o[i].x=200+50*cos(t+i*PI+i);
    o[i].y=200+50*cos(2*i);
    if (i!=0)line(o[i].x, o[i].y, o[i-1].x, o[i-1].y);
  }
  t+=0.05;
}
