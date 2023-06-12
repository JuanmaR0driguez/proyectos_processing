import processing.sound.*;

SinOsc[] pulses;

Strings[] strings;
float tiempo;
int nop, nos;
boolean recording=false;
int mx, my;
boolean[] playing;

public void setup() {
  nop = 100;
  nos = 7;
  tiempo = 0;
  size(900, 600, P2D);
  strings = new Strings[nop*nos];
  pulses = new SinOsc[nos];
  playing = new boolean[nos];
  for (int i = 0; i < strings.length; i++) {
      strings[i] = new Strings(i);
  }
  for(int i = 0;i < pulses.length; i++){
  pulses[i] = new SinOsc(this);
  }
}
public void draw() {
  background(255);
  for (int i = 0; i < strings.length; i++) {
    strings[i].update(i);
    strings[i].show(i);
  }
  tiempo = tiempo+0.1;
}
class Strings {
  PVector pos;
  float oldposy;
  Strings(int i) {
    pos = new PVector(width/4+i*5-floor(i/nop)*(nop*5), i); //separarlas y alinearlas
  }
  public void update(int i) {
    oldposy = pos.y;
    pos.y = 
    
    (pow(((floor(i/nop)-10)/1.5), 2)+5)* //reduccion de amplitud
    
    sin((pos.x-width/4)*(floor(i/nop)+1)/159.16)* //Ajuste de frecuencia
    
    cos(tiempo*(floor(i/nop)+1)*0.25+HALF_PI)*0.5+ //modificacion en el tiempo
    
    floor(i/nop)*75+50; //ordenarlas de arriba a abajo
  }
  public void show(int i) {
if(playing[floor(i/nop)] == true){
    stroke(255,0,0);
}
else{stroke(0);}
    strokeWeight(2);
    strokeCap(ROUND);
    if (i%100 != 0) {
      line(pos.x, pos.y, strings[i-1].pos.x, strings[i-1].pos.y);
    }
    point(pos.x, pos.y);
  }
}

void mousePressed(){
int i = max(0, floor((mouseY-37.5)/75));
if(i < nos){
  if(playing[i] == false){
     
      pulses[i].play(110*(i+1),0.05);
    playing[i] = true;
    }
else{pulses[i].stop(); playing[i] = false;}
}
}
