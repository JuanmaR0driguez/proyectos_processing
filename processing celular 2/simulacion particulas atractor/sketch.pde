ArrayList<Persona> personas;

float radio = 10;
float friccion = -1;
//float speedHot = 30;
int numeroPersonas = 300;
float maximaPenetracion = 0.15;
float velocidadMaxima = 2;
Atractor atractor;

void setup(){
  fullScreen(P2D);
  frameRate(30);
  personas = new ArrayList<Persona>();
  /*for (int i = 0; i < numeroPersonas; i++){
    personas.add(new Persona());
  }
  */
  atractor = new Atractor(width/2, height/2);
  
  inicializarGrilla();
  
  }
  
  void inicializarGrilla() {
  int separacion = 30;
  
  int personasX = (int) width / separacion;
  int personasY = (int) (height/3) / separacion;

  for (int x = 0; x < personasX; x ++) {
    for (int y = 0; y < personasY; y ++) {
      personas.add(new Persona(separacion/2+x*separacion,(height/3)+separacion/2+y*separacion));
    }
  }
}
  
  
void draw(){
 
  background(0);
  
  noStroke();
  
  for (Persona p : personas){
    
    
    p.repulsion(personas);
    //p.atraer(atractor);
   p.actualizar();
   p.calcularParedes();
    p.mostrar();
    //atractor.mostrar();
    
    } 
  
  
  }
  
  
  class Persona{
    
  
  PVector posicion;
  PVector velocidad;
  PVector aceleracion;
  float masa;
  float altura;
  
    Persona(){
  
    velocidad = PVector.random2D();
    aceleracion = new PVector(0, 0);
    masa = 60;// random(60,90);
    altura = 16.5; //random(1.60,1.90)
    posicion = new PVector(random(0+radio, width-radio), random(0+radio,height-radio));

    velocidad.setMag(velocidadMaxima);
   
    }
    
    Persona(int x, int y){
    //velocidad = PVector.random2D();
    velocidad = new PVector(0,0);
    aceleracion = new PVector(0, 0);
    masa = 60;// random(60,90);
    altura = 16.5; //random(1.60,1.90)
   // posicion = new PVector(random(0+radio, width-radio), random(0+radio,height-radio));
    posicion = new PVector(x,y);
    //velocidad.setMag(velocidadMaxima);
   
      }
    
    
    
    void repulsion(ArrayList<Persona> personas){
      
      PVector sum = new PVector();
      PVector diff = new PVector();
      for(Persona otraPersona : personas){
        
        float d = PVector.dist(posicion, otraPersona.posicion);
        if(d > 0.1 && d <= 2*radio){
          
          diff = PVector.sub(posicion, otraPersona.posicion);
          diff.normalize();
          diff.mult(10);
          //diff.mult(5);
      
          
          
          }
          else if(d > 2*radio){
          diff.mult(0);
          
          }
        
        sum.add(diff);
        
        }
       
      
         //PVector steer = PVector.sub(sum,velocida
         aplicarFuerza(sum);
         
        
      
      }
    
    void aplicarFuerza(PVector fuerza){
      
      fuerza.mult(1/masa);
      aceleracion.add(fuerza);
      
      }
    
    void calcularParedes(){
        
    if (posicion.x + radio > width) {
      posicion.x = width - radio;
      velocidad.x *= friccion; 
    }
    else if (posicion.x - radio < 0) {
      posicion.x = radio;
      velocidad.x *= friccion;
    }
    if (posicion.y + radio > height) {
      posicion.y = height - radio;
      velocidad.y *= friccion; 
    } 
    else if (posicion.y - radio < 0) {
      posicion.y = radio;
      velocidad.y *= friccion;
    }
    
        
        }
        
        
    
     void atraer(Atractor a){
      
      float fuerzaMagnitud;
      float distancia = PVector.dist(a.posicion,posicion);
      PVector direccion = PVector.sub(a.posicion, posicion);
      
      float direccionMagnitud = direccion.mag();
      
      direccion.normalize();
      direccionMagnitud = constrain(direccionMagnitud,0.01, velocidadMaxima);
      if(distancia > 0){
      fuerzaMagnitud = a.fuerzaAtractor / (direccionMagnitud*direccionMagnitud);
     }
     
     else{
       
      fuerzaMagnitud = 0;
       
      }
      direccion.mult(fuerzaMagnitud);
      aplicarFuerza(direccion);
     
      }  
    
    void actualizar(){
      
      velocidad.setMag(velocidadMaxima);
      velocidad.add(aceleracion);
      posicion.add(velocidad);
      aceleracion.mult(0);
      }
    

    void mostrar(){
        fill(255,0,0);
      ellipse(posicion.x, posicion.y, radio*2, radio*2);
      
      }
  }
  
  
  class Atractor{
    
    PVector posicion;
    float fuerzaAtractor = 1;
    float r = 50;
    
    Atractor(int posicionX, int posicionY){
    
    posicion = new PVector(posicionX, posicionY);
    
    }
    
    void mostrar(){
      
      fill(0,0,255);
      ellipse(posicion.x, posicion.y, r, r);
      
      }
    
   
    
    }
    
 
    
    
 