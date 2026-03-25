import processing.serial.*;

Serial myPort;

// Variables
int distance = 0;

void setup() {
  size(800, 400);
  
  println(Serial.list());
  myPort = new Serial(this, "COM11", 9600);
  myPort.bufferUntil('.');
}

void draw() {
  background(0);

  // ---- MAPEO DE DISTANCIA A ANCHO ----
  
  float barWidth = map(distance, 0, 20, width, 0);
  
  // Limitar valores por seguridad
  barWidth = constrain(barWidth, 0, width);

  // ---- DIBUJAR BARRA ----
  fill(10, 200, 250);
  noStroke();
  rect(0, 0, barWidth, height);

  // ---- TEXTO ----
  fill(255);
  textSize(20);
  text("Distance: " + distance + " cm", 20, 30);
}

void serialEvent(Serial myPort) {
  String raw = myPort.readStringUntil('.');
  
  if (raw == null) return;
  
  raw = trim(raw);

  int commaIndex = raw.indexOf(",");
  if (commaIndex == -1) return;

  // Solo usamos la distancia
  String distStr = raw.substring(commaIndex + 1);
  distance = int(distStr);
}
