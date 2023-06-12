/*Este codigo fue creado con la intencion de replicar un gif que encontre en tuiter y cuyo autor decidio no liberar el codigo del mismo por razones de NFT segun el (no entendi demasiado)
Esta armado a partir de pedacitos de codigo que fui encontrando en internet y un poquitito de maña y mano propia, y lo hago publico porque se ve genial y esta muy piola para ver
campos de flujo con particulas en los mismos, y como interactuan estas con objetos simples sin un sistema de fisicas muy elaborado. Muchas gracias a Behemontha en GitHub por el codigo
para el campo de flujo y las particulas y a Daniel Shiffman por sus explicaciones de ese mismo codigo y del posicionamiento de la camara y los repellers en youtube y en su libro gratuito
"The nature of code"
*/

/*Inicializo mis variables y objetos*/

float inc = 0.1f;
int cols, rows, layers;
Particle[] particles;
PVector[] flowField;
float scl = 1;
Repeller repeller;

 public void setup()
{
  size(800,600,P3D); // Tamaño de la ventana
  cols = 1; // Columnas en las que voy a dividir el plano
  rows = 1; // Filas en las que voy a dividir el plano
  layers = 200;
  
  /*Dividiendo el plano en filas y columnas creo una cuadricula, y a cada celda de esa cuadricula le asigno un vector para armar un "semi" campo vectorial*/
  
  particles = new Particle[40000]; //Creo las particulas
  for(int i = 0; i < particles.length; ++i)
    particles[i] = new Particle();

  flowField = new PVector[cols * rows * layers]; //Defino el objeto que va a ser mi campo de flujo (el "semi" campo vectorial)
  
  repeller = new Repeller(350,510,95); // creo el objeto repeller para que colisionen las particulas (lo pongo un poco mas al frente (+y) de donde va la esfera porque se ve mejor)

camera(350, 625, 45, 400, 300, 280, 0, 0, 1); //Fijamos la posicion de la camara (se ve cortado porque estoy intersectando al plano con la camara, en posicion z de -60 no se ve cortado)

  
  for(int z = 0; z < layers; z++) {
    for(int y = 0; y < cols; y++) {
      for(int x = 0; x < rows; x++) {
      // set the vector in the flow field
      int index = x + y * cols + z * cols * rows; 
      float angle = -2 ; //esto en el original tenia un noise, pero lo saque porque no afectaba mucho, deberia probar poniendolo de vuelta y ver que pasa
      PVector v1 = PVector.fromAngle(angle);
      float zeta = layers/2 - z;
      PVector v2 = new PVector(0,0,zeta*0.07);
      PVector v = PVector.add(v1,v2);
      v.setMag(10f);// set the power of the field on the particle // aca cambias la "fuerza" (no se si es fuerza, no toy seguro) del campo de flujo sobre las particulas
      flowField[index] = v;
    }
    }
  }


}
    

 public void draw()
{
    background(0); //dibujo el fondo
//lights(); // descomentar esta linea si quieren verlo con luces y sombras
noStroke(); //todos los objetos que cree a partir de ahora no tienen vertices dibujados
fill(0); // todos los objetos que cree a partir de ahora estan llenos y pintados de negro
pushMatrix(); // no tengo ni idea, lei la descripcion de la funcion en la pagina de processing y no entendi un pomo, toda esta esfera me la robe de uno de los ejemplos
translate(350,500,99); //me muevo a donde quiero dibujar la esfera
sphere(15); // dibujo una esfera de radio 20
popMatrix(); //sigo sin tener ni idea
   // por aca habia un zoff que cambiaba la direccion de los vectores en cada cuadricula en el tiempo. La saque a la mierda, no queria mas quilombo, en el codigo que nombro mas abajo esta
  /*
  beginShape();
  vertex(0,0,100);
    vertex(800,0,100);
      vertex(800,600,100);
            vertex(0,600,100);
  endShape();
  */

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
  PVector pos = new PVector(random(900), random(750), random(90, 115)); // position
  PVector vel = new PVector(0, 0, 0); // velocity
  PVector acc = new PVector(0, 0, 0); // acceleration
  PVector prevPos = pos.copy(); // previous position
  float maxSpeed = 3.5f; //aca cambias la velocidad maxima de la particula
  
   public void update() {
    // keep current position
    prevPos.x = pos.x; 
    prevPos.y = pos.y; 
    prevPos.z = pos.z;
    
    // apply acceleration and velocitiy
    vel.add(acc); 
    vel.limit(maxSpeed); // limit velocity
    pos.add(vel); 
    
    // handle window edges
    if(pos.x >= 1000) {pos.x = prevPos.x = random(50, 150); pos.z = prevPos.z = random(90,115);}
    if(pos.x < 50) {pos.x = prevPos.x = random(150, 1000); pos.y = prevPos.y = random(600, 750); pos.z = prevPos.z = random(90,115);}
    if(pos.y >= 751) {pos.y = prevPos.y = random(175); pos.z = prevPos.z = random(90,115);}
    if(pos.y < 0) {pos.y = prevPos.y = random(600, 750); pos.z = prevPos.z = random(90,115);}
   //estos valores de aca arriba tuve que modificarlos a ojo porque estaban hechos para una camara 2D
    
    // reset acceleration
    acc.mult(0); 
  }
  
   public void applyForce(PVector force) {
    acc.add(force);
  }
  
   public void show() {
    stroke(255, (255/25) * abs(pos.z - 125)); //cambias el color de las particulas
    strokeWeight(2); //grosor de particulas
    line(pos.x, pos.y, pos.z, prevPos.x, prevPos.y, prevPos.z); //largo de las particulas, si queres ver puntos cambia line por point y elimina los ultimos dos argumentos de la funcion
  }
  
    //magia negra (funcion para que las particulas sigan el campo vectorial)
  
   public void follow(PVector[] flowField) {
    // get the index in the flow field
    int z = floor(pos.z / scl);
    int index = z+1;
    
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
  float strength = 110; //fuerza con la que las particulas son repelidas
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
