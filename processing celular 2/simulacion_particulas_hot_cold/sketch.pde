ArrayList<Particle> hotParticles;
ArrayList<Particle> coldParticles;

int radio = 10;
float friction = -1;
float speedHot = 30;
float speedCold = 15;
float speedSlider = 1;
int particleNumber = 300;
int wall;

void setup(){
  fullScreen(P2D);
  hotParticles = new ArrayList<Particle>();
  coldParticles = new ArrayList<Particle>();
  for (int i = 0; i < particleNumber; i++){
    hotParticles.add(new Particle(true));
    coldParticles.add(new Particle(false));
  }
  
  wall = height/2;
  }
  
  
void draw(){
  speedSlider = map(mouseX, 0, width, 0,1);
  wall = mouseY;
  if(mouseY == 0){
    
    wall = height/2;
    
    }
  background(0);
  
  noStroke();
  
  for (Particle p : hotParticles){
    
    
    p.attractRepell(hotParticles);
    p.update();
    p.calculateWalls();
    p.show();
    
    }
    
  for (Particle p : coldParticles){
    
    
    p.attractRepell(coldParticles);
    p.update();
    p.calculateWalls();
    p.show();
    
    }
    
  stroke(255);
  strokeWeight(3);
  line(0,wall, width, wall);
  fill(0);
  ellipse(mouseX, wall, 80,80);
  
  
  
  }
  
  
  class Particle{
    
  
  PVector pos;
  PVector vel;
  PVector acc;
  float maxSpeed;
  boolean isHot;
  
    Particle(boolean hot){
  
  vel = PVector.random2D();
  acc = new PVector(0, 0); 
  maxSpeed = 0;
  isHot = hot;
  friction = -1;
  if(isHot == true){ 
    
    pos = new PVector(random(0, width), random(0,height/2-radio));
    maxSpeed = speedHot;
    vel.setMag(maxSpeed);
    
    }
  else{
    
    pos = new PVector(random(0, width), random(height/2+radio,height));
    maxSpeed = speedCold;
    vel.setMag(maxSpeed);
    
    }
    
    }
    
    void attractRepell(ArrayList<Particle> particles){
      
      PVector sum = new PVector();
      PVector diff = new PVector();
      for(Particle other : particles){
        
        float d = PVector.dist(pos, other.pos);
        if(d > 0 && d < radio*5){
          
          diff = PVector.sub(pos, other.pos);
         // diff.normalize();
          diff.mult(0.1);
          //diff.mult(5);
      
          
          
          }
        else if(d > radio*5 && d < radio*15){
          
          diff = PVector.sub(other.pos, pos);
         // diff.normalize();
          diff.mult(0.001);
          } 
        
        else if(d >= radio*15){
          
          diff.mult(0);
          
          }
        
        sum.add(diff);
        
        }
       
      
         
         PVector steer = PVector.sub(sum,vel);
         applyForce(steer);
         
        
      
      }
    
    void applyForce(PVector force){
      
      acc.add(force);
      
      }
    
    void calculateWalls(){
      
      if(isHot == true){
        
    if (pos.x + radio > width) {
      pos.x = width - radio;
      vel.x *= friction; 
    }
    else if (pos.x - radio < 0) {
      pos.x = radio;
      vel.x *= friction;
    }
    if (pos.y + radio > wall) {
      pos.y = wall - radio;
      vel.y *= friction; 
    } 
    else if (pos.y - radio < 0) {
      pos.y = radio;
      vel.y *= friction;
    }
    
        
        }
        
      else{
        
    if (pos.x + radio > width) {
      pos.x = width - radio;
      vel.x *= friction; 
    }
    else if (pos.x - radio < 0) {
      pos.x = radio;
      vel.x *= friction;
    }
    if (pos.y + radio > height) {
      pos.y = height - radio;
      vel.y *= friction; 
    } 
    else if (pos.y - radio < wall) {
      pos.y = radio + wall;
      vel.y *= friction;
    }              
 
        }
      
      
      }
    
    void update(){
      
      vel.setMag(maxSpeed*speedSlider+1);
      vel.add(acc);
      pos.add(vel);
      acc.mult(0);
      }
    
    void show(){
      
      if(isHot == true){
        
        fill(255,0,0);
      }
      else{
        
        fill(0,0,255);
        
      }
      ellipse(pos.x, pos.y, radio, radio);
      
      }
  }