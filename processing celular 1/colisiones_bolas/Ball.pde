class Ball {
  
  PVector pos = new PVector(0,0);
  PVector vel = new PVector(0,0);
  PVector gravity = new PVector(0,0);
  PVector oldPos = new PVector(0,0);
  float diameter;
  int id;
  Ball[] others;
 
  Ball(float xin, float yin, float din, int idin, Ball[] oin) {
    pos.x = xin;
    pos.y = yin;
    diameter = din;
    id = idin;
    others = oin;
  } 
  
  void collide() {
    oldPos = pos.copy();
    for (int i = id + 1; i < numBalls; i++) {
      float dx = others[i].pos.x - pos.x;
      float dy = others[i].pos.y - pos.y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = others[i].diameter/2 + diameter/2;
      if (distance < minDist+5) { 
        float angle = atan2(dy, dx);
        float targetX = pos.x + cos(angle) * minDist;
        float targetY = pos.y + sin(angle) * minDist;
        float acx = (targetX - others[i].pos.x) * spring;
        float acy = (targetY - others[i].pos.y) * spring;
        //vel.x -= acx;
       // vel.y -= acy;
       // others[i].vel.x += acx;
        //others[i].vel.y += acy;
        pos.set(oldPos.x+random(5), oldPos.y+random(5));
        PVector ac = new PVector(acx*0.1, acy*0.1);
        vel.add(ac.rotate(PI));
        others[i].vel.add(ac);
      }
    }   
  }
  
  void move(float ax, float ay) {
    
    gravity.set(ax,ay,az);
    vel.add(gravity);
    pos.add(vel);
    
    if (pos.x + diameter/2 > width) {
      pos.x = width - diameter/2;
      vel.x *= friction; 
    }
    else if (pos.x - diameter/2 < 0) {
      pos.x = diameter/2;
      vel.x *= friction;
    }
    if (pos.y + diameter/2 > height) {
      pos.y = height - diameter/2;
      vel.y *= friction; 
    } 
    else if (pos.y - diameter/2 < 0) {
      pos.y = diameter/2;
      vel.y *= friction;
    }
    
    
    
  }
  
  void display() {
    ellipse(pos.x, pos.y, diameter, diameter);
  }
}