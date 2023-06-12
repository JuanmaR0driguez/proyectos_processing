import processing.core.PApplet;

import java.lang.reflect.*;
import java.util.List;

AccelerometerManager accel;
float ax, ay, az;
int numBalls = 12;
float spring = -0.01;
float friction = -1;
Ball[] balls = new Ball[numBalls]; 


void setup() {
  size(displayWidth, displayHeight);
  accel = new AccelerometerManager(this);
  orientation(PORTRAIT);
  for (int i = 0; i < numBalls; i++) {
    balls[i] = new Ball(random(width), random(height), random(99,100), i, balls);
  }
  noStroke();
  fill(255, 204);
}

void draw() {
 background(0);
 resume();
  for (int i = 0; i < numBalls; i++) {
    balls[i].collide();
    balls[i].move(-ax*0.05, ay*0.05);
    balls[i].display();  
  }
  
}

public void resume() {
  if (accel != null) {
    accel.resume();
    if(accel.entro == true){
    background(0,255,0);
    }
    else{
    background(255,0,0);
    }
  }
  
}

public void pause() {
  if (accel != null) {
    accel.pause();
  }
}

public void accelerationEvent(float x, float y, float z) {
//  println("acceleration: " + x + ", " + y + ", " + z);
  ax = x;
  ay = y;
  az = z;
}
