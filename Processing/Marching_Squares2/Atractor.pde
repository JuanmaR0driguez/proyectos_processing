class Attractor {
 float mass, G;
  PVector location;
 
  Attractor(PVector loc) {
    location = loc;
    mass = 100;
    G = 0.4;
  }

public PVector attract(QueasyCamMod cam) {
 
  PVector force = PVector.sub(location,cam.position);
  float distance = force.mag();
  force.normalize();
  distance = constrain(distance,5,25);
  float strength = (G * mass * 10) / (distance * distance);
  force.mult(strength);
  return force;
}
}
