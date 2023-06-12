/*Este codigo fue creado con la intencion de replicar un gif que encontre en tuiter y cuyo autor decidio no liberar el codigo del mismo por razones de NFT segun el (no entendi demasiado)
Esta armado a partir de pedacitos de codigo que fui encontrando en internet y un poquitito de maña y mano propia, y lo hago publico porque se ve genial y esta muy piola para ver
campos de flujo con particulas en los mismos, y como interactuan estas con objetos simples sin un sistema de fisicas muy elaborado. Muchas gracias a Behemontha en GitHub por el codigo
para el campo de flujo y las particulas y a Daniel Shiffman por sus explicaciones de ese mismo codigo y del posicionamiento de la camara y los repellers en youtube y en su libro gratuito
"The nature of code"
*/

/*Inicializo mis variables y objetos*/

float inc = 0.1f;
int cols, rows;
Particle[] particles;
PVector[] flowField;
float scl = 100;
Repeller repeller;

 public void setup()
{
  size(800,600,P3D); // Tamaño de la ventana
  cols = 100; // Columnas en las que voy a dividir el plano
  rows = 100; // Filas en las que voy a dividir el plano
  
  /*Dividiendo el plano en filas y columnas creo una cuadricula, y a cada celda de esa cuadricula le asigno un vector para armar un "semi" campo vectorial*/
  
  particles = new Particle[10000]; //Creo las particulas
  for(int i = 0; i < particles.length; ++i)
    particles[i] = new Particle();

  flowField = new PVector[cols * rows]; //Defino el objeto que va a ser mi campo de flujo (el "semi" campo vectorial)
  
  repeller = new Repeller(350,510,0); // creo el objeto repeller para que colisionen las particulas (lo pongo un poco mas al frente (+y) de donde va la esfera porque se ve mejor)

camera(350, 600, -30, 400, 300, 200, 0, 0, 1); //Fijamos la posicion de la camara (se ve cortado porque estoy intersectando al plano con la camara, en posicion z de -60 no se ve cortado)
}
    

 public void draw()
{
    background(255,192,203); //dibujo el fondo
//lights(); // descomentar esta linea si quieren verlo con luces y sombras
noStroke(); //todos los objetos que cree a partir de ahora no tienen vertices dibujados
fill(253,253,150); // todos los objetos que cree a partir de ahora estan llenos y pintados de negro
pushMatrix(); // no tengo ni idea, lei la descripcion de la funcion en la pagina de processing y no entendi un pomo, toda esta esfera me la robe de uno de los ejemplos
translate(350,500,0); //me muevo a donde quiero dibujar la esfera
sphere(15); // dibujo una esfera de radio 20
popMatrix(); //sigo sin tener ni idea
    
  float yoff = 0;
  for(int y = 0; y < rows; y++) {
    float xoff = 0;
    for(int x = 0; x < cols; x++) {
      // set the vector in the flow field
      int index = x + y * cols; 
      float angle = -2 ; //esto en el original tenia un noise, pero lo saque porque no afectaba mucho, deberia probar poniendolo de vuelta y ver que pasa
      PVector v = PVector.fromAngle(angle);
      v.setMag(10f); // set the power of the field on the particle // aca cambias la "fuerza" (no se si es fuerza, no toy seguro) del campo de flujo sobre las particulas
      flowField[index] = v;
      
      xoff += inc;
    }
    yoff += inc;
  } // por aca habia un zoff que cambiaba la direccion de los vectores en cada cuadricula en el tiempo. La saque a la mierda, no queria mas quilombo, en el codigo que nombro mas abajo esta
  
  /*Toda esta seccion, lo de arriba y el for de abajo, mas el "sistema de particulas" (la clase Particle),
  me lo robe casi por completo de https://github.com/Behemontha/PerlinNoiseFlowField/blob/master/PerlinNoiseFlowField/PerlinNoiseFlowField.pde
  Tiene implementadas algunas partes que son necesarias para la colision con la esfera*/

  //hago que cada particula:
  for(int i = 0; i < particles.length; ++i) {
    particles[i].follow(flowField); //siga al campo de flujo
    particles[i].update(); //se actualice
    particles[i].show(); //se dibuje en la pantalla
    particles[i].applyRepeller(repeller); //interactue con el repeller de la esfera
  }

}
class Particle {
  PVector pos = new PVector(random(width - 1), random(height - 1)); // position
  PVector vel = new PVector(0, 0); // velocity
  PVector acc = new PVector(0, 0); // acceleration
  PVector prevPos = pos.copy(); // previous position
  float maxSpeed = 2f; //aca cambias la velocidad maxima de la particula
  
   public void update() {
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
    if(pos.y >= 751) pos.y = prevPos.y = random(150, 175);
    if(pos.y < 150) pos.y = prevPos.y = random(600, 750);
   //estos valores de aca arriba tuve que modificarlos a ojo porque estaban hechos para una camara 2D
    
    // reset acceleration
    acc.mult(0); 
  }
  
   public void applyForce(PVector force) {
    acc.add(force);
  }
  
   public void show() {
    stroke(87,8,97); //cambias el color de las particulas
    strokeWeight(3); //grosor de particulas
    line(pos.x, pos.y, prevPos.x, prevPos.y); //largo de las particulas, si queres ver puntos cambia line por point y elimina los ultimos dos argumentos de la funcion
  }
  
    //magia negra (funcion para que las particulas sigan el campo vectorial)
  
   public void follow(PVector[] flowField) {
    // get the index in the flow field
    int x = floor(pos.x / scl);
    int y = floor(pos.y / scl);
    int index = x + y * cols;
    
    // get the force and apply it
    PVector force = flowField[index];
    applyForce(force);
  }
  
  //funcion para aplicarle los efectos del repeller a las particulas
  
   public void applyRepeller(Repeller r) {
    PVector repelforce = r.repel(pos);
    applyForce(repelforce);
}
}

// clase del repeller

class Repeller {
  float strength = 100; //fuerza con la que las particulas son repelidas
  PVector location; //posicion del repeller
 
  Repeller(float x, float y, float z)  {
    location = new PVector(x,y,z); //pongo el repeller en su posicion
  }
  
  //Calcula la fuerza ejercida por el repeller sobre cada particula
  
   public PVector repel(PVector pos){
    PVector dir = PVector.sub(location, pos);
    float d = dir.mag();
    dir.normalize();
    d = constrain(d,5,200);
    float force = -1 * strength / (d); // relacion entre la fuerza del repeller y la distancia al mismo, el -1 es porque es una fuerza de repulsion, si no esta es una fuerza de atraccion
    dir.mult(force);
    return dir;
  }
}
