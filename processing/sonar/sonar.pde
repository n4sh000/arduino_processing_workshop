// ===============================
// IMPORTAR LIBRERÍA SERIAL
// ===============================
import processing.serial.*;               

// Objeto para comunicación con Arduino
Serial myPort;                         

// Variables para almacenar datos recibidos
String ang = "";
String distance = "";
String data = "";

// Variables ya convertidas a números
int angle, dist;


// ===============================
// SETUP
// ===============================
void setup() {
  
   // Tamaño de la ventana (pantalla del radar)
   size(1000, 600);   

   // Abrir comunicación serial
   myPort = new Serial(this, "COM11", 9600);                     

   // Esto define el "final" de cada mensaje
   myPort.bufferUntil('.');  

   // Fondo negro
   background(0);
}


// ===============================
// LOOP PRINCIPAL
// ===============================
void draw() {

  // Dibuja un rectángulo semi-transparente
  fill(0, 5);              
  noStroke();
  rect(0, 0, width, height * 0.93); 

  // ---- BARRA INFERIOR ----
  noStroke();
  fill(0, 255);
  rect(0, height * 0.93, width, height);                   

  // ---- FUNCIONES DE DIBUJO ----
  drawRadar();   // Fondo del radar (arcos y líneas)
  drawLine();    // Línea verde que gira
  drawObject();  // Objeto detectado (rojo)
  drawText();    // Información en pantalla
}


// ===============================
// RECEPCIÓN DE DATOS 
// ===============================
void serialEvent(Serial myPort) {                                                     
  
  // Leer datos hasta encontrar '.'
  String raw = myPort.readStringUntil('.');
  
  if (raw == null) return;   

  // Limpiar espacios o saltos de línea
  raw = trim(raw);
  
  // Ángulo y distancia
  int index1 = raw.indexOf(","); 
  
  if (index1 == -1) return;
  
  // Separar ángulo y distancia
  ang = raw.substring(0, index1);         
  distance = raw.substring(index1 + 1);                            

  // Convertir a enteros
  angle = int(ang);
  dist = int(distance);
  
  // Imprimir en consola (debug)
  println(angle + "," + dist);
}


// ===============================
// DIBUJAR FONDO DEL RADAR
// ===============================
void drawRadar() {
  pushMatrix();           // Guarda sistema de coordenadas
  
  noFill();
  strokeWeight(0.5);
  stroke(10, 255, 10);    // Verde

  // Mover origen al centro inferior
  translate(width / 2, height - height * 0.06);    

  // Línea base
  line(-width / 2, 0, width / 2, 0);    

  // Arcos (distancias)
  arc(0, 0, width * 0.5, width * 0.5, PI, TWO_PI);
  arc(0, 0, width * 0.25, width * 0.25, PI, TWO_PI);
  arc(0, 0, width * 0.75, width * 0.75, PI, TWO_PI);
  arc(0, 0, width * 0.95, width * 0.95, PI, TWO_PI);

  // Líneas principales (cada 30°)
  line(0, 0, (-width/2)*cos(radians(30)), (-width/2)*sin(radians(30)));
  line(0, 0, (-width/2)*cos(radians(60)), (-width/2)*sin(radians(60)));
  line(0, 0, (-width/2)*cos(radians(90)), (-width/2)*sin(radians(90)));
  line(0, 0, (-width/2)*cos(radians(120)), (-width/2)*sin(radians(120)));
  line(0, 0, (-width/2)*cos(radians(150)), (-width/2)*sin(radians(150)));

  // Líneas intermedias (cada 15°)
  stroke(175, 255, 175);
  line(0, 0, (-width/2)*cos(radians(15)), (-width/2)*sin(radians(15)));
  line(0, 0, (-width/2)*cos(radians(45)), (-width/2)*sin(radians(45)));
  line(0, 0, (-width/2)*cos(radians(75)), (-width/2)*sin(radians(75)));
  line(0, 0, (-width/2)*cos(radians(105)), (-width/2)*sin(radians(105)));
  line(0, 0, (-width/2)*cos(radians(135)), (-width/2)*sin(radians(135)));
  line(0, 0, (-width/2)*cos(radians(165)), (-width/2)*sin(radians(165)));

  popMatrix();            // Restaurar coordenadas
}


// ===============================
// LÍNEA DEL RADAR
// ===============================
void drawLine() {
  pushMatrix();
  
  strokeWeight(9);
  stroke(0, 255, 0); // verde

  translate(width / 2, height - height * 0.06); 

  // Línea que gira según el ángulo recibido
  line(0, 0, (width/2)*cos(radians(angle)),-(width/2)*sin(radians(angle)));

  popMatrix();
}


// ===============================
// OBJETO DETECTADO
// ===============================
void drawObject() {
  pushMatrix();    

  strokeWeight(9);
  stroke(255, 0, 0); // rojo

  translate(width / 2, height - height * 0.06);

  // Escalar distancia real a pantalla
  float pixleDist = (dist / 40.0) * (width / 2.0);                       

  // Distancia restante hasta el borde
  float pd = (width / 2) - pixleDist;

  // Convertir a coordenadas X,Y 
  float x = -pixleDist * cos(radians(angle));
  float y = -pixleDist * sin(radians(angle));

  // Solo dibujar si está dentro del rango
  if (dist <= 40) {                               
    line(-x, y, -x + (pd * cos(radians(angle))), y - (pd * sin(radians(angle))));
  }

  popMatrix();
}


// ===============================
// TEXTO EN PANTALLA
// ===============================
void drawText() {
  pushMatrix();

  fill(100, 200, 255);
  textSize(25);

  // Marcas de distancia
  text("10cm", (width/2)+(width*0.115), height*0.93);
  text("20cm", (width/2)+(width*0.24), height*0.93);
  text("30cm", (width/2)+(width*0.365), height*0.93);
  text("40cm", (width/2)+(width*0.45), height*0.93);

  // Mostrar distancia actual
  if (dist <= 40) {
    text("Distance :" + dist, width*0.7, height*0.99);
  }

  // Mover origen para ángulos
  translate(width/2, height-height*0.06);

  // Etiquetas de ángulo
  text("30",  (width/2)*cos(radians(30)),  (-width/2)*sin(radians(30)));
  text("60",  (width/2)*cos(radians(60)),  (-width/2)*sin(radians(60)));
  text("90",  (width/2)*cos(radians(91)),  (-width/2)*sin(radians(90)));
  text("120", (width/2)*cos(radians(123)), (-width/2)*sin(radians(118)));
  text("150", (width/2)*cos(radians(160)), (-width/2)*sin(radians(150)));

  popMatrix();  
}
