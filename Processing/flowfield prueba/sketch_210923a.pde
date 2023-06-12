/*Este código fue creado con la intencion de replicar un gif que encontre en tuiter y cuyo autor decidio no liberar el codigo del mismo por razones de NFT 
segun él (no entendí demasiado). Esta armado a partir de pedacitos de codigo que fui encontrando en internet y un poquitito de maña y mano propia,
y lo hago publico porque se ve genial y esta muy piola para ver campos de flujo con partículas en los mismos, 
y como interactuan estas con objetos simples sin un sistema de fisicas muy elaborado.

Muchas gracias a Behemontha en GitHub por el codigo para el campo de flujo y las particulas y a Daniel Shiffman por sus explicaciones de ese mismo codigo 
y del funcionamiento de la camara y los repellers en su canal de Youtube "The Coding Train" y en su libro gratuito "The nature of code".
*/

/*Inicializo mis variables y objetos*/

float inc = 0.1f;
int cols, rows, layers;
Particle[] particles;
PVector[] flowField;
float scl = 1;
Repeller repeller;

boolean recording = false;

 public void setup()
{
  size(800,600,P3D); // Tamaño de la ventana
  cols = 1; // Columnas en las que voy a dividir el espacio
  rows = 1; // Filas en las que voy a dividir el espacio
  layers = 200; // Capas en las que divido el espacio
  
  /*Dividiendo el plano en filas, columnas y capas creo una cuadricula 3D, y a cada celda de esa cuadricula le asigno un vector para armar un "semi" campo vectorial*/
  
  particles = new Particle[35000]; //Creo las particulas
  for(int i = 0; i < particles.length; ++i){
    particles[i] = new Particle();
  }
  flowField = new PVector[cols * rows * layers]; //Defino el objeto que va a ser mi campo de flujo (el "semi" campo vectorial)
  
  repeller = new Repeller(350,510,95); // creo el objeto repeller para que colisionen las particulas (lo pongo un poco mas al frente (+y) de donde va la esfera porque se ve mejor)

camera(350, 625, 45, 400, 300, 280, 0, 0, 1); //Fijamos la posicion de la camara (se ve cortado porque estoy intersectando al plano con la camara, en posicion z de -60 no se ve cortado)

  //Aca calculo el valor del vector en cada celda y lo guardo en el objeto de flowField
  
  for(int z = 0; z < layers; z++) {
    for(int y = 0; y < cols; y++) {
      for(int x = 0; x < rows; x++) {
      int index = x + y * cols + z * cols * rows; //busco una de las celdas
      float angle = -2 ; //esto en el original tenia un noise, pero lo saque porque no afectaba mucho, deberia probar poniendolo de vuelta y ver que pasa
      PVector v1 = PVector.fromAngle(angle); //hago un vector 2D en esa celda
      float zeta = layers/2 - z; //calculo la distancia entre la capa donde esta la particula y la mitad de las capas
      PVector v2 = new PVector(0,0,zeta*0.07); //armo un vector en z que empuja a las particulas a la mitad de las capas
      PVector v = PVector.add(v1,v2);//uno la fuerza en z y la 2D en un vector
      v.setMag(10f); // aca cambias la "fuerza" (no se si es fuerza, no toy seguro) del campo de flujo sobre las particulas
      flowField[index] = v;//guardo el vector en el campo vectorial
    }
    }
  }


}
    
    void keyPressed(){
    if(key == 'r' || key == 'R'){recording = !recording;}
    } //esto es pa grabar, grabas con la R

 public void draw()
{
    background(0); //dibujo el fondo

//lights();
//directionalLight(128,128,128,1,-1,1);// descomentar estas dos lineas si queres verlo con luces y sombras
noStroke(); //todos los objetos que cree a partir de ahora no tienen vertices dibujados
fill(0); // todos los objetos que cree a partir de ahora estan llenos y pintados de negro
pushMatrix(); // no tengo ni idea, lei la descripcion de la funcion en la pagina de processing y no entendi un pomo, toda esta esfera me la robe de uno de los ejemplos
translate(350,500,105); //me muevo a donde quiero dibujar la esfera
sphere(15); // dibujo una esfera de radio 20
popMatrix(); //sigo sin tener ni idea
  /*
  beginShape();
  vertex(0,0,100);
    vertex(800,0,100);
      vertex(800,600,100);
            vertex(0,600,100);
  endShape(); //esto creaba un plano para ubicarme en donde estaba
  */

  //hago que cada particula:
  for(int i = 0; i < particles.length; ++i) {
    particles[i].follow(flowField); //siga al campo de flujo
    particles[i].update(); //se actualice
    particles[i].show(); //se dibuje en la pantalla
    particles[i].applyRepeller(repeller); //interactue con el repeller de la esfera
  }
if(recording){saveFrame("output/flowfield_####.png"); fill(0,255,0);}//guardo los frames de la grabacion en una carpeta que se llama output
else{fill(255,0,0);} //este fill, el de arriba y lo de abajo crean una esfera que cambia de color cuando estoy grabando, para saber si estoy grabando o no
noStroke();
pushMatrix();
translate(300,550,105); 
sphere(5); 
popMatrix();
}

class Particle {
  PVector pos = new PVector(random(900), random(750), random(90, 115)); // posicion inicial de la particula
  PVector vel = new PVector(0, 0, 0); // velocidad incial de la particula
  PVector acc = new PVector(0, 0, 0); // aceleracion inicial de la particula
  PVector prevPos = pos.copy(); // aca guardo la posicion previa de la particula
  float maxSpeed = 3.5f; //aca cambias la velocidad maxima de la particula
  
   public void update() {
    prevPos.x = pos.x; //hago que la posicion actual se guarde en la anterior
    prevPos.y = pos.y; 
    prevPos.z = pos.z;
    
    //aplico la velocidad y la aceleracion sobre la particula
    vel.add(acc); 
    vel.limit(maxSpeed); //limito la velocidad
    pos.add(vel); 
    
    //esto es para que las particulas vuelvan a arrancar cuando se salen de vista y no quedarme nunca sin particulas ni renderizar particulas que no veo
    if(pos.x >= 1000) {pos.x = prevPos.x = random(50, 150); pos.z = prevPos.z = random(90,115);}
    if(pos.x < 50) {pos.x = prevPos.x = random(150, 1000); pos.y = prevPos.y = random(600, 750); pos.z = prevPos.z = random(90,115);}
    if(pos.y >= 751) {pos.y = prevPos.y = random(175); pos.z = prevPos.z = random(90,115);}
    if(pos.y < 0) {pos.y = prevPos.y = random(600, 750); pos.z = prevPos.z = random(90,115);}
   //estos valores de aca arriba tuve que modificarlos a ojo porque estaban hechos para una camara 2D
    
    // reseteo la aceleracion
    acc.mult(0); 
  }
  
  //funcion que aplica una fuerza sobre la particula
  
   public void applyForce(PVector force) {
    acc.add(force); //aplico el vector de fuerza que calculo mas abajo
  }
  
  //funcion para mostrar la particula
  
   public void show() {
    stroke(255, (255/10) * abs(pos.z - 110)); //cambias el color de las particulas, el segundo numero cambia el alfa para que se vea mas traslucido cuando pasa por abajo de la esfera
    strokeWeight(2); //grosor de particulas
    line(pos.x, pos.y, pos.z, prevPos.x, prevPos.y, prevPos.z); //largo de las particulas, si queres ver puntos cambia line por point y elimina los ultimos tres argumentos de la funcion
  }
 
  //funcion para que la particula siga al campo vectorial
  
   public void follow(PVector[] flowField) {
    int z = floor(pos.z / scl); //calculo en que parte del espacio esta la particula
    int index = z+1; //veo que vector del campo vectorial le corresponderia
    PVector force = flowField[index]; //busco ese vector en el campo vectorial y lo hago una fuerza
    applyForce(force);//le aplico esa fuerza a la particula

}
  
  //funcion para aplicarle los efectos del repeller a las particulas
  
   public void applyRepeller(Repeller r) {
    PVector repelforce = r.repel(pos); //calculo cual seria la fuerza que ejerce el repeller sobre la particula
    applyForce(repelforce);//le aplico esa fuerza a la particula
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
    PVector dir = PVector.sub(location, pos); //calcula la direccion del vector fuerza que aplica el repeller sobre la particula
    float d = dir.mag(); //guardo la magnitud del vector en d
    dir.normalize(); //normalizo el vector director
    d = constrain(d,5,200); //hago que d se mantenga entre 5 y 200 para no dividir entre 0 y para no calcular fuerzas sobre particulas que estan muy lejos
    float force = -1 * strength / (d); // relacion entre la fuerza del repeller y la distancia al mismo, el -1 es porque es una fuerza de repulsion, si no esta es una fuerza de atraccion
    dir.mult(force);//multiplico al vector director por la fuerza para que me quede la direccion y la fuerza establecidas
    return dir;//le paso el vector al objeto que llamo a esta funcion
  }
}
