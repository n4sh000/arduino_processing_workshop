// ===============================
// LIBRERÍAS
// ===============================
#include <Servo.h>

// ===============================
// DEFINICIÓN DE PINES
// ===============================
int trig = 7;       // Pin TRIG del sensor ultrasónico
int echo = 6;       // Pin ECHO del sensor ultrasónico
int servoPin = 11;  // Pin del servo motor

// ===============================
// VARIABLES GLOBALES
// ===============================
long duration;   // Tiempo que tarda el eco en regresar
int distance;    // Distancia calculada en cm

// Crear objeto servo
Servo myservo;


// ===============================
// FUNCIÓN PARA MEDIR DISTANCIA
// ===============================
int calculateDistance()
{
  // Asegurar pulso limpio
  digitalWrite(trig, LOW);
  delayMicroseconds(2);

  // Enviar pulso ultrasónico (10 microsegundos)
  digitalWrite(trig, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig, LOW);

  // Leer el tiempo que tarda en regresar el eco
  duration = pulseIn(echo, HIGH);

  // Convertir tiempo a distancia
  // Velocidad del sonido ≈ 0.0343 cm/µs
  // Se divide entre 2 porque es ida y vuelta
  distance = duration * 0.0343 / 2;

  return distance;
}


// ===============================
// SETUP
// ===============================
void setup()
{
  // Configurar pines
  pinMode(trig, OUTPUT);
  pinMode(echo, INPUT);

  // Inicializar servo
  myservo.attach(servoPin);

  // Iniciar comunicación serial
  Serial.begin(9600);
}


// ===============================
// LOOP PRINCIPAL
// ===============================
void loop()
{
  int i;

  // ---- BARRIDO DE IZQUIERDA A DERECHA ----
  for (i = 15; i <= 165; i++)
  {
    // Mover el servo al ángulo actual
    myservo.write(i);

    // Pequeña pausa para que el servo llegue
    delay(15);

    // Medir distancia
    calculateDistance();

    // Enviar datos a Processing
    Serial.print(i);        //ángulo
    Serial.print(",");
    Serial.print(distance); //distancia
    Serial.print(".");      //delimitador de mensaje
  }

  // ---- BARRIDO DE DERECHA A IZQUIERDA ----
  for (i = 165; i >= 15; i--)
  {
    myservo.write(i);
    delay(15);

    calculateDistance();

    Serial.print(i);
    Serial.print(",");
    Serial.print(distance);
    Serial.print(".");
  }
}
