
  void collisionDetect(int i){
   boolean collision = trianglein(triangles[i][0], triangles[i][1], triangles[i][2], cam);
         attract = a.attract(cam);
         PVector center = new PVector((triangles[i][0].x + triangles[i][1].x + triangles[i][2].x)/3 , (triangles[i][0].y + triangles[i][1].y + triangles[i][2].y)/3 , (triangles[i][0].z+ triangles[i][1].z + triangles[i][2].z)/3);
         PVector diff = PVector.sub(center, cam.position);
         if(collision && diff.mag() <= 100){
         gravity.set(zero);
velocity.set(zero);
cam.position.add(negVel);
         }  
         else{
           
           gravity = a.attract(cam);

         }
  }
  void cameraCalculation(int i){
  
      float dotprod = a.attract(cam).dot(cam.getForward());
      float dotprodnormal = normal.dot(cam.getForward());  
      if(acos(dotprod/(a.attract(cam).mag()*cam.getUp().mag())) != PI){
           float polar = (acos(dotprodnormal/(-(a.attract(cam).mag())*cam.getUp().mag())));
           float alpha = cam.pan;
           float r = cam.getRight().mag();
           float x = r * sin(polar) * cos(alpha);
           float y = r * sin(polar) * sin(alpha);
           float z = r * cos(polar);
           PVector newRight = new PVector(x,y,z);
           //cam.setRight(newRight);
         }
  PVector crossprod = a.attract(cam).cross(cam.getForward());
  cam.setUp(a.attract(cam));
  cam.setRight(crossprod);
  collisionDetect(i);
  }
