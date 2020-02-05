float windowx = 800;    // Processing window length in px
float windowy = 600;    // Processing window height in px

float r = 20;           // Radius to disks

float ms;               // millis()
float msSix;            // millis() % 6000
float msTen;            // millis() % 10000
int seconds;            // interval for travel (green disk)
float  msColor;         // millis() % (255*2)
float toTheCenter;      // 0.0 - 1.0
float fromTheCenter;    // 0.0 - 1.0

int curvSteps;          // number of total steps in the bezier curve both ways, but without start and end point
int counter = 0;        // keep tracks of curv steps

float toPoint;      
float placeholder;      // 0.0 - 1.0
float colorR, colorG, colorB; // color variable for the centred disk 

boolean test = true;

void setup() {
  size(800, 600);
  background(10, 10, 50);
}

void draw() {
  background(10, 10, 50);
  translate(0, 0);
  pushMatrix();
  pushMatrix();

  ms = millis();


  // YELLOW DISK

  msSix = ms % 6000; // counts only to 6000 milliseconds
  toTheCenter = msSix/10000*3.3333;

  if (toTheCenter <= 1.0) {
    translate(lerp(r, windowx-r, toTheCenter), lerp(r, windowy-r, toTheCenter));
  } else {
    fromTheCenter = 2.0-toTheCenter;
    translate(lerp(r, windowx-r, fromTheCenter), lerp(r, windowy-r, fromTheCenter));
  }

  fill(255, 255, 0);
  ellipse(0, 0, r*2, r*2);

  popMatrix();


  // GREEN DISK

  int steps = 40; // number of steps in the bezier curve. 
  float[] pointX = new float[steps];
  float[] pointY = new float[steps];

  curvSteps = steps*2-4;  // number of total steps in the bezier curve both ways, but without start and end point

  // fill(255);
  // bezier(r, r, 50, 900, 200, -500, 800, 600);
  
  float controllPoint1 = windowx/3;
  int controllPoint2;

  for (int i = 0; i < steps-1; i++) {
    float t = i / float(steps);
    // r, r, 50, 900, 200, -500, 800, 600  bezier start point, 2 controll points, bezier end point.
    float x = bezierPoint(r, windowx/3, 2*windowx/3, 800, t);
    float y = bezierPoint(r, 0, windowy, 600, t);
    pointX[i] = x;
    pointY[i] = y;

  }
  pointX[steps-1] = windowx;
  pointY[steps-1] = windowy;

  // Remove the comment symbol under to see the curv steps
  
  for (int i = 0; i < steps-1; i++) {
    ellipse(pointX[i], pointY[i], 5, 5);
  }
  
  fill(255, 0, 0);
  ellipse(windowx/3, 0, 20, 20);
  ellipse(2*windowx/3, windowy, 5, 5);
  

  seconds = 5;                     // time to travel
  msTen = ms %(seconds*2*1000);    // counts only to (int)seconds*2 seconds
  toPoint = msTen/1000*(steps-1)/seconds;

  if (msTen/1000 <= seconds) { 

    if (counter >= curvSteps) { // resets the counter when the disk has done one lap
      counter = 0;
    }

    if (toPoint < 1.0+counter) {
      placeholder=toPoint-counter;
      translate(lerp(pointX[counter], pointX[counter+1], placeholder), lerp(pointY[counter], pointY[counter+1], placeholder));
    } else {
      translate(pointX[counter+1], pointY[counter+1]);
      counter++;
    }
  } else {
    if (toPoint < 1.0+counter+1) {
      // print("**** " + toPoint +" ****" + "#### " + counter + " ###");
      placeholder=toPoint-counter-1;
      translate(lerp(pointX[curvSteps-counter+1], pointX[curvSteps-counter], placeholder), lerp(pointY[curvSteps-counter+1], pointY[curvSteps-counter], placeholder));
    } else {
      translate(pointX[curvSteps-counter], pointY[curvSteps-counter]);
      counter++;
    }
  }

  fill(100, 300, 50);
  ellipse(0, 0, r*2, r*2);

  popMatrix();


  // DISK IN CENTER

  colorR = 0;
  colorG = 0;
  colorB = 0;

  msColor= ms/10 % (255*4);
  if (msColor <= 255) {           
    colorR = msColor;
  } else if (msColor <= 255*2) {
    colorR = 255*2-msColor;
  } else if (msColor <= 255*3) {
    colorG = -255*2+msColor;
  } else if (msColor <= 255*4) {
    colorG = 255*4-msColor;
  }

  translate(windowx/2, windowy/2);
  fill(colorR, colorG, colorB);
  ellipse(0, 0, r*2, r*2);
}
