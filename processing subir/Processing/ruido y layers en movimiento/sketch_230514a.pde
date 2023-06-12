float increment = 0.01;
PVector g,v,p;
PGraphics l1, l2, l3, s1, s2, s3;
int cw, ch;
int config;
color b, c1,c2,c3;
float zoff = 0;
int oX;

void setup() {
  
  size(800,600, P2D);
  config = int(random(5)); 
  switch(config){
    
    case 0:
    b = color(72,161,77);
    c1= color(237,148,77);
    c2= color(240,215,49);
    c3= color(179,63,64);
    break;
    
    case 1:
    b = color(72,161,77);
    c1= color(240,215,49);
    c2= color(237,148,77);
    c3= color(179,63,64);
    break;
    
    case 2:
    b=color(143,176,206);
    c1= color(101,119,179);
    c2= color(44,111,187);
    c3= color(11,11,96);
    break;
    
    case 3:
    b= color(83,54,33);
    c1= color(104,76,61);
    c2= color(135,99,48);
    c3= color(193,145,103);
    break;
    
    case 4:
    b= color(28,28,28);
    c1= color(84,84,84);
    c2= color(117,117,116);
    c3= color(206,207,210);
    break;
    }
    
  orientation(PORTRAIT);
  g = new PVector(0,9.8);
  v = new PVector(0,0);
  p = new PVector(0,0);
  
  cw = width+300;
  ch = height+300;
  
  noiseDetail(2,0.9); 
  imageMode(CENTER);
  
  l1 = createGraphics(cw, ch);
  l2 = createGraphics(cw, ch);
  l3 = createGraphics(cw, ch);
  s1 = createGraphics(cw, ch);
  s2 = createGraphics(cw, ch);
  s3 = createGraphics(cw, ch);
  
  noiseSeed(int(random(100)));
  background(red(b), green(b), blue(b));
 
}
void draw(){
  
  background(red(b), green(b), blue(b));
  
  g.set(0,9.8);
  g.mult(0.075);
  p.add(g);
  p.limit(3);
  
 
  
  l1.beginDraw();
  l2.beginDraw();
  l3.beginDraw();
  s1.beginDraw();
  s2.beginDraw();
  s3.beginDraw();
  
  l1.clear();
  l2.clear();
  l3.clear();
  s1.clear();
  s2.clear();
  s3.clear();
  
  l1.loadPixels();
  l2.loadPixels();
  l3.loadPixels();
  s1.loadPixels();
  s2.loadPixels();
  s3.loadPixels();
  
  float xoff = 0.0;
  
    for (int x = 0; x < cw; x++) {
    xoff += increment;
    float yoff = 0.0;
    for (int y = 0; y < ch; y++) {
      yoff += increment;
      
      float noise = noise( xoff, yoff, zoff);
      
      if(noise > 0.40){
        l1.pixels[x+y*cw] = c1;
      }
      if(noise > 0.60){
        l2.pixels[x+y*cw] = c2;
      }
      if(noise > 0.75){
        l3.pixels[x+y*cw] = c3;
      }
    }
  }
  
  zoff = (mouseX+mouseY-700)*0.02;
  l1.updatePixels();
  l2.updatePixels();
  l3.updatePixels();
  /*
  l1.filter(BLUR, 1);
  l2.filter(BLUR, 1);
  l3.filter(BLUR, 1);
*/
  l1.endDraw();
  l2.endDraw();
  l3.endDraw();
  
  s1.set(0,0,l1);
  s2.set(0,0,l2);
  s3.set(0,0,l3);

  s1.filter(THRESHOLD, 1);
  s2.filter(THRESHOLD, 1);
  s3.filter(THRESHOLD, 1);
  /*
  s1.filter(BLUR, 4);
  s2.filter(BLUR, 4);
  s3.filter(BLUR, 4);
  */
  s1.updatePixels();
  s2.updatePixels();
  s3.updatePixels();
  
  s1.endDraw();
  s2.endDraw();
  s3.endDraw();
  
  image(s1, width/2+p.x*2, height/2+p.y*2);
  image(l1, width/2+p.x*4, height/2+p.y*4);
  image(s2, width/2+p.x*5, height/2+p.y*5);
  image(l2, width/2+p.x*7, height/2+p.y*7);
  image(s3, width/2+p.x*8, height/2+p.y*8);
  image(l3, width/2+p.x*10, height/2+p.y*10);
  
  oX = mouseX; 
}
