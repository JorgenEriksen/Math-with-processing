float sunSize = 90;

float planetAngle = 90; 
float planetOrbitRadius = 90; 

float planet2Angle = 270; 
float planet2OrbitRadius = 150; 

float planet3Angle = 0; 
float planet3OrbitRadius = 50;
float planet3posX = 0;
float planet3posY = 0;
float radiusX = 100;
float radiusY = 200;
float theta = 0;

float planet4Size = 30;         // is also used to calculate collision
float planet4Angle = 180; 
float planet4OrbitRadius = 220; 

float moonAngle = 0;
float moonOrbitRadius = 40; 

float moon2Angle = 90;
float moon2OrbitRadius = 25; 


void setup() {
  size(800, 600);
  background(0, 0, 0);
}

void draw() {
  background(0, 0, 0);
  
  // sun
  translate(width/2,height/2);
  fill(255, 140, 0);
  ellipse(0, 0, sunSize, sunSize);
  
  pushMatrix();
  pushMatrix();
  pushMatrix();
 
  // planet 1 (blue)
  rotate(planetAngle);
  translate(planetOrbitRadius, 0);
  fill(0, 50, 200);
  ellipse(0, 0, 20, 20);
  
  pushMatrix();
  
  // moon 1
  rotate(moonAngle);
  translate(moonOrbitRadius, 0);
  fill(200, 200, 200);
  ellipse(0, 0, 10, 10);
  
  popMatrix();
  
  // moon 2
  rotate(moon2Angle);
  translate(moon2OrbitRadius, 0);
  fill(250, 250, 250);
  ellipse(0, 0, 7, 7);
  
  popMatrix();
  
  // planet 2 (purple)
  rotate(planet2Angle);
  translate(planet2OrbitRadius, 0);
  fill(100, 0, 100);
  ellipse(0, 0, 40, 40);
  
  // moon 3
  rotate(moonAngle + 90);
  translate(moonOrbitRadius, 0);
  fill(150, 150, 150);
  ellipse(0, 0, 10, 10);
  
 popMatrix();
 
  // planet 3 (pink)
  theta += 0.01;
  planet3posX = radiusX * cos(theta);
  planet3posY = radiusY * sin(theta);
  
  translate(0, 0);
  fill(300, 50, 200);
  ellipse(planet3posX, planet3posY, 20, 20);
  
  popMatrix();
  
  // planet 4 spiral (green)
  rotate(planet4Angle);
  if (planet4OrbitRadius <= (sunSize/2) + (planet4Size/2)){ // if the planet touches the sun
    translate(1000, 0); // removes the planet by moving it outside of the visible spectre
  } else {
    translate(planet4OrbitRadius, 0);
  }
  fill(0, 200, 100);
  ellipse(0, 0, planet4Size, planet4Size);
  
  planetAngle += 0.005;
  planet2Angle += 0.01;
  planet4Angle += 0.02;
  planet4OrbitRadius -= 0.3;
  moonAngle += 0.01;
  moon2Angle += 0.025;
}
