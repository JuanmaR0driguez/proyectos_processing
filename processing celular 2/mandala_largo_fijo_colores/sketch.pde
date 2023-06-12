PVector uno, dos, uno2, dos2;
float unoradio, dosradio, t, fq, t2, h;
boolean bounceColor;

void setup(){
  
  size(displayWidth, displayHeight, P2D);
  
  uno = new PVector(0,0);
  
  dos = new PVector(0,0);
  
  uno2 = new PVector(0,0);
  
  dos2 = new PVector(0,0);
  
  t = 0;
  
  t2=0;
  
  h=0;
  
  fq= 4;
  
  bounceColor = false;
  
  unoradio = 800;
  
  dosradio = 420;
  
  background(0);
  
  colorMode(HSB);
  
  }
 
void draw(){
  if(t>=3*PI/2){
      
    uno2.set(width/2 + cos(t2*fq) * unoradio, height/2 +55+ cos(t2)*cos(t2*fq/2) *unoradio);
   
   
    dos2.set(width/2 + cos(t2) * dosradio, height/2+55+ sin(t2) * dosradio);
   
    PVector menos2 = PVector.sub(uno2,dos2);
   
    menos2.normalize();
 
    menos2.mult(180);
   
    stroke(0);
  
    strokeWeight(1);
  
    line(dos2.x, dos2.y, dos2.x+menos2.x, dos2.y+menos2.y);
    
    strokeWeight(1);
    fill(0);
    
    pushMatrix();
    beginShape();
    vertex(width/2,height/2+55);
    vertex(width/2+(dosradio+100)*cos(t2-0.25), height/2+55+(100+dosradio)*sin(t2-0.25));
    vertex(dos2.x, dos2.y);
    vertex(dos2.x+menos2.x, dos2.y+menos2.y);
    endShape();
    popMatrix();
    t2 += fq*0.001;
    }
    uno.set(width/2 + cos(t*fq) * unoradio, height/2 +55+ cos(t)* cos(t*fq/2) *unoradio);
   
   
    dos.set(width/2 + cos(t) * dosradio, height/2+55+ sin(t) * dosradio);
   
    PVector menos = PVector.sub(uno,dos);
   
    menos.normalize();
 
    menos.mult(180);
  
  if(h >= 255){
     bounceColor = true;
    }
    else if(h<=0){
      bounceColor = false;
      }
      
      if(bounceColor){
        h-=0.04;
        }
  else{
    h += 0.04;
    }
    stroke(h,200,255);
  
    strokeWeight(1);
  
    line(dos.x, dos.y, dos.x+menos.x, dos.y+menos.y);
  
    
    t += fq*0.001;
    
    
    
  }