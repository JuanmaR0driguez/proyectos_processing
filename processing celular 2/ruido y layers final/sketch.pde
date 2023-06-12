float increment = 0.002;
float ax,ay,az;
PGraphics l1, l2, l3, s1, s2, s3;
int cw, ch;
int config;
color b, c1,c2,c3;
float px =0;
float py = 0;
AccelerometerManager accel;

void setup() {
  
  fullScreen(P2D);
  config = int(random(5));
  accel = new AccelerometerManager(this);
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
  
  l1.beginDraw();
  l2.beginDraw();
  l3.beginDraw();
  s1.beginDraw();
  s2.beginDraw();
  s3.beginDraw();
  
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
      
      float noise = noise(xoff, yoff);
      
      if(noise > 0.40){
        l1.pixels[x+y*cw] = c1;
        s1.pixels[x+y*cw] = color(0,65);
        
      }
      if(noise > 0.60){
        l2.pixels[x+y*cw] = c2;
        s2.pixels[x+y*cw] = color(0,65);
      }
      if(noise > 0.75){
        l3.pixels[x+y*cw] = c3;
        s3.pixels[x+y*cw] = color(0,65);
      }
    }
  }
  
  l1.updatePixels();
  l2.updatePixels();
  l3.updatePixels();
  
  s1.updatePixels();
  s2.updatePixels();
  s3.updatePixels();
  
 
  s1.endDraw();
  s2.endDraw();
  s3.endDraw();
  l1.endDraw();
  l2.endDraw();
  l3.endDraw();
  
  background(red(b), green(b), blue(b));
  
  
}
void draw(){
  
  background(red(b), green(b), blue(b));

 
  shift(s1, 2, true);
  shift(l1, 4, false);
  shift(s2, 5, true);
  shift(l2, 7, false);
  shift(s3, 8, true);
  shift(l3, 10, false);

}

void shift(PGraphics graph, float zum, boolean shadow){
   
   px = ax*zum*1.5;
   
   py = -ay*zum*1.5;
   
   if(shadow == true){
   
     
       for(int i = 0; i < 3; i++){
        image(graph, width/2+px+i, height/2+py+i*4);
      }
   
   }
   
   else{
     
       
        image(graph, width/2+px, height/2+py);
      }
       
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


void mousePressed(){
  
  setup();
  
  
  }