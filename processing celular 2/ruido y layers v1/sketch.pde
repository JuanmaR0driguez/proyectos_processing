float increment = 0.002;
AccelerometerManager accel;
float ax, ay, az, lastAx, lastAy, dgX, dgY;
PVector g,v,p;
PGraphics ca,cn,cr,sa,sn,sr;
int cw, ch;
int config;
color b, c1,c2,c3;
PShader blur;
float px = 0;
float py = 0;
PImage sai, sni, sri;
    

void setup() {
  
  fullScreen(P2D);
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
    
  blur = loadShader("blur.glsl");

  orientation(PORTRAIT);
  g = new PVector(0,0);
  v = new PVector(0,0);
  p = new PVector(0,0);
  cw = width+300;
  ch = height+300;
  noiseDetail(2,0.9); 
  imageMode(CENTER);
  
  background(72,161,77);
  
  ca = createGraphics(cw, ch);
  
  cn = createGraphics(cw, ch);
  cr = createGraphics(cw, ch);
  sa = createGraphics(cw, ch);
  sn = createGraphics(cw, ch);
  sr = createGraphics(cw, ch);
  
  noiseSeed(int(random(100)));
  
  ca.beginDraw();
  
  cn.beginDraw();
  cr.beginDraw();
  sa.beginDraw();
  sn.beginDraw();
  sr.beginDraw();
  
  
  ca.loadPixels();
  cn.loadPixels();
  cr.loadPixels();
  
  float xoff = 0.0;
  
    for (int x = 0; x < cw; x++) {
    xoff += increment;
    float yoff = 0.0;
    for (int y = 0; y < ch; y++) {
      yoff += increment;
      
      float noise = noise(xoff, yoff);
      
      if(noise > 0.40){
        ca.pixels[x+y*cw] = c1;
      }
      if(noise > 0.60){
       cn.pixels[x+y*cw] = c2;
      }
      if(noise > 0.75){
        cr.pixels[x+y*cw] = c3;
      }
    }
  }
  
  ca.updatePixels();
  cn.updatePixels();
  cr.updatePixels();
  /*
  ca.filter(BLUR,1.25);
  cn.filter(BLUR,1.25);
  cr.filter(BLUR,1.25);
  */
  //ca.filter(blur);
  //cn.filter(blur);
  //cr.filter(blur);
  
  ca.endDraw();
  cn.endDraw();
  cr.endDraw();
 
  sa.copy(ca,0,0,cw,ch,0,0,cw,ch);
  sn.copy(cn,0,0,cw,ch,0,0,cw,ch);
  sr.copy(cr,0,0,cw,ch,0,0,cw,ch);
  
  sa.filter(THRESHOLD, 1);
  sn.filter(THRESHOLD, 1);
  sr.filter(THRESHOLD, 1);
  /*
  sa.filter(BLUR, 4);
  sn.filter(BLUR, 4);
  sr.filter(BLUR, 4);
 */
 // sa.filter(blur);
  //sn.filter(blur);
  //sr.filter(blur);
 
  sa.endDraw();
  sn.endDraw();
  sr.endDraw();
 
 /*
  sai = sa.get(0,0,cw/4, cw/4);
  sni = sn.get(0,0,cw/4, cw/4);
  sri = sr.get(0,0,cw/4, cw/4);
  
  sai.resize(0, ch/4);  
  sni.resize(0, ch);
  sri.resize(0, ch);    
  */
}
void draw(){
  
  background(red(b), green(b), blue(b));
  
  g.set(-ax,ay);
  g.mult(0.075);
  p.add(g);
  p.limit(10);
  
  
  shift(sa, 2);
  shift(ca, 4);
  shift(sn, 5);
  shift(cn, 7);
  
  shift(sr, 8);
  
  shift(cr, 10);
  /*
  //image(sai, width/2+p.x*2, height/2+p.y*2);
  image(sa, width/2+p.x*8, height/2+p.y*8);
  image(ca, width/2+p.x*4, height/2+p.y*4);
  image(sn, width/2+p.x*5, height/2+p.y*5);
  image(cn, width/2+p.x*7, height/2+p.y*7);
  image(sr, width/2+p.x*8, height/2+p.y*8);
  image(cr, width/2+p.x*10, height/2+p.y*10);

  */
  //shader(blur);
}
 
 void shift(PGraphics graph, float zum){
   
   px = ax*zum*2;
   
   py = -ay*zum*2;
   
   image(graph, width/2+px, height/2+py);
   
   }
   
public void resume() {
  if (accel != null) {
    accel.resume();
  }
}

public void pause() {
  if (accel != null) {
    accel.pause();
  }
}

public void accelerationEvent(float x, float y, float z) {
  ax = x;
  ay = y;
  az = z;
}
