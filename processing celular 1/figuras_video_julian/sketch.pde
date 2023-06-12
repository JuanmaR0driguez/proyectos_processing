float t;
PVector[] o=new PVector[10000];
void setup() {
  size(1000, 1000);
}
void draw() {
  background(255);
  strokeWeight(1.5);
  for (int i=0; i<150; i++) {
    o[i]=new PVector(500+200*cos((t+PI+i)), 500+200*cos(i*(mouseX/50)));
    if (i!=0)line(o[i].x, o[i].y, o[i-1].x, o[i-1].y);
  }
  t+=0.05;
}
