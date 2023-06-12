boolean[][] rebotar;
PVector[][] puntos;

void setup(){

  size(600,600);
  puntos = new PVector[79][20];
  rebotar= new boolean[79][20];
  for(int i = 0 ; i < puntos.length ; i++){
    for(int j = 0 ; j < puntos[i].length ; j++){
    puntos[i][j] = new PVector(i*10,j*20);
    rebotar[i][j] = false; 
  }}
  colorMode(HSB,800,255,255);
}

void draw(){

  background(0);
  
  
  
  
  for(int i = 0; i < puntos.length; i++){
    for(int j = 0 ; j < puntos[i].length ; j++){
    if (rebotar[i][j] == true){
     puntos[i][j].x -= 1;
    }
    else if (rebotar[i][j] ==false){
    puntos[i][j].x += 1;
    }
    
    if (puntos[i][j].x >= 600){
      //puntos[i][j].x =0;
      rebotar[i][j] = true;
    }
    if ( puntos[i][j].x <=0){
      rebotar[i][j] = false;
    }
    stroke( j*40, 200,255);
    strokeWeight(4);
    puntos[i][j].y = 10*sin(puntos[i][j].x/10)+height-j*40;
    line(puntos[i][j].x, puntos[i][j].y, puntos[i][j].x +5, puntos[i][j].y + 20 ); 
  
  } 
  }
}
