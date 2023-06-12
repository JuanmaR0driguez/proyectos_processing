P[]p;
float t=0;
int n=75;
void setup() {
  size(800, 600, P3D);
  p=new P[n*2];
  for (int i=0; i<p.length; i++)p[i]=new P(i);
}
void draw() {
  background(255);
  for (int i=0; i<p.length; i++) {
    p[i].u(i);
    p[i].s(i);
  }
  t+=0.1;
}
class P {
  PVector o;
  P(int i) {
    o = new PVector(2*width/3, 4*floor(i/2)+height/3-30, 0);
    if (i%2==0){o.x/=2;o.y/=2;};
  }
  void u(int i) {
    o.x=width/2+50*cos(t/2+i*PI+i);
    o.z=50*sin(t/2+i*PI+i);
  }
  void s(int i) {
    if (i%2!=0)line(o.x, o.y, o.z, p[i-1].o.x, p[i-1].o.y, p[i-1].o.z);
  }
}
