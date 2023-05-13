# Android Pedometer App - README

## Table of Contents
1. [Overview](#overview)
   * [Description](#description)
   * [Features](#features)
2. [Getting Started](#getting-started)
   * [Requirements](#requirements)
   * [Usage](#usage)
3. [How it Works](#how-it-works)

## Overview
### Description
This repository contains a Processing sketch which utilizes the Ketai library to develop a pedometer app for Android devices. The app uses raw accelerometer data from the device to track the user's steps in real time and provides a rich visual display of sensor data.

### Features
* Real-time step tracking
* Graphical representation of accelerometer data
* Application of a low-pass filter to smooth the accelerometer data
* Peak detection algorithm for accurate step counting

## Getting Started
To get started with the Android Pedometer App, follow the steps below:

### Requirements
* Android device
* USB cable to connect your device to your computer
* Processing IDE
* Ketai library for Processing

### Usage
1. Open the Processing IDE (download [here](https://processing.org/download/)).
2. Open the sketch in the Processing IDE.
3. Connect your Android device and enable USB debugging.
4. Click the 'Run' button in the Processing IDE to compile and run the sketch on your Android device.
5. The application should open on your device where you can begin using it. 

## How it Works
The application relies on the Ketai library's ability to read accelerometer data from an Android device. This data represents the device's motion along the x, y, and z axes.

The application processes this raw data in real-time. It first visualizes this data on a line graph, plotting each data point as an ellipse for clarity. To smooth out the data, the app applies a low-pass filter. This process attenuates high-frequency noise, leaving a cleaner signal that more accurately represents the device's motion.

The application then computes the magnitude of the accelerometer data using the root mean square equation. This magnitude serves as the basis for detecting steps. The app sets a threshold for the magnitude; each time the magnitude exceeds this threshold, the application counts it as a step.

The core of this functionality is the `onAccelerometerEvent()` function, which is triggered by the Ketai library whenever a new accelerometer reading is available. This function ensures the accelerometer data the application uses is always up-to-date.
