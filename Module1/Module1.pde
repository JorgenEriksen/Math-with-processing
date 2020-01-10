int a = 1;
float planetAngle = 0; 
float planetOrbitRadius = 120; 

float planet2Angle = -200; 
float planet2OrbitRadius = 180; 

float moonAngle = 0;
float moonOrbitRadius = 40; // hvor langt ut fra planet1

float moon2Angle = 90;
float moon2OrbitRadius = 25; // hvor langt ut fra planet1


void setup() {
  size(800, 600);
  background(0, 0, 0);
}

void draw() {
  background(0, 0, 0);
  translate(width/2,height/2);
    
  fill(255, 140, 0);
  ellipse(0, 0, 80, 80);
  
  pushMatrix();
  
 
  
  // planet 1
  rotate(planetAngle);
  translate(planetOrbitRadius, 0);
  fill(0, 50, 200);
  ellipse(0, 0, 20, 20);
  
  pushMatrix();
  
  // måne
  rotate(moonAngle);
  translate(moonOrbitRadius, 0);
  fill(200, 200, 200);
  ellipse(0, 0, 10, 10);
  
  popMatrix();
  
  rotate(moon2Angle);
  translate(moon2OrbitRadius, 0);
  fill(250, 250, 250);
  ellipse(0, 0, 7, 7);
  
  
  popMatrix();
  // planet 2
  rotate(planet2Angle);
  translate(planet2OrbitRadius, 0);
  fill(100, 0, 100);
  ellipse(0, 0, 40, 40);
  
  
  
  planetAngle += 0.005;
  planet2Angle += 0.01;
  moonAngle += 0.02;
  moon2Angle += 0.03;
  
  a++;
}
