
Flower[] flowers;

int gridSize;

void setup(){
  
  size(displayWidth, displayHeight, P2D);
  
  background(253,253,150);
  
  gridSize = 100;
  
  flowers = new Flower[(width/gridSize +2) * (height/gridSize+1 )];
  
  
  for(int i = 0; i < flowers.length; i++){
     flowers[i] = new Flower(i);
     flowers[i].show();
    }
  
  }

void draw(){
  
  background(253,253,150);
  
  for(int i = 0; i < flowers.length; i++){
     flowers[i].show();
    }
  
  }

class Flower{
  
  PVector position;
  
   int t = 0;
   
   float rotation;
   
   int colour;
   
   int clockwise;
  
  Flower(int i){
    
    position = new PVector(gridSize/2+gridSize*(i%(width/gridSize+2 )), gridSize*(i/(width/gridSize+2)));
    rotation = random(361);
    colour = int(random(3));
    clockwise = int(random(2));
    }
  
  void show(){
    
    switch(clockwise){
      
      case 0:
      rotation+= random(0.1, 2);
      break;
      
      case 1:
      rotation-= random(0.1, 2);
      break;
      
      }
    
   noStroke();
    
    
    switch(colour){
      
      case 0:
      
      fill(204,169,221);
      break;
      
      case 1:
      
      fill(240,182,213);
      break;
      
      case 2:
      
      fill(157,156,217);
      break;
      }
    
    translate(position.x, position.y);
    
    rotate(radians(rotation));
    
    
    beginShape();
    
    vertex(-25,0);
    vertex(-20,25);
    vertex(-8.33,8.33);
    vertex(0,25);
    vertex(8.33,8.33);
    vertex(20,25);
    vertex(25,0);
    
    endShape();
    
    
    arc(0, 0, 50,50, PI, TWO_PI);
    
    rotate(-radians(rotation));
    
    translate(-position.x,-position.y);
    
    t += 0.1;
    
    }
  
  
  }