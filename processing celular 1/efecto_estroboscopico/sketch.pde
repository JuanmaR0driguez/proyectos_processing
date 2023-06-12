float time, posx;
boolean recording;

public void setup(){
  
  size(800,600,P2D);
  time = 0;
  posx = 0;
  recording = false;
  
}

void keyPressed(){
    if(key == 'r' || key == 'R'){recording = !recording;}
    }

public void draw(){
  fill(0);
  noStroke();
  
  /*
  // ANIMACION 1
  background(255);
  ellipse(400+100*cos(time),300,100,100);
  time = time + 0.1;
  */
  
  /*
  // ANIMACION 2
  if(cos(time)>=-0.1 && cos(time)<=0.1){background(255);}
  else{background(0);}
  ellipse(400+100*cos(time),300,100,100);
  time = time + 0.1;
  */
  
  /*
  // ANIMACION 3
  background(255);
  ellipse(400+100*cos(60*time),300+100*sin(60*time),100,100);
  time = time + 0.001;
  */
  
  /*
  // ANIMACION 4
  if(cos(60*time)>=-cos(30*posx) && cos(60*time)<=cos(30*posx)){background(255);}
  else{background(0);}
  ellipse(400+100*cos(60*time),300+100*sin(60*time),100,100);
  time = time + 0.1;
  posx = posx - 0.1;
  */
  
  if(recording){saveFrame("output/flowfield_####.png"); fill(0,255,0);}//guardo los frames de la grabacion en una carpeta que se llama output
  else{fill(255,0,0);} //este fill, el de arriba y lo de abajo crean una esfera que cambia de color cuando estoy grabando, para saber si estoy grabando o no
  noStroke();
  //ellipse(400,300,100,100);
}