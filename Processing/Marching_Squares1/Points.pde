class Point {
  
  PVector pos;
  float pointNoise = 0;
  
  Point(int i){
    pos = new PVector(10*(i%cols),10*((i/cols)%cols),10*(i/(cols*cols)));
    pointNoise = 10*noise(pos.x+xOff, pos.y+xOff, pos.z+xOff);
    xOff = xOff + 0.4;  
  }
}
