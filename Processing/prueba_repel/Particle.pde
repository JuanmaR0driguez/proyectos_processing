class Particle {
  PVector pos = new PVector(random(width - 1), random(height - 1)); // position
  PVector vel = new PVector(0, 0); // velocity
  PVector acc = new PVector(0, 0); // acceleration
  PVector prevPos = pos.copy(); // previous position
  float maxSpeed = 0.7;
  
  void update() {
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
    if(pos.y >= 751) pos.y = prevPos.y = random(600, 750);
    if(pos.y < 150) pos.y = prevPos.y = random(600, 750);
   
    
    // reset acceleration
    acc.mult(0); 
  }
  
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  void show() {
    stroke(255);
    strokeWeight(4);
    point(pos.x, pos.y);
  }
  
  void follow(PVector[] flowField) {
    // get the index in the flow field
    int x = floor(pos.x / scl);
    int y = floor(pos.y / scl);
    int index = x + y * cols;
    
    // get the force and apply it
    PVector force = flowField[index];
    applyForce(force);
  }
  
  void applyRepeller(Repeller r) {
    PVector repelforce = r.repel(pos);
    applyForce(repelforce);
}
}
