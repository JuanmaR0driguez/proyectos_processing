class Star{

  PVector position;
  float lifespan;
  color c1;
  int f;
  float t;
  
  Star(int u){
    lifespan = random(100,255);
    position = new PVector(random(width), random(height));
    //position = new PVector(width/2, height/2);
    c1 = color(0,0,100);
    f = u;
    t = 0;
  }
  
  void update(){
    
    if(t < lifespan/3){
      c1 = color(0,0,blue(c1)+1);
    }
    else if(t > lifespan/3 && t < 2*lifespan/3){
      c1 = color(red(c1)+5,green(c1)+5,blue(c1)+1);
    }
    else if(t > 2*lifespan/3 && t < lifespan){
      c1 = color(red(c1)+1, green(c1)-5, blue(c1)-7);
    }
    else{
      c1 = color(red(c1)-7,0,0);
      if (red(c1) <= 10){
      explode();
      }
    }
    
    t += 0.5;
    
  }
  
  void explode(){
    while(ps[f].particles.get(int(random(30))).lifespn >= 10){
    ps[f].update();
    ps[f].display();
    }
    ps[f].setEmitter(stars[f].position.x,stars[f].position.y);
   c1 = color(0,0,0);
   lifespan = random(155);
   //position.x = random(width);
   //position.y = random(height);
  // position.x = width/2;
   //position.y = height/2;
   c1 = color(0,0,100);
   t = 0;
  }
  
  void show(){
  
    stroke(c1);
    strokeWeight(3);
  point(position.x, position.y);
  
  }


}
