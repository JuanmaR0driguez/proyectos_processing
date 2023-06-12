class Particle {

  PVector velocity;
  float lifespn = 255;
  
  PShape part;
  float partSize;
  
  PVector gravity = new PVector(0,0);


  Particle() {
    partSize = random(10,60);
    part = createShape();
    part.beginShape(POINTS);
    part.vertex(0,0);
    part.endShape();
    part.setStroke(color(255,0,0));
    
    rebirth(width/2,height/2);
    lifespn = random(255);
  }

  PShape getShape() {
    return part;
  }
  
  void rebirth(float x, float y) {
    float a = random(TWO_PI);
    float speed = random(0.5,4);
    velocity = new PVector(cos(a), sin(a));
    velocity.mult(speed);
    lifespn = 255;   
    part.resetMatrix();
    part.translate(x, y); 
  }
  
  boolean isDead() {
    if (lifespn < 0) {
     return true;
    } else {
     return false;
    } 
  }
  

  public void update() {
    lifespn = lifespn - 1;
    velocity.add(gravity);
    
    part.setTint(color(255,lifespn));
    part.translate(velocity.x, velocity.y);
  }
}
