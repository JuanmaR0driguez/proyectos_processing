
float increment=4;
float noiseMax, angle,check;


void setup() {
  size(displayWidth, displayHeight);
  colorMode(RGB,255,255,255);
  background(0);
  noiseMax = random(50);
  check = random(2);
  angle = radians(int(random(5,15)));
}
void draw(){
  
  poligono();
  
  }
void poligono(){
  if(increment <=70){
  if(check >= 1){
  translate(width / 2, height / 2 +57);
  stroke(255);
  strokeWeight(2);
  noFill();
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    
    float xoff = map(cos(a), -1, 1, 0, noiseMax);
    float yoff = map(sin(a), -1, 1, 0, noiseMax);
    float r = map(noise(xoff, yoff, 0), 0, 1, 100, height / increment);
    float x = r * cos(a);
    float y = r * sin(a);
    vertex(x, y);
    
  }
  endShape(CLOSE);
  }
  else{
  translate(width / 2, height / 2 +57);
  stroke(255);
  strokeWeight(2);
  noFill();
  beginShape();
  angle = radians(1);
  noiseMax = random(5,8);
  for (float a = 0; a < TWO_PI; a += angle) {
   
    float xoff = map(cos(a), -1, 1, 0, noiseMax);
   float yoff = map(sin(a), -1, 1, 0, noiseMax);
   float r = map(noise(xoff, yoff, 0), 0, 1, 100, height / increment);
    
    float x = r * cos(a);
    float y = r * sin(a);
    vertex(x, y);
   
  }
  endShape(CLOSE); 
    }  
 increment +=0.5;
}
translate(-width / 2, -height / 2 -57);


  }
  
  void mousePressed(){
    background(0);
  increment = 4;
  noiseMax = random(50);
  check = random(2);
  angle = radians(int(random(5,15)));
  // draw();
  
    
    }
