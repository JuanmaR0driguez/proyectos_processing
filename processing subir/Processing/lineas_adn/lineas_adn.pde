Punto[] puntos;
float tiempo;
int nos;
boolean recording = false;

public void setup(){
  
  size(800,600, P3D);
  
  tiempo=0;
  
  nos = 75;
  
  puntos = new Punto[nos*2];
  
  for(int i=0; i < puntos.length; i++){
    
    puntos[i] = new Punto(i);
  }
  camera(width/2, height/2-75, 275, width/2, height/2, -100, 0,1,0);
}

public void draw(){
  background(255);
  
  for(int i = 0; i< puntos.length; i++){
    puntos[i].update(i);
    puntos[i].show(i);
    
  }
  
  tiempo = tiempo+0.1;
  
  if(recording){saveFrame("output/flowfield_####.png"); fill(0,255,0);}//guardo los frames de la grabacion en una carpeta que se llama output
  else{fill(255,0,0);} //este fill, el de arriba y lo de abajo crean una esfera que cambia de color cuando estoy grabando, para saber si estoy grabando o no
  noStroke();
  pushMatrix();
  translate(400,300,10); 
  sphere(20); 
  popMatrix();
}

void keyPressed(){
  if(key == 'r' || key == 'R'){recording =! recording;}
    }

class Punto{
  
  PVector pos;
  
  Punto(int i){
    /*revisar, se ve bonito
    if(i%2==0){
    pos = new PVector(width/3, 2*floor(i/2)+height/3-30, 0);
    }
    else{
      pos = new PVector(2*width/3, 4*floor(i/2)+height/3-30, 0);
    }
    */
    if(i%2==0){
    pos = new PVector(width/3, 3*floor(i/2)+height/3-40, 0);
    }
    else{
      pos = new PVector(2*width/3, 3*floor(i/2)+height/3-40, 0);
    }
  }
  
  public void update(int i){
    /* revisar, se ve bonito
    pos.x = width/2+ 50*cos(tiempo/2+i*PI+i);
    pos.z = 50*sin(tiempo/2+i*PI+i);
    */
    
    pos.x = width/2 + 75*cos(-(tiempo/3+i*PI+0.0825*floor(i/2)));
    pos.z = 75*sin(-(tiempo/3+i*PI+0.0825*floor(i/2)));
    
  }
  
  public void show(int i){
    stroke(0);
    strokeWeight(3);
    if(i%2!=0){
    line(pos.x, pos.y, pos.z, puntos[i-1].pos.x, puntos[i-1].pos.y, puntos[i-1].pos.z);
    }
  }
  
}
