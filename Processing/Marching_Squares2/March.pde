class March{
   
   float b = 5;
   
   PVector interpolateVerts(PVector v1Pos, PVector v2Pos, float v1Noise, float v2Noise) {
    float t = (b - v1Noise) / (v2Noise - v1Noise);
    PVector vf = new PVector(v1Pos.x + t*(v2Pos.x-v1Pos.x), v1Pos.y + t*(v2Pos.y-v1Pos.y), v1Pos.z + t*(v2Pos.z-v1Pos.z));
    return vf;
};
   
   int cubeIndex = 0;
   int triangleIndex = 0;
   
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
     
   
     
    for(int u = 0; triangulation[cubeIndex][u] != -1; u = u+3){
      
      int a0 = cornerIndexAFromEdge[triangulation[cubeIndex][u]];
      int b0 = cornerIndexBFromEdge[triangulation[cubeIndex][u]];

      int a1 = cornerIndexAFromEdge[triangulation[cubeIndex][u+1]];
      int b1 = cornerIndexBFromEdge[triangulation[cubeIndex][u+1]];

      int a2 = cornerIndexAFromEdge[triangulation[cubeIndex][u+2]];
      int b2 = cornerIndexBFromEdge[triangulation[cubeIndex][u+2]];
   
      triangles[triangleIndex][0] = interpolateVerts(cubeCorners[a0].pos, cubeCorners[b0].pos, cubeCorners[a0].pointNoise, cubeCorners[b0].pointNoise);
      triangles[triangleIndex][1] = interpolateVerts(cubeCorners[a1].pos, cubeCorners[b1].pos, cubeCorners[a1].pointNoise, cubeCorners[b1].pointNoise);
      triangles[triangleIndex][2] = interpolateVerts(cubeCorners[a2].pos, cubeCorners[b2].pos, cubeCorners[a2].pointNoise, cubeCorners[b2].pointNoise);

       triangleIndex += 1;
  }
    }
    
   public void show(int i){
   noStroke();
      fill(185,255,203);
     beginShape();
       vertex(triangles[i][0].x,triangles[i][0].y, triangles[i][0].z);
       vertex(triangles[i][1].x, triangles[i][1].y, triangles[i][1].z);
       vertex(triangles[i][2].x, triangles[i][2].y, triangles[i][2].z);
  endShape();
   } 
}
