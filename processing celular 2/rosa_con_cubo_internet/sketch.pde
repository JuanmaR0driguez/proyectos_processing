void setup(){
  size(600,600,P3D);
  fill(#E31717,80);
  noStroke();
}
void draw(){
  translate(300,300);
  float f = frameCount*.01;
  rotateX(f);
  rotateY(f*2);
  rotateZ(f);
  lights();
  box(max(0,400-f*20));
}