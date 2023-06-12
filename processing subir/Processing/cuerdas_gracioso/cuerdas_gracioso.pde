Strings[] strings;
float tiempo;
int nop, nos;
boolean recording=false;

public void setup(){
  nop = 100;
    nos = 10;
  size(900,600,P3D);
  strings = new Strings[nop*nos];
  for(int i = 0; i < strings.length; i++){
      strings[i] = new Strings(i);    
        }
          tiempo = 0;
  camera(width/2, height/2-75, 250, width/2,height/2,-200, 0,1,0);
}

void keyPressed(){
    if(key == 'r' || key == 'R'){recording = !recording;}
        } //esto es pa grabar, grabas con la R

public void draw(){
  background(255);
  for(int i = 0; i < strings.length; i++){
      strings[i].update(i);
          strings[i].show(i);
            }
  tiempo = tiempo+0.1;
    if(recording){saveFrame("output/flowfield_####.png"); fill(0,255,0);}//guardo los frames de la grabacion en una carpeta que se llama output
      else{fill(255,0,0);} //este fill, el de arriba y lo de abajo crean una esfera que cambia de color cuando estoy grabando, para saber si estoy grabando o no
        noStroke();
          pushMatrix();
            translate(400,300,10); 
             // sphere(20); 
                popMatrix();
                }
class Strings {
  PVector pos;
  Strings(int i){
       pos = new PVector(width/3+i*3-floor(i/nop)*(nop*3),i);
  }
  public void update(int i){
    pos.y = (pow(((floor(i/nop)-10)/1.5),2)+5)*cos((width/2-pos.x))*cos(tiempo*(floor(i/nop)+1)*0.25+HALF_PI)*0.25+floor(i/nop)*25+150;
    
        // pos.y = 20*cos((width/2-pos.x)/(PI*PI*100/(2*floor(i/nop)+1)))*cos(tiempo)+height/2;
  }
  public void show(int i){
     /*
        fill(0);
           noStroke();
              pushMatrix();
                 translate(pos.x, pos.y, pos.z);
                    sphere(5);
                       popMatrix();
                          */
   //stroke(255-(pow(1.25*(floor(i/nop)-10),2)+98.75));
   stroke(15.5);
   //strokeWeight(pow(((floor(i/nop)-10)/5),2)+2);
   strokeCap(ROUND);
      //line (width/3, height/3, 0, width*2/3, height/3, 0);
   if(i%100 != 0){
     line(pos.x, pos.y, pos.z, strings[i-1].pos.x, strings[i-1].pos.y, strings[i-1].pos.z);
   }
   point(pos.x, pos.y, pos.z);
  }
}
