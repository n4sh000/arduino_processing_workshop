# Arduino Sonar Radar with Processing

This project implements a simple radar system using an ultrasonic sensor and a servo motor with Arduino, along with a realtime graphical interface built in Processing.

<img width="1280" height="960" alt="image" src="https://github.com/user-attachments/assets/9d334e86-99d9-4cd3-918b-8bde90166ec6" />

## Features

* Measures distance using an ultrasonic sensor (HC-SR04)
* Rotates the sensor using a servo motor (angular sweep)
* Sends data via serial communication
* Visualizes the data as a radar in real time using Processing

## Hardware Requirements

* Arduino (Uno, Nano, or similar)
* HC-SR04 Ultrasonic Sensor
* Servo Motor (e.g., SG90)
* Jumper wires

## Setup Instructions

### 1. Clone the repository

```
git clone https://github.com/n4sh000/arduino_processing_workshop.git
```

### 2. Upload Arduino Code

* Open `arduino/sonar/sonar.ino`
* Select the correct board and COM port
* Upload the code to your Arduino

### 3. Run Processing Visualization

* Open `processing/sonar/sonar.pde`
* Update the serial port (e.g., COM11)
* Run the sketch

### 4. Circuit Diagram
<img width="1074" height="766" alt="image" src="https://github.com/user-attachments/assets/321582ff-c9da-4bbc-8922-3b438f4d0af4" />

## Important Notes

* Close the Arduino Serial Monitor before running Processing
* Make sure both Arduino and Processing use the same baud rate (9600)
* Data format must be: `angle,distance.`

## How It Works

1. Arduino triggers the ultrasonic sensor to measure distance
2. The servo motor rotates the sensor across angles (15° to 165°)
3. Arduino sends angle and distance via serial communication
4. Processing reads the data and converts it into coordinates
5. A radar-like visualization is drawn using trigonometry (sine & cosine)

## Troubleshooting

* No data in Processing: Check COM port
* Program crashes: Ensure correct data format (`angle,distance.`)
* Servo not moving: Check wiring and power supply
* Inconsistent distance: Sensor noise (normal behavior)

## Acknowledgments

This project was built with ideas and code from a similar Arduino sonar radar implementation published by **_RoboArmy_**.

Original idea and concept reference:
[here](https://roboarmy.in/project/21)

_This repository is an independent implementation created for educational workshop purposes only._

## License

This project is licensed under the MIT License.

---

Built with 💙 for IEEE EDS SBC at ITCR

***David Ignacio Araya Mora***
