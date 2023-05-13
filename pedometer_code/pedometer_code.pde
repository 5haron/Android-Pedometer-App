/* Sharon Li
   Pedometer App
*/

import ketai.sensors.*;

KetaiSensor sensor;
PVector magneticField, accelerometer;
PVector[] accel_data;
int display_bin_count = 110;
int display_bin_counter;
int scale = 30;

float old_avg = 0;
float new_avg = 0;
int steps = 0;
boolean active = false;

void setup()
{
  sensor = new KetaiSensor(this);
  sensor.start();
  sensor.list();
  accelerometer = new PVector();
  textAlign(CENTER, CENTER);
  textSize(50);
  accel_data = new PVector[display_bin_count];
  for(int i =0; i < display_bin_count;i++)
  {
    accel_data[i] = new PVector(0,0,0);
  }
  display_bin_counter = 0;
}

void draw()
{
  // Add the current accelerometer reading to accel_data
  accel_data[display_bin_counter].set(accelerometer);
  
  // Set the background color
  background(100, 70, 200);
  
  // Loop through accel_data and draw a line graph of the magnitudes over time
  for (int i = 1; i < display_bin_count; i++) {
    // Apply a low-pass filter to the x, y, and z components of the accelerometer reading
    float alpha = 0.3; // Set the filter coefficient
    float x_filtered = alpha * accel_data[i-1].x + (1 - alpha) * accel_data[i].x;
    float y_filtered = alpha * accel_data[i-1].y + (1 - alpha) * accel_data[i].y;
    float z_filtered = alpha * accel_data[i-1].z + (1 - alpha) * accel_data[i].z;
    
    // Calculate the magnitude of the filtered accelerometer vector
    old_avg = sqrt((sq(x_filtered) + sq(y_filtered) + sq(z_filtered))/3);
    
    // Apply the same filter to the next data point
    float x_filtered_next = alpha * accel_data[i].x + (1 - alpha) * accel_data[(i+1)%display_bin_count].x;
    float y_filtered_next = alpha * accel_data[i].y + (1 - alpha) * accel_data[(i+1)%display_bin_count].y;
    float z_filtered_next = alpha * accel_data[i].z + (1 - alpha) * accel_data[(i+1)%display_bin_count].z;
    
    // Calculate the magnitude of the filtered accelerometer vector for the next data point
    new_avg = sqrt((sq(x_filtered_next) + sq(y_filtered_next) + sq(z_filtered_next))/3);
    
    // Draw a line segment between the current and next data points
    stroke(0);
    line(width * (i-1) / display_bin_count, (scale*old_avg) + height / 2, width * i / display_bin_count, (scale*new_avg) + height / 2);
    
    // Draw a small circle at the next data point
    noFill();
    ellipse(width * i / display_bin_count, (scale*new_avg) + height / 2, 2, 2);
  }
  
  // Update the display_bin_counter
  display_bin_counter = (display_bin_counter + 1) % display_bin_count;
  
  // Calculate the magnitude of the accelerometer vector
  float magnitude = sqrt((sq(accelerometer.x) + sq(accelerometer.y) + sq(accelerometer.z))/3);
  
  // If the magnitude is above a certain threshold, count it as a step
  if (magnitude > 12.5) {
    active = true;
  }
  
  if (active && magnitude < 12.5){
    steps++;
    active = false;
  }
  
  // Display the number of steps on the screen
  fill(255);
  text("Steps: " + steps, width/2, height/4);
  
  stroke(255, 0, 0);
  float thresholdY = height / 2 + scale * 12.5;
  line(0, thresholdY, width, thresholdY);
}


void onAccelerometerEvent(float x, float y, float z, long time, int accuracy)
{
  accelerometer.set(x, y, z);
}
