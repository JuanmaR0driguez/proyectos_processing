/*import android.os.Environment;
String my_folder = "Sketchbook/my_frames"; // Must be an existing folder one level above absolute path
String data_folder_path = new String(Environment.getExternalStorageDirectory().getAbsolutePath()+"/"+my_folder+"/");
PImage pi;
int tel = 0;
*/
//int[] trid;
//int[] pend;

float inc =0;
float r = 2000;
float r2 = r*1.1;
PShape[] pen;
PShape[] tri;
void setup() {
  size(displayWidth, displayHeight);
  background(0);
  pen = new PShape[100];
  tri = new PShape[pen.length];
 // trid = new int[pen.length];
  //pend = new int[pen.length];
  for(int i=0; i < pen.length; i++){
     pen[i] = createShape();
     tri[i] = createShape();
     //pend[i] = 0;
   // trid[i] = 0;
    
  if(r >=0 && r2 >= 0){
  translate(width / 2, height / 2);
  
  stroke(0);
  strokeWeight(4);
  
  int pr = 206-i*7;
  int pg = 132-i*7;
  int pb = 119-i*7;
  pen[i].setFill(color(pr,pg,pb));
  
  pen[i].beginShape();
  for (float a = -TWO_PI/4; a < TWO_PI-TWO_PI/4; a += TWO_PI/5) {
    float x = r * cos(a);
    float y = r * sin(a);
    pen[i].vertex(x, y);
  }
  pen[i].endShape(CLOSE);
  //pen[i].setFill(color(206-pend[i],132-pend[i],119-pend[i]));
  
  int tr = 178-i*13/2;
  int tg = 74-i*7;
  int tb = 59-i*7;
  tri[i].setFill(color(tr, tg,tb));
  tri[i].beginShape();
  for (float a = -TWO_PI/4; a < TWO_PI-TWO_PI/4; a += TWO_PI/5) {
    
    float x1 = r2 * cos(a - PI/18);
    float y1 = r2 * sin(a - PI/18);
    float x2 = r2 * cos(a + PI/18);
    float y2 = r2 * sin(a + PI/18);
    
    tri[i].vertex(x1, y1);
    tri[i].vertex(x2, y2);
    tri[i].vertex(0,0);
  }
  tri[i].endShape(CLOSE);
  
  //tri[i].setFill(color(178-trid[i],74-trid[i],59-trid[i]));
  r-=100;
  r2-= 110;
}
}
    
    
}

void draw() {
  translate(width/2, height/2+55);
  rotate(inc);
  for(int i=0;i<pen.length;i++){
    rotate(inc);
    shape(pen[i]);
    shape(tri[i]);
    }
    rotate(-inc);
  fill(150,150,0);
  ellipse(0,0,100,100);
  rotate(inc);
  translate(-width/2, -height/2-55);
  inc += 0.002;
 // saveFrame("line-");
}
/*
void saveFrame(String s) {
  int maxHashes=6; 
  tel++;
  String fs = String.format("%1$" + maxHashes + "s", tel).replace(' ', '0');
  pi = get(0, 0, width, height);
  pi.save(data_folder_path+s+fs+".png");
}  */