class March{
   
   float b = 5;
   
   PVector interpolateVerts(PVector v1Pos, PVector v2Pos, float v1Noise, float v2Noise) {
    float t = (b - v1Noise) / (v2Noise - v1Noise);
    PVector vf = new PVector(v1Pos.x + t*(v2Pos.x-v1Pos.x), v1Pos.y + t*(v2Pos.y-v1Pos.y), v1Pos.z + t*(v2Pos.z-v1Pos.z));
    return vf;
};
   
   int cubeIndex = 0;
   
    public void march(int x, int y, int z){

     cubeCorners = new Point[]{
        points[indexFromCoord(x, y, z)],
        points[indexFromCoord(x + 1, y, z)],
        points[indexFromCoord(x + 1, y, z + 1)],
        points[indexFromCoord(x, y, z + 1)],
        points[indexFromCoord(x, y + 1, z)],
        points[indexFromCoord(x + 1, y + 1, z)],
        points[indexFromCoord(x + 1, y + 1, z + 1)],
        points[indexFromCoord(x, y + 1, z + 1)]
     };
     
     cubeIndex = 0;
    
     if (cubeCorners[0].pointNoise < b) cubeIndex |= 1; 
     if (cubeCorners[1].pointNoise < b) cubeIndex |= 2;
     if (cubeCorners[2].pointNoise < b) cubeIndex |= 4;
     if (cubeCorners[3].pointNoise < b) cubeIndex |= 8;
     if (cubeCorners[4].pointNoise < b) cubeIndex |= 16;
     if (cubeCorners[5].pointNoise < b) cubeIndex |= 32;
     if (cubeCorners[6].pointNoise < b) cubeIndex |= 64;
     if (cubeCorners[7].pointNoise < b) cubeIndex |= 128;
    }
    
   public void show(int i){
  
    for(int u = 0; triangulation[cubeIndex][u] != -1; u = u+3){
     
      int a0 = cornerIndexAFromEdge[triangulation[cubeIndex][u]];
      int b0 = cornerIndexBFromEdge[triangulation[cubeIndex][u]];

      int a1 = cornerIndexAFromEdge[triangulation[cubeIndex][u+1]];
      int b1 = cornerIndexBFromEdge[triangulation[cubeIndex][u+1]];

      int a2 = cornerIndexAFromEdge[triangulation[cubeIndex][u+2]];
      int b2 = cornerIndexBFromEdge[triangulation[cubeIndex][u+2]];
    
      tri.vertexA = interpolateVerts(cubeCorners[a0].pos, cubeCorners[b0].pos, cubeCorners[a0].pointNoise, cubeCorners[b0].pointNoise);
      tri.vertexB = interpolateVerts(cubeCorners[a1].pos, cubeCorners[b1].pos, cubeCorners[a1].pointNoise, cubeCorners[b1].pointNoise);
      tri.vertexC = interpolateVerts(cubeCorners[a2].pos, cubeCorners[b2].pos, cubeCorners[a2].pointNoise, cubeCorners[b2].pointNoise);
      
      noStroke();
      fill(185,255,203);
      float dotprod = a.attract(cam).dot(cam.getUp());
      float dotprodnormal = normal.dot(cam.getUp());  
      if(acos(dotprod/(a.attract(cam).mag()*cam.getUp().mag())) != PI){
           float polar = (acos(dotprodnormal/(-(a.attract(cam).mag())*cam.getUp().mag())));
           float alpha = cam.pan;
           float r = cam.getRight().mag();
           float x = r * sin(polar) * cos(alpha);
           float y = r * sin(polar) * sin(alpha);
           float z = r * cos(polar);
           PVector newRight = new PVector(x,y,z);
           cam.setRight(newRight);
         }
  beginShape();
       vertex(tri.vertexA.x, tri.vertexA.y, tri.vertexA.z);
       vertex(tri.vertexB.x, tri.vertexB.y, tri.vertexB.z);
       vertex(tri.vertexC.x, tri.vertexC.y, tri.vertexC.z);
  endShape();
      
      PVector spherePosTri = new PVector((tri.vertexA.x+tri.vertexA.y+tri.vertexA.z)/3,(tri.vertexB.x+tri.vertexB.y+tri.vertexB.z)/3,(tri.vertexC.x+tri.vertexC.y+tri.vertexC.z)/3);
      PVector dif = PVector.sub(spherePosTri,cam.position);
      /*
      if(dif.mag() <= 100){
          float areaTriangle = triangleArea(tri.vertexA, tri.vertexB, tri.vertexC); 
          float areaTriangleCam1 = triangleArea(cam.position, tri.vertexB, tri.vertexC); 
          float areaTriangleCam2 = triangleArea(tri.vertexA, cam.position, tri.vertexC); 
          float areaTriangleCam3 = triangleArea(tri.vertexA, tri.vertexB, cam.position); 
          if((areaTriangleCam1 +  areaTriangleCam2 + areaTriangleCam3) == areaTriangle){
            gravity.set(zero);
            velocity.set(zero);
          }
          else velocity.add(zero);
      }
          */
         boolean collision = trianglein(tri.vertexA, tri.vertexB, tri.vertexC, cam);
         attract = a.attract(cam);
         PVector center = new PVector((tri.vertexA.x + tri.vertexB.x + tri.vertexC.x)/3 , (tri.vertexA.y + tri.vertexB.y + tri.vertexC.y)/3 , (tri.vertexA.z+ tri.vertexB.z + tri.vertexC.z)/3);
         PVector diff = PVector.sub(center, cam.position);
         if(collision && diff.mag() <= 100){
         velocity.set(zero);
           gravity.set(zero);
         //cam.position.add(negVel.mult(0.1));
         }  
         else velocity.add(zero);
         
         
      
      
   
    }
   } 
}
