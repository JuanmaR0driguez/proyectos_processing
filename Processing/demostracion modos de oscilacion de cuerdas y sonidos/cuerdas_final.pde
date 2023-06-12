import processing.sound.*;

SinOsc[] pulses;

Strings[] strings;
float tiempo;
int nop, nos;
boolean recording=false;
int mx, my;
boolean[] playing;
float[] initialAmp;
int separacion;

public void setup() {
  nop = 100;
  nos = 7;
  tiempo = 0;
  separacion =5;
  size(900, 600, P2D);
  strings = new Strings[nop*nos];
  pulses = new SinOsc[nos];
  initialAmp = new float[nos];
  playing = new boolean[nos];
  for (int i = 0; i < strings.length; i++) {
      strings[i] = new Strings(i);
  }
  for(int i = 0;i < pulses.length; i++){
  pulses[i] = new SinOsc(this);
  initialAmp[i] = 1;
  }
}
public void draw() {
  background(255);
  noFill();
  for (int i = 0; i < strings.length; i++) {
    int u = floor(i/nop);
    strings[i].update(u);
    strings[i].show(i,u);
    stroke(0);
    line(0, u*75+90, width/4-40, u*75+90);
    line(width/4+nop*separacion-10, u*75+90, width, u*75+90);
    
  }
  tiempo = tiempo+0.1;
  stroke(0);
  line(width/4-40,0,width/4-40,height);
  line(width/4+nop*separacion-10,0,width/4+nop*separacion-10,height);
  
  
  
}
class Strings {
  PVector pos;
  float oldposy;
  Strings(int i) {
    pos = new PVector((width/4-25)+i*5-floor(i/nop)*(nop*separacion), i); //separarlas y alinearlas
  }
  public void update(int u) {
    oldposy = pos.y;
    pos.y = 
    
    initialAmp[u]*(pow(((u-10)/1.5), 2)+5)* //reduccion de amplitud
    
    sin((pos.x-(width/4-25))*(u+1)/(31.8*separacion))* //Ajuste de frecuencia
    
    cos(tiempo*(u+1)*0.25+HALF_PI)*0.5+ //modificacion en el tiempo
    
    u*75+50; //ordenarlas de arriba a abajo
  }
  public void show(int i, int u) {
if(playing[u] == true){
    stroke(255,0,0);
}
else{stroke(0);}
    strokeWeight(2);
    strokeCap(ROUND);
    if (i%100 != 0) {
      line(pos.x, pos.y, strings[i-1].pos.x, strings[i-1].pos.y);
    }
    point(pos.x, pos.y);
    line(width/8-12.5,u*75+37.5,75,u*75+62.5);
    line(width/8-12.5,u*75+62.5,75,u*75+37.5);
    line((7*width/8+12.5),u*75+37.5,(7*width/8+12.5),u*75+62.5);
  }
}

void mousePressed(){
int i = max(0, floor((mouseY-15)/75));
if(mouseX <= (width/4-40)){
initialAmp[i] = 0;
 pulses[i].amp(initialAmp[i]*0.05);
}
else if(mouseX >= (width/4+nop*separacion-10)){

initialAmp[i] = 1;
 pulses[i].amp(initialAmp[i]*0.05);
}
else{
if(i < nos){
  if(playing[i] == false){
     
      pulses[i].play(110*(i+1),initialAmp[i]*0.05);
    playing[i] = true;
    }
else{pulses[i].stop(); playing[i] = false;}
}
}


}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  e /= 10;
  int i = max(0, floor((mouseY-37.5)/75));

  if(initialAmp[i] - e >= 0){
  initialAmp[i] -= e;
    }
    else{initialAmp[i] = 0;}
    pulses[i].amp(initialAmp[i]*0.05);
}
