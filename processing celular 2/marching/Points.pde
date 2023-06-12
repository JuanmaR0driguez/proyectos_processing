class Point {
  
  PVector pos;
  float pointNoise = 0;
  
  Point(int i){
    pos = new PVector(100*(i%cols),100*((i/cols)%cols),100*(i/(cols*cols)));
    pointNoise = 10*noise(pos.x+xOff, pos.y+xOff, pos.z+xOff);
    xOff = xOff + 0.4;  
  }
}