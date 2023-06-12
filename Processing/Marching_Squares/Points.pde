class Point{
  
  PVector pos;
  float pointNoise = 0;
  
  Point(int i){
    pos = new PVector(100*(i%cols),100*((i/cols)%cols),100*(i/(cols*cols)));
  //pointNoise = 10*noise(pos.x+xOff, pos.y+xOff, pos.z+xOff);
    dif = PVector.sub(spherePos,pos);
    if(dif.mag() <= 500) pointNoise = 5;
    else if(dif.mag() <= 900) pointNoise = 10*noise(pos.x+xOff, pos.y+xOff, pos.z+xOff);
    else pointNoise = 0;
    

    xOff = xOff + 0.5;  
  }
}
