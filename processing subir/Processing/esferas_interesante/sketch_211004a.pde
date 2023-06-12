float uwu;
Esfera[] esferas;
float sphereSize[];

public void setup(){
  
  size(800,600, P3D);
  
  esferas = new Esfera[10];
  sphereSize = new float[1];
  
  for(int i = 0; i < esferas.length; ++i){
    esferas[i] = new Esfera();
  }
  
  for (int i = 0; i < sphereSize.length; ++i){
    sphereSize[i] = 0;
  }
  
  uwu = 0;
  
  camera(width/2,height/2-40, 100, width/2, height/2, 0, 0,1,0);
  background(0);
}

public void draw(){
  
  lights();
  background(0);
  
  for(int esferasNum = 0; esferasNum < esferas.length; ++esferasNum){
    esferas[esferasNum].update(esferasNum);
    
    esferas[esferasNum].show(esferasNum);
  }

 
}

class Esfera {
  
  PVector pos;
  
  Esfera(){
    pos = new PVector(width/2,height/2-20,0);
  }
  
  public void update(int retraso){
    
   if(pos.y <= height/2+20){
     pos.y = cos(uwu)*20+height/2-20;
   }
   
   else{
     pos.y = (height/2-20);
     pos.x = 0; 
     pos.z = 0;
     uwu = 0;
   }
   
   pos.x = cos(uwu)*20+width/2;
   pos.z = sin(uwu)*20;
   uwu = uwu + 0.005;
  }
  
  public void show(float esferasNum){
        
    sphereSize[0] = 5*(1-sin(abs(height/2 - pos.y)/20));

    float angulo = TWO_PI/esferas.length;
    
    noStroke();
    fill(255);
    pushMatrix();
    //translate(cos(uwu)*cos((uwu/2.05)-HALF_PI)*20+400,pos.y,(sin(uwu)*cos(uwu/2.05)-HALF_PI)*20);
    translate(pos.x,pos.y,pos.z);
    sphere(sphereSize[0]);
    popMatrix();  
    /*
    for(float i=0; i < 10; i++){
       
      pushMatrix();
      
      if(esferasNum %2 != 0){
        translate(cos(uwu+angulo*(i-0.5))*cos((uwu/2.05)-HALF_PI)*20+400,pos.y,(sin(uwu+angulo*(i-0.5))*cos(uwu/2.05)-HALF_PI)*20);
      }
      
      else{
        translate(cos(uwu+angulo*i)*cos((uwu/2.05)-HALF_PI)*20/*(1-cos(asin(sS/4)))+400,pos.y,(sin(uwu+angulo*i)*cos((uwu/2.05)-HALF_PI)*20/*(1-cos(asin(sS/4)))));
      }
      
      if(uwu >= TWO_PI){
        sphere(sphereSize[0]);
      }
      popMatrix();     
      */
    } 
  }
