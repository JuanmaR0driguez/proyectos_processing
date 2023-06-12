
class March{
   
   
   
   PVector interpolateVerts(PVector v1Pos, PVector v2Pos, float v1Noise, float v2Noise) {
    float t = (40 - v1Noise) / (v2Noise - v1Noise);
    if(t >= 1){t=1;}
    else if(t <= -1){t=-1;}
    PVector vf = new PVector(v1Pos.x - t*(v2Pos.x-v1Pos.x), v1Pos.y - t*(v2Pos.y-v1Pos.y), v1Pos.z - t*(v2Pos.z-v1Pos.z));
    //PVector vf = new PVector(0.5, 0.5, 0.5);
    //println(t, v1Noise, v2Noise);
    
    return vf;
};
   
   int cubeIndex = 0;
   
    public void march(int i){
  
  if (i < cols-1) {
        
    
      
    int pointIndex0 = indexFromCoord(points[i].pos.x, points[i].pos.y, points[i].pos.z);
    int pointIndex1 = indexFromCoord(points[i].pos.x+1, points[i].pos.y, points[i].pos.z);
    int pointIndex2 = indexFromCoord(points[i].pos.x, points[i].pos.y+1, points[i].pos.z);
    int pointIndex3 = indexFromCoord(points[i].pos.x, points[i].pos.y, points[i].pos.z+1);
    int pointIndex4 = indexFromCoord(points[i].pos.x+1, points[i].pos.y+1, points[i].pos.z);
    int pointIndex5 = indexFromCoord(points[i].pos.x, points[i].pos.y+1, points[i].pos.z+1);
    int pointIndex6 = indexFromCoord(points[i].pos.x+1, points[i].pos.y, points[i].pos.z+1);
    int pointIndex7 = indexFromCoord(points[i].pos.x+1, points[i].pos.y+1, points[i].pos.z+1);
    
    
   
    
    
    
    if (points[pointIndex0] != null && points[indexFromCoord(points[i].pos.x, points[i].pos.y, points[i].pos.z)].pointNoise < 0.4) cubeIndex |= 1;
    if (points[pointIndex1] != null && points[indexFromCoord(points[i].pos.x + 1, points[i].pos.y, points[i].pos.z)].pointNoise < 0.4) cubeIndex |= 2;
    if (points[pointIndex6] != null && points[indexFromCoord(points[i].pos.x + 1, points[i].pos.y, points[i].pos.z + 1)].pointNoise < 0.4) cubeIndex |= 4;
    if (points[pointIndex3] != null && points[indexFromCoord(points[i].pos.x, points[i].pos.y, points[i].pos.z + 1)].pointNoise < 0.4) cubeIndex |= 8;
    if (points[pointIndex2] != null && points[indexFromCoord(points[i].pos.x, points[i].pos.y + 1, points[i].pos.z)].pointNoise < 0.4) cubeIndex |= 16;
    if (points[pointIndex4] != null && points[indexFromCoord(points[i].pos.x + 1, points[i].pos.y + 1, points[i].pos.z)].pointNoise < 0.4) cubeIndex |= 32;
    if (points[pointIndex7] != null && points[indexFromCoord(points[i].pos.x + 1, points[i].pos.y + 1, points[i].pos.z + 1)].pointNoise < 0.4) cubeIndex |= 64;
    if (points[pointIndex5] != null && points[indexFromCoord(points[i].pos.x, points[i].pos.y + 1, points[i].pos.z + 1)].pointNoise < 0.4) cubeIndex |= 128;
  }
  else{return;}
    }
public void show(int i){
  println(cubeIndex);
    for(int u = 0; triangulation[cubeIndex][u] != -1; u = u+3){
      int a0 = cornerIndexAFromEdge[triangulation[cubeIndex][u]];
      int b0 = cornerIndexBFromEdge[triangulation[cubeIndex][u]];

      int a1 = cornerIndexAFromEdge[triangulation[cubeIndex][u+1]];
      int b1 = cornerIndexBFromEdge[triangulation[cubeIndex][u+1]];

      int a2 = cornerIndexAFromEdge[triangulation[cubeIndex][u+2]];
      int b2 = cornerIndexBFromEdge[triangulation[cubeIndex][u+2]];
    
      tri.vertexA = interpolateVerts(points[a0].pos, points[b0].pos, points[a0].pointNoise, points[b0].pointNoise);
      tri.vertexB = interpolateVerts(points[a1].pos, points[b1].pos, points[a1].pointNoise, points[b1].pointNoise);
      tri.vertexC = interpolateVerts(points[a2].pos, points[b2].pos, points[a2].pointNoise, points[b2].pointNoise);
      
     
      noStroke();
     // strokeWeight(1);
      fill(255,192,203);
      
     
      
      beginShape();
      
      vertex(tri.vertexA.x+points[i].pos.x-0.5, tri.vertexA.y+points[i].pos.y-0.5, tri.vertexA.z+points[i].pos.z-0.5);
      vertex(tri.vertexB.x+points[i].pos.x-0.5, tri.vertexB.y+points[i].pos.y-0.5, tri.vertexB.z+points[i].pos.z-0.5);
      vertex(tri.vertexC.x+points[i].pos.x-0.5, tri.vertexC.y+points[i].pos.y-0.5, tri.vertexC.z+points[i].pos.z-0.5);
      
      vertex(tri.vertexA.x, tri.vertexA.y, tri.vertexA.z);
      vertex(tri.vertexB.x, tri.vertexB.y, tri.vertexB.z);
      vertex(tri.vertexC.x, tri.vertexC.y, tri.vertexC.z);
      
      endShape();
    
      println("funcando");
      
    
    }
    ellipse(width/2, height/2, 10,10);
   }
   
    
  }
