Strings[] strings;
float tiempo;
int nop, nos;
boolean recording=false;

public void setup(){
  nop = 100;
    nos = 10;
  size(900,600,P2D);
  strings = new Strings[nop*nos];
  for(int i = 0; i < strings.length; i++){
      strings[i] = new Strings(i);    
        }
          tiempo = 0;
}
public void draw(){
  background(255);
  for(int i = 0; i < strings.length; i++){
      strings[i].update(i);
          strings[i].show(i);
            }
  tiempo = tiempo+0.1;
}
class Strings {
  PVector pos;
  float oldposy;
  Strings(int i){
       pos = new PVector(width/3+i*3-floor(i/nop)*(nop*3),i);
  }
  public void update(int i){
    oldposy = pos.y;
    pos.y = (pow(((floor(i/nop)-10)/1.5),2)+5)*sin((pos.x-width/3)*(floor(i/nop)+1)/95.5)*cos(tiempo*(floor(i/nop)+1)*0.25+HALF_PI)*0.5+floor(i/nop)*50+50;
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
   strokeWeight(1);
   //strokeWeight(pow(((floor(i/nop)-10)/5),2)+2);
   strokeCap(ROUND);
      //line (width/3, height/3, 0, width*2/3, height/3, 0);
   if(i%100 != 0){
     line(pos.x, pos.y, strings[i-1].pos.x, strings[i-1].pos.y);
   }

   point(pos.x, pos.y);
  }
}
