class Point {
  
  PVector pos;
  //PVector[] corPos = new PVector[8];
  float pointNoise = 0;
  
  Point(int i){
    pos = new PVector((i%cols),(i/cols)%rows,(i/cols)/rows);
    pointNoise = noise(xOff);
    
   /* for(int u = 0; u < corPos.length; u++){
      
      //corPos[u] = new PVector((u%2),(u/2)%2,(u/2)/2);
    // corPos[u] = new PVector((u/2)%2,(u%2),(u/2)/2);
      //corPos[u] = new PVector((u%2),(u/2)/2,(u/2)%2);
     // corPos[u] = new PVector((u/2)/2,(u/2)%2,(u%2));
    // corPos[u] = new PVector((u/2)/2,(u%2),(u/2)%2);
     //corPos[u] = new PVector((u/2)%2,(u/2)/2,(u%2));
     /*
     corPos[u] = new PVector((1+u)/2, ((u)/2)/2, (2+u)/2);
     if(corPos[u].x == 2 || corPos[u].x == 4){corPos[u].x = 0;}
     if(corPos[u].x == 3){corPos[u].x = 1;}
     if(corPos[u].z == 2 || corPos[u].z == 4){corPos[u].z = 0;}
     if(corPos[u].z == 3){corPos[u].z = 1;}
     
     corNoise[u] = noise(xOff);
      xOff= xOff+0.01;
      println("esquina numero "+u+" de cubo "+i+":"+corPos[u]);
    /*
    }*/
    //int index = x + y * cols + z * cols * rows;
    
    
    
  }
}
