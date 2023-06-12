float inc = 0.1f;
float scl = 100;
int cols, rows;
float zoff = 0;
Particle[] particles;
PVector[] flowField;
Repeller repeller;

 public void setup()
{
  size(800,600,P3D);/* size commented out by preprocessor */;
  cols = 100;
  rows = 100;
  
  particles = new Particle[7000];
  for(int i = 0; i < particles.length; ++i)
    particles[i] = new Particle();
    
  flowField = new PVector[cols * rows];
  repeller = new Repeller(350,500,0);

camera(350, 600, -60, 400, 300, 200, 0, 0, 1);
}
    

 public void draw()
{
    background(0);
//lights();
noStroke();
fill(0);
pushMatrix();
translate(350,500,0);
sphere(10);
popMatrix();
    
  float yoff = 0;
  for(int y = 0; y < rows; y++) {
    float xoff = 0;
    for(int x = 0; x < cols; x++) {
      // set the vector in the flow field
      int index = x + y * cols; 
      float angle = -2;
      PVector v = PVector.fromAngle(angle);
      v.setMag(10f); // set the power of the field on the particle
      flowField[index] = v;
      
      xoff += inc;
    }
    yoff += inc;
  }
  
  // update and draw the particles
  for(int i = 0; i < particles.length; ++i) {
    particles[i].follow(flowField);
    particles[i].update();
    particles[i].show();
    particles[i].applyRepeller(repeller);
  }
}
class Particle {
  PVector pos = new PVector(random(width - 1), random(height - 1)); // position
  PVector vel = new PVector(0, 0); // velocity
  PVector acc = new PVector(0, 0); // acceleration
  PVector prevPos = pos.copy(); // previous position
  float maxSpeed = 2f;
  
   public void update() {
    // keep current position
    prevPos.x = pos.x; 
    prevPos.y = pos.y; 
    
    // apply acceleration and velocitiy
    vel.add(acc); 
    vel.limit(maxSpeed); // limit velocity
    pos.add(vel); 
    
    // handle window edges
    if(pos.x >= 650) pos.x = prevPos.x = random(50, 150);
    if(pos.x < 50) pos.x = prevPos.x = random(600, 649);
    if(pos.y >= 751) pos.y = prevPos.y = random(150, 175);
    if(pos.y < 150) pos.y = prevPos.y = random(600, 750);
   
    
    // reset acceleration
    acc.mult(0); 
  }
  
   public void applyForce(PVector force) {
    acc.add(force);
  }
  
   public void show() {
    stroke(255);
    strokeWeight(2);
    point(pos.x, pos.y);
  }
  
   public void follow(PVector[] flowField) {
    // get the index in the flow field
    int x = floor(pos.x / scl);
    int y = floor(pos.y / scl);
    int index = x + y * cols;
    
    // get the force and apply it
    PVector force = flowField[index];
    applyForce(force);
  }
  
   public void applyRepeller(Repeller r) {
    PVector repelforce = r.repel(pos);
    applyForce(repelforce);
}
}
class Repeller {
  float strength = 7000;
  PVector location;
  float r = 10;
 
  Repeller(float x, float y, float z)  {
    location = new PVector(x,y,z);
  }
 
   public void display() {
    stroke(255);
    fill(255);
    ellipse(location.x,location.y,r*2,r*2);
  }
  
   public PVector repel(PVector pos){
    PVector dir = PVector.sub(location, pos);
    float d = dir.mag();
    dir.normalize();
    d = constrain(d,5,100);
    float force = -1 * strength / (d * d * d);
    dir.mult(force);
    return dir;
  }
}
