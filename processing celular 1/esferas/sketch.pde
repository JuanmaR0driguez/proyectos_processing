float uwu, incremento, radio_eg, esferas_num, distancia_aros, radio_ec;
int aros_num;
Esfera esfera;
float[] sphereSize, posy, radio;
boolean recording = false;

public void setup(){
  
  size(800,600, P3D);
  
  aros_num = 35;
  uwu = TWO_PI;
  incremento = TWO_PI/1250;
  radio_eg = 30;
  distancia_aros = 2.5;
  radio_ec = 1.5;
  esferas_num = 20;
  
  esfera = new Esfera();
  sphereSize = new float[aros_num];
  posy = new float[aros_num];
  radio = new float[aros_num];
  
  for(int i = 0; i < aros_num; ++i){
    sphereSize[i] = 0;
    posy[i] = 0;
    radio[i] = 0;
  }
  
  camera(width/2,height/2-radio_eg, 100, width/2, height/2, 0, 0,1,0);
  background(0);
}

void keyPressed(){
    if(key == 'r' || key == 'R'){recording = !recording;}
    } //esto es pa grabar, grabas con la R


public void draw(){
  
  //lights();
  background(255);
  
  esfera.update();
  esfera.show();
  
  for(float i = 0; i < 2*radio_eg; i++){
    float z = i - radio_eg;
    fill(255,10);
    beginShape();
    vertex(0,0,z);
    vertex(800,0,z);
    vertex(800,600,z);
    vertex(0,600,z);
    endShape();
    
  }
  
  if(recording){saveFrame("output/flowfield_####.png"); fill(0,255,0);}//guardo los frames de la grabacion en una carpeta que se llama output
  else{fill(255,0,0,0);} //este fill, el de arriba y lo de abajo crean una esfera que cambia de color cuando estoy grabando, para saber si estoy grabando o no
  noStroke();
  pushMatrix();
  translate(400,300,10); 
  sphere(20); 
  popMatrix();
  
}

class Esfera {
  
  PVector pos = new PVector(width/2,height/2-distancia_aros,0);
  
  
  public void update(){
    
   if(pos.y <= height/2+distancia_aros){
     pos.y = pos.y + 5*incremento;
   }
   
   else{
     pos.y = height/2-distancia_aros;
     pos.x = 0; 
     pos.z = 0;
   }
   
   if(uwu == 10*TWO_PI){
     
     uwu = TWO_PI;
     
   }
   
   pos.x = cos(uwu)*radio_eg+width/2;
   pos.z = sin(uwu)*radio_eg;
   uwu = uwu + incremento;
  }
  
  public void show(){
    
    float angulo = TWO_PI/esferas_num;
    
    noStroke();
    fill(0);
    
    for (int i = 0; i < posy.length; i++){
      
      posy[i] = pos.y + ((i-(posy.length/2))*distancia_aros);
      
      sphereSize[i] = radio_ec*(1-sin(abs(height/2 - posy[i])/radio_eg));
      
      radio[i] = sqrt((radio_eg*radio_eg)-((posy[i]-height/2)*(posy[i]-height/2)));

      //sphereSize[i] = sqrt((radio_ec*radio_ec)-((posy[i]-height/2)*(posy[i]-height/2)));
      
      //lo que esta comentado se ve interesante, investigar
      
    }
    
    for(float i=0; i < esferas_num; i++){
      for(int sS = 0; sS < aros_num ; sS++){
        
        pushMatrix();
        
        if(sS%2 != 0){
          translate(cos(uwu+angulo*(i-0.5))*radio[sS]+width/2, posy[sS], (sin(uwu+angulo*(i-0.5))*radio[sS]));
        }
        //restar uno a i arriba, se ve interesante
        else{
          translate(cos(uwu+angulo*i)*radio[sS]+width/2, posy[sS], (sin(uwu+angulo*i)*radio[sS]));
       }
        
        if(uwu >= TWO_PI){
          sphere(sphereSize[sS]);
        }
        
        popMatrix();
      }  
    } 
  }
}
