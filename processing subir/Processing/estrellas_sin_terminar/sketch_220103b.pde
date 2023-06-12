Star[] stars;
ParticleSystem[] ps;
float t;

void setup(){
  
  size(800,600,P2D);
  
  t = 0;

  stars = new Star[1000];
  
  ps = new ParticleSystem[stars.length];

  
  for(int i = 0; i < stars.length; i++){
  
    stars[i] = new Star(i);
    ps[i] = new ParticleSystem(30);
  
  }

  hint(DISABLE_DEPTH_MASK);

}

void draw(){
background(0);

  
  for(int i = 0; i < stars.length; i++){
  
    stars[i].update();
    stars[i].show();
    
  
  }


}
