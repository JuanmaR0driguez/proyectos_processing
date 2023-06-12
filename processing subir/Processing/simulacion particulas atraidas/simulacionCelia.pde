ArrayList<Persona> personas; // Mi lista de personas

float radio = 10; //radio de las personas (en realidad despues lo uso SIEMPRE como DIAMETRO, habria que cambiarle el nombre
float friccion = -1; // friccion de las paredes
int numeroPersonas = 300; // numero de personas
float maximoSolapamiento = 0.15; // solapamiento maximo entre personas
float velocidadMaxima = 2; // velocidad maxima de las personas
Atractor atractor; //elemento atractor
PVector centro; // centro de la pantalla
float r = 300; //radio del circulo, si la pared es un circulo
void setup() {
  
  //descomentar siguiente linea y comentar fullScreen para elegir el tamaño de la ventana
  //size(800,600,P2D);
  fullScreen(P2D); //pantalla completa, P2D es el renderer
  frameRate(30); //limitar los fps
  centro = new PVector(width/2,height/2);
  personas = new ArrayList<Persona>(); //creo la lista de personas
  for (int i = 0; i < numeroPersonas; i++) { //bucle que se repite una cantidad de veces igual al numero de personas
    personas.add(new Persona()); //agrego una persona a la lista
  }
  
  atractor = new Atractor(width/2, height/2); // creo el elemento atractor, fijo el lugar de la pantalla donde lo quiero
}


void draw() {

  background(0); //fondo negro
  noStroke(); //dibujos sin contorno

  for (Persona p : personas) { //bucle que va pasando por cada una de las personas en la lista

    p.repulsion(personas); //le paso a la persona que estoy actualizando la lista completa de personas con las que se tiene que fijar si se esta solapando
    p.atraer(atractor); //le digo a la persona que se sienta atraida por el atractor
    p.calcularParedes(); //me fijo si la persona toca las paredes
    
    p.actualizar(); //actualizo la posicion de la persona
   
    p.mostrar(); //muestro a la persona
    atractor.mostrar(); //muestro al atractor
  }
}


class Persona {


  PVector posicion; //posicion de la persona
  PVector velocidad; //velocidad de la persona
  PVector aceleracion; //aceleracion de la persona
  Persona() { //constructor de la clase, lo llamo cuando inicializo al objeto

    aceleracion = new PVector(0, 0); //la persona aparece con aceleracion 0
    velocidad = PVector.random2D(); //la persona aparece con una velocidad que es un vector unitario en una direccion aleatoria
    velocidad.setMag(velocidadMaxima); //hago que la magnitud del vector velocidad sea la velocidad maxima
    posicion = new PVector(random(0+radio, width-radio), random(0+radio, height-radio)); //la persona aparece en un lugar aleatorio de la pantalla
    
  }

/*
PARA HACER: Actualmente el solapamiento maximo no interviene en la siguiente funcion. Agregar if para que intervenga.
*/

  void repulsion(ArrayList<Persona> personas) {//aca calculo la repulsion entre la persona y cada una de las personas de la lista

    PVector fuerzaTotal = new PVector();
    PVector fuerza = new PVector();
    
    for (Persona otraPersona : personas) { //bucle de codigo que se ejecuta por cada persona en la lista
      
      float d = PVector.dist(posicion, otraPersona.posicion); //calculo la distancia entre la persona y la otra persona
      
      if (d > 0.1 && d < radio) { //si las personas estan solapadas
        
        fuerza = PVector.sub(posicion, otraPersona.posicion); //calculo el vector direccion de la fuerza que voy a aplicar para separarlas
        fuerza.normalize(); //normalizo ese vector
        fuerza.mult(0.0025); //lo multiplico para que tenga sentido con las unidades de la simulacion

      }
      
      fuerzaTotal.add(fuerza);//añado la fuerza calculada con la otra persona a la fuerza total que experimenta la persona
    }

    aplicarFuerza(fuerzaTotal);//aplico la fuerza
  }

  void aplicarFuerza(PVector fuerza) {//funcion para aplicar fuerza

    aceleracion.add(fuerza);//le sumo la fuerza a la aceleracion 
                            //(asumimos que todas las fuerzas son equivalentes en cierto punto a la aceleracion, ya que son aceleraciones multiplicadas por una constante)
  }

  void calcularParedes() { //funcion para calcular paredes

    if (posicion.x + radio/2 > width) { //si la posicion en x + el radio de la persona dividido 2
                                        //es mayor que el ancho de la pantalla (la persona toco el borde)
                                        
      posicion.x = width - radio/2; //separo a la persona de la pared
      velocidad.x *= friccion; //la particula rebota teniendo en cuenta la friccion (mejor dicho disipacion o "pegajosidad") de la pared
      
      /*
      aca abajo pasa lo mismo para el resto de paredes
      */
      
    } else if (posicion.x - radio/2 < 0) {
      posicion.x = radio/2;
      velocidad.x *= friccion;
    }
    if (posicion.y + radio/2 > height) {
      posicion.y = height - radio/2;
      velocidad.y *= friccion;
    } else if (posicion.y - radio/2 < 0) {
      posicion.y = radio/2;
      velocidad.y *= friccion;
    }
    
   
    }
  



  void atraer(Atractor a) { // funcion para que la particula calcule su atraccion hacia el atractor que le pase a la funcion

    float fuerzaMagnitud; //variable que me va a indicar la magnitud de la fuerza
    float distancia = PVector.dist(a.posicion, posicion); // distancia entre la persona y el atractor
    PVector direccion = PVector.sub(a.posicion, posicion); // vector direccion entre la persona y el atractor
    float direccionMagnitud = direccion.mag(); //magnitud del vector direccion
    direccion.normalize(); //normalizo el vector direccion
    direccionMagnitud = constrain(direccionMagnitud, 0.01, velocidadMaxima); // limito el vector direccion magnitud para que se mueva dentro de cierto rango (para no dividir por cero abajo)
    if (distancia > 0) { //si la persona esta a una distancia mayor a 0 del atractor
      fuerzaMagnitud = a.fuerzaAtractor / (direccionMagnitud*direccionMagnitud); // aplico una fuerza de tipo atractora (varia con 1/r^2)
    } else {//si no
      fuerzaMagnitud = 0; //la fuerza que aplico es cero
    }
    direccion.mult(fuerzaMagnitud); //hago que la magnitud de la fuerza sea en la direccion entre la persona y el atractor
    aplicarFuerza(direccion); //aplico la fuerza
  }

  void actualizar() { // funcion para actualizar la posicion de la persona
    velocidad.setMag(velocidadMaxima); // hago que la particula tenga velocidad fija
    velocidad.add(aceleracion); //le aplico la aceleracion a la velocidad
    posicion.add(velocidad); // le aplico la velocidad a la posicion
    aceleracion.mult(0); //reseteo la aceleracion
    
  }


  void mostrar() { // funcion para mostrar la persona
    fill(255, 0, 0); // color rojo
    ellipse(posicion.x, posicion.y, radio, radio); //circulo en la posicion de la persona de radio r
  }
}


class Atractor {

  PVector posicion; //posicion del atractor
  float fuerzaAtractor = 1; // fuerza del atractor
  float r = 50; //radio del dibujo (no afecta a la fisica)

  Atractor(int posicionX, int posicionY) {

    posicion = new PVector(posicionX, posicionY); //creo un atractor en la posicion especificada
  }

  void mostrar() {

    fill(0, 0, 255); // color azul
    ellipse(posicion.x, posicion.y, r, r); // circulo en la posicion del atractor
  }
}
