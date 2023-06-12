int[][] list;
int[][] list2;
int n,xi,yi;
/*
void setup(){
  frameRate(1);
  colorMode(HSB,360,100,100);
  n = 35;
  list = new int[n][n*2];
  list2 = new int[n][n*2];
  for(int i = 0; i< n; i++){
    for(int j = 0; j < n*2; j++){
    list[i][j] = 0;
    list2[i][j] = 0;
    }
    }
  //xi = int(random(1,n-1));
 // yi = int(random(1,n*2-1));
  xi = n/2;
  yi = n;
  list[xi][yi] = int(random(2,6));
  list[xi+1][yi] = list[xi-1][yi] = list[xi][yi+1] = list[xi][yi-1] = 1;
  list2[xi][yi] = int(random(2,6));
  list2[xi+1][yi] = list2[xi-1][yi] = list2[xi][yi+1] = list2[xi][yi-1] = 1;
  
  
  for(int x = 0; x<n; x++){
  for(int i = 1; i < n-1; i++){
    for(int j = 1; j < n*2-1; j++){ 
     if(list[i][j] == 1 && int(random(10))== 5){ 
       if((list[i-1][j] == 2 || list[i+1][j] == 2 || list[i][j+1] == 2 || list[i][j-1] == 2) && (list[i-1][j] == 6 || list[i+1][j] == 6 || list[i][j+1] == 6 || list[i][j-1] == 6)){        
        list[i][j] = 4;    
       }
       else if(list[i-1][j] == 2 || list[i+1][j] == 2 || list[i][j+1] == 2 || list[i][j-1] == 2){
        list[i][j] = int(random(2,3.9));
        
       }
       else if(list[i-1][j] == 3 || list[i+1][j] == 3 || list[i][j+1] == 3 || list[i][j-1] == 3){
        
        list[i][j] = int(random(2,4.9));
      
       }
       
       else if(list[i-1][j] == 4 || list[i+1][j] == 4 || list[i][j+1] == 4 || list[i][j-1] == 4){
        
        list[i][j] = int(random(3,5.4));
      
       }
       
       else if(list[i-1][j] == 5 || list[i+1][j] == 5 || list[i][j+1] == 5 || list[i][j-1] == 5){
        
        float a = random(4,5.3);
        if(a<4.3){
        list[i][j] = int(a);
        }
        else{list[i][j] = int(random(5.8,6.9));}
      
      //list[i][j] = int(random(4,6.9));
      
       }
       else if(list[i-1][j] == 6 || list[i+1][j] == 6 || list[i][j+1] == 6 || list[i][j-1] == 6){
        
        list[i][j] = int(random(5.5,6.9));
      
       }
      
       if(list[i-1][j] == 0){
        list[i-1][j] = 1;
        }
        if(list[i+1][j] == 0){
        list[i+1][j] = 1;
        }
        if(list[i][j-1] == 0){
        list[i][j-1] = 1;
        }
        if(list[i][j+1] == 0){
        list[i][j+1] = 1;
        }
      }   
   
   
   
 if(list2[i][j] == 1 && int(random(10))== 5){
       /*if((list2[i-1][j] == 2 || list2[i+1][j] == 2 || list2[i][j+1] == 2 || list2[i][j-1] == 2) && (list2[i-1][j] == 6 || list2[i+1][j] == 6 || list2[i][j+1] == 6 || list2[i][j-1] == 6)){        
        list2[i][j] = 4;    
        }
       if(list2[i-1][j] == 2 || list2[i+1][j] == 2 || list2[i][j+1] == 2 || list2[i][j-1] == 2){
        list2[i][j] = int(random(2,3.9));
        
       }
       else if(list2[i-1][j] == 3 || list2[i+1][j] == 3 || list2[i][j+1] == 3 || list2[i][j-1] == 3){
        
        list2[i][j] = int(random(2,4.9));
      
       }
       
       else if(list2[i-1][j] == 4 || list2[i+1][j] == 4 || list2[i][j+1] == 4 || list2[i][j-1] == 4){
        
        list2[i][j] = int(random(3,5.9));
      
       }
       
       else if(list2[i-1][j] == 5 || list2[i+1][j] == 5 || list2[i][j+1] == 5 || list2[i][j-1] == 5){
        
       list2[i][j] = int(random(4,6.9));
      
      
      
       }
       else if(list2[i-1][j] == 6 || list2[i+1][j] == 6 || list2[i][j+1] == 6 || list2[i][j-1] == 6){
        
        list2[i][j] = int(random(5,5.9));
      
       }
      
       if(list2[i-1][j] == 0){
        list2[i-1][j] = 1;
        }
        if(list2[i+1][j] == 0){
        list2[i+1][j] = 1;
        }
        if(list2[i][j-1] == 0){
        list2[i][j-1] = 1;
        }
        if(list2[i][j+1] == 0){
        list2[i][j+1] = 1;
        }
      }   
     }
     }
     }
     
       
  
   int b = 7;
   noStroke();
   background(0);
   for(int i = 3; i < n; i++){
    for(int j = 3; j < n*2; j++){ 
     switch(list[i][j]){
       
       case 0:
       fill(0);
       break;
       
       case 1:
       fill(0);
       break;
       
       case 2:
       fill(115,100,27-list2[i][j]);
       break;
       
       case 3:
       fill(113,96,60-list2[i][j]*b);
       break;
       
       case 4:
       fill(113,50,58-list2[i][j]*b);
       break;
       
       case 5:
       fill(55,36,100-list2[i][j]*b);
       break;
       
       case 6:
       fill(229,98,58);
       break;
       }
       pushMatrix();
       if(i%2==0){
     polygon(i*34-80,j*40-100, 23.09,6);
     }
     else{
       polygon(i*34-80,j*40-120, 23.09,6);
       }
       popMatrix();
     }
     } 
  }
  
  */
  
  
  
void draw(){
  frameRate(1);
  colorMode(HSB,360,100,100);
  n = 35;
  list = new int[n][n*2];
  list2 = new int[n][n*2];
  for(int i = 0; i< n; i++){
    for(int j = 0; j < n*2; j++){
    list[i][j] = 0;
    list2[i][j] = 0;
    }
    }
  //xi = int(random(1,n-1));
 // yi = int(random(1,n*2-1));
  xi = n/2;
  yi = n;
  
  list[xi][yi] = int(random(2,6));
  list[xi+1][yi] = list[xi-1][yi] = list[xi][yi+1] = list[xi][yi-1] = 1;
  list2[xi][yi] = int(random(2,6));
  list2[xi+1][yi] = list2[xi-1][yi] = list2[xi][yi+1] = list2[xi][yi-1] = 1;
  
  
  for(int x = 0; x<n; x++){
  for(int i = 1; i < n-1; i++){
    for(int j = 1; j < n*2-1; j++){ 
     if(list[i][j] == 1 && int(random(10))== 5){ 
       if((list[i-1][j] == 2 || list[i+1][j] == 2 || list[i][j+1] == 2 || list[i][j-1] == 2) && (list[i-1][j] == 6 || list[i+1][j] == 6 || list[i][j+1] == 6 || list[i][j-1] == 6)){        
        list[i][j] = 4;    
       }
       else if(list[i-1][j] == 2 || list[i+1][j] == 2 || list[i][j+1] == 2 || list[i][j-1] == 2){
        list[i][j] = int(random(2,3.9));
        
       }
       else if(list[i-1][j] == 3 || list[i+1][j] == 3 || list[i][j+1] == 3 || list[i][j-1] == 3){
        
        list[i][j] = int(random(2,4.9));
      
       }
       
       else if(list[i-1][j] == 4 || list[i+1][j] == 4 || list[i][j+1] == 4 || list[i][j-1] == 4){
        
        list[i][j] = int(random(3,5.4));
      
       }
       
       else if(list[i-1][j] == 5 || list[i+1][j] == 5 || list[i][j+1] == 5 || list[i][j-1] == 5){
        
        float a = random(4,5.3);
        if(a<4.3){
        list[i][j] = int(a);
        }
        else{list[i][j] = int(random(5.8,6.9));}
      
      //list[i][j] = int(random(4,6.9));
      
       }
       else if(list[i-1][j] == 6 || list[i+1][j] == 6 || list[i][j+1] == 6 || list[i][j-1] == 6){
        
        list[i][j] = int(random(5.5,6.9));
      
       }
      
       if(list[i-1][j] == 0){
        list[i-1][j] = 1;
        }
        if(list[i+1][j] == 0){
        list[i+1][j] = 1;
        }
        if(list[i][j-1] == 0){
        list[i][j-1] = 1;
        }
        if(list[i][j+1] == 0){
        list[i][j+1] = 1;
        }
      }   
   
   
   
 if(list2[i][j] == 1 && int(random(10))== 5){
       /*if((list2[i-1][j] == 2 || list2[i+1][j] == 2 || list2[i][j+1] == 2 || list2[i][j-1] == 2) && (list2[i-1][j] == 6 || list2[i+1][j] == 6 || list2[i][j+1] == 6 || list2[i][j-1] == 6)){        
        list2[i][j] = 4;    
        }*/
       if(list2[i-1][j] == 2 || list2[i+1][j] == 2 || list2[i][j+1] == 2 || list2[i][j-1] == 2){
        list2[i][j] = int(random(2,3.9));
        
       }
       else if(list2[i-1][j] == 3 || list2[i+1][j] == 3 || list2[i][j+1] == 3 || list2[i][j-1] == 3){
        
        list2[i][j] = int(random(2,4.9));
      
       }
       
       else if(list2[i-1][j] == 4 || list2[i+1][j] == 4 || list2[i][j+1] == 4 || list2[i][j-1] == 4){
        
        list2[i][j] = int(random(3,5.9));
      
       }
       
       else if(list2[i-1][j] == 5 || list2[i+1][j] == 5 || list2[i][j+1] == 5 || list2[i][j-1] == 5){
        
       list2[i][j] = int(random(4,6.9));
      
      
      
       }
       else if(list2[i-1][j] == 6 || list2[i+1][j] == 6 || list2[i][j+1] == 6 || list2[i][j-1] == 6){
        
        list2[i][j] = int(random(5,5.9));
      
       }
      
       if(list2[i-1][j] == 0){
        list2[i-1][j] = 1;
        }
        if(list2[i+1][j] == 0){
        list2[i+1][j] = 1;
        }
        if(list2[i][j-1] == 0){
        list2[i][j-1] = 1;
        }
        if(list2[i][j+1] == 0){
        list2[i][j+1] = 1;
        }
      }   
     }
     }
     }
     
       
  
   int b = 7;
   noStroke();
   background(0);
   for(int i = 3; i < n; i++){
    for(int j = 3; j < n*2; j++){ 
     switch(list[i][j]){
       
       case 0:
       fill(0);
       break;
       
       case 1:
       fill(0);
       break;
       
       case 2:
       fill(115,100,27-list2[i][j]);
       break;
       
       case 3:
       fill(113,96,60-list2[i][j]*b);
       break;
       
       case 4:
       fill(113,50,58-list2[i][j]*b);
       break;
       
       case 5:
       fill(55,36,100-list2[i][j]*b);
       break;
       
       case 6:
       fill(229,98,58);
       break;
       }
       pushMatrix();
       if(i%2==0){
     polygon(i*34-80,j*40-100, 23.09,6);
     }
     else{
       polygon(i*34-80,j*40-120, 23.09,6);
       }
       popMatrix();
     }
     } 
}

void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
  }