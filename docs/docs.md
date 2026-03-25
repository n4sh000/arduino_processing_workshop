# System Explanation

## Overview

This project combines hardware and software to create a radar-like system.

## Arduino Side

- Controls a servo motor to sweep angles
- Uses an ultrasonic sensor to measure distance
- Sends data via serial in the format:
  `angle,distance`.

## Processing Side

- Reads serial data
- Parses angle and distance
- Uses trigonometry to map polar coordinates to screen coordinates
- Displays a radar visualization

## For further understanding

### Serial Communication
Data is transmitted as plain text via UART.

### Ultrasonic Sensing
Distance is calculated using the speed of sound:

`distance = (time * speed of sound) / 2`

### Coordinate Transformation
Polar to Cartesian conversion:

`x = r * cos(θ)`

`y = r * sin(θ)`
