float windowx = 800;    // window width in px
float windowy = 600;    // window height in px
float r = 20;           // radius

// list of points
float p0[] = {0, 0};                                    
float p1[] = {windowx, 0};
float p3[] = {windowx, windowy};
float bPoint[] = {r, windowy/2};
float bPoint2[] = {windowx/3, 0};
float bPoint3[] = {2*windowx/3, windowy};
float bPoint4[] = {windowx-r, windowy/2};

float x;           // placeholder for x in translate()
float y;           // placeholder for y in translate()
float seconds;     // seconds it takes to do the motion
float ms;          // millis()
float t = 0;       // time in lerp formula
float colorR;      // red
float colorG;      // green
float colorB;      // blue
float colorValue;  // the color value for red and green (-255 - 255)


void setup() {
  size(800, 600);
  background(10, 10, 50);
}


void draw() {
  background(10, 10, 50);
  ms = millis();
  pushMatrix();
  pushMatrix();
  pushMatrix();
  pushMatrix();
  
  
  // I - RED DISK
  seconds = 3;
  t = calculateT(seconds, ms);
  x = lerpFormula(t, p0[0], p3[0]);
  y = lerpFormula(t, p0[1], p3[1]);
  translate(x, y);
  fill(200, 0, 0);
  ellipse(0, 0, r*2, r*2);
  
  
  // II - GREEN DISK
  popMatrix();
  seconds = 5;
  t = calculateT(seconds, ms);
  x = qCurve(t, p0[0], p1[0], p3[0]);
  y = qCurve(t, p0[1], p1[1], p3[1]);
  translate(x, y);
  fill(0, 200, 0);
  ellipse(0, 0, r*2, r*2);
  

  // III - LIGHT BLUE DISK
  popMatrix();
  seconds = 5;
  t = calculateT(seconds, ms);
  t = smoothStep3(t);
  x = lerpFormula(t, p0[0], p3[0]);
  y = lerpFormula(t, p0[1], p3[1]);
  translate(x, y);
  fill(0, 200, 200); 
  ellipse(0, 0, r*2, r*2);
  
   
  // IV - WHITE DISK
  popMatrix();
  seconds = 6;
  t = calculateT(seconds, ms);
  t = smoothStep5(t);
  x = cCurve(t, bPoint[0], bPoint2[0], bPoint3[0], bPoint4[0]);
  y = cCurve(t, bPoint[1], bPoint2[1], bPoint3[1], bPoint4[1]);
  translate(x, y);
  fill(255, 255, 255);
  ellipse(0, 0, r*2, r*2);
  
  
  // B - DISK IN CENTER 
  popMatrix();
  seconds = 6;
  t = calculateT(seconds, ms);
  colorR = 0;
  colorG = 0;
  colorB = 0;
  colorValue = lerpFormula(t, -255, 255); // -255 -> 0 is Red, 0 -> 255 is Green. 
  if(colorValue > 0 ){
    colorG = colorValue;     // Green
  } else {
    colorR = colorValue*-1;  // Red. Makes the negativ number a postiv.
  } 
  translate(windowx/2, windowy/2);
  fill(colorR, colorG, colorB);
  ellipse(0, 0, r*2, r*2);
}

// time in lap. returns value 0-1
float calculateT(float seconds, float ms){
  float placeholder;
  placeholder = ms/1000/seconds%2;
  if(placeholder>1){
    return 2-placeholder; 
  } 
  return placeholder;
}

// lerp
float lerpFormula(float t, float p1, float p2) {
   return (1-t)*p1 + t*p2;
}

// quadratic Bezier curve
float qCurve(float t, float p1, float p2, float p3){
   return pow((1-t), 2)*p1 + 2*(1-t)*t*p2 + pow(t, 2)*p3;
}

// cubic Bezier curve
float cCurve(float t, float p1, float p2, float p3, float p4){ 
    return pow((1-t), 3)*p1 + 3*pow((1-t), 2)*t*p2 + 3*(1-t)*pow(t, 2)*p3 + pow(t, 3)*p4;
}

// smoothstep polynomial of order 3
float smoothStep3(float t){
  return pow(t, 2)*(3-2*t);
}

// smoothstep polynomial of order 5
float smoothStep5(float t){
  return 6*pow(t, 5) - 15*pow(t, 4) + 10*pow(t, 3);
}
