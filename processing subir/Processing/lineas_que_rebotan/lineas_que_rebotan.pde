boolean[] rebotar;
PVector[] puntos;
void setup(){

  size(600,600);
  puntos = new PVector[50];
  rebotar= new boolean [50];
  for(int i = 0 ; i < puntos.length ; i++){
    puntos[i] = new PVector(i*10,0);
    rebotar[i] = false; 
  }
}

void draw(){

  background(0);
  
  stroke(0,143,57);
  strokeWeight(4);
  
  for(int i = 0; i < puntos.length; i++){
    if (rebotar[i] ==true){
     puntos[i].x -= 1;
    }
    else if (rebotar[i] ==false){
    puntos[i].x += 1;
    }
    
    if (puntos[i].x >= 600){
       rebotar[i] = true;
    }
    if ( puntos[i].x <=0){
      rebotar[i] = false;
    }
    
    puntos[i].y = 10*sin(puntos[i].x/10)+height/2;
    line(puntos[i].x, puntos[i].y, puntos[i].x +5, puntos[i].y + 20 ); 
  
  } 

}
