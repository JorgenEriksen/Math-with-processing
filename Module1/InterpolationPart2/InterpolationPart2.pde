float windowx = 800;  // window width in px
float windowy = 600;  // window height in px
float pi = 3.14159;   // PI
int r;                // radius
float ms;             // millis()
float seconds;        // seconds it takes to do the motion
float t;              // time in lerp formula
int len;              // length of square (r*2);
int number;           // number of triangles
int num;              // number of triangles of each side in square  (number/4)

void setup() {
  size(800, 600);
  background(10, 10, 50);
}

void draw() {
  background(10, 10, 50);
  ms = millis();
  seconds = 5;   // seconds for lerp
  t = calculateT(seconds, ms);
  r = 140;    // radius
  len = r*2; // length of each side of the square
  number = 16; // number of triangles (must be divisible by 4)
  num = number/4; // number of triangles for each side
  
  // C
  for(int i=0; i<number; i++){
    float[] cCircle = cCircle(i, pi, number); // circle coordinates
    float[] cCoordinates = cSquare(i, len, num); // square coordinates
    fill(255, 0, 0);
    triangle(windowx/2, windowy/2,
    lerpFormula(t, cCircle[0], cCoordinates[2]), lerpFormula(t, cCircle[1], cCoordinates[1]),
    lerpFormula(t, cCircle[2], cCoordinates[0]), lerpFormula(t, cCircle[3], cCoordinates[3]));
  }
}

// lerp formula
float lerpFormula(float t, float p1, float p2) {
   return (1-t)*p1 + t*p2;
}

// calculates t value. Returns a number between 0 and 1.
float calculateT(float seconds, float ms){
  float placeholder;
  placeholder = ms/1000/seconds%2;
  if(placeholder>1){
    return 2-placeholder; 
  } 
  return placeholder;
}

// returns the square coordinates
float[] cSquare(float i, float len, float num){
    float[] coordinates = new float[4]; // return variable
    float x1; // x of first point
    float x2; // x of second point
    float y1; // y of first point
    float y2; // y of second point

    // This creates the point in the same order as the circle.
    // It starts from (1, 0) and then clockwise
    if(i<2){ // half on right
    x1 = windowx/2+len/2;
    y1 = windowy/2-len/2+len/num*(i+2);
    x2 = windowx/2+len/2;
    y2 = windowy/2-len/2+len/num*(i+3);
    } else if(i<6){ //bottom
    x1 = windowx/2-len/2+len/num*(5-i);
    y1 = windowy/2+len/2;
    x2 = windowx/2-len/2+len/num*(6-i);
    y2 = windowy/2+len/2;
    } else if(i<10){ // left
    x1 = windowx/2-len/2;
    y1 = windowy/2-len/2+len/num*(10-i);
    x2 = windowx/2-len/2;
    y2 = windowy/2-len/2+len/num*(9-i);
    } else if(i<14){ // top
    x1 = windowx/2-len/2+len/num*(-9+i);
    y1 = windowy/2-len/2;
    x2 = windowx/2-len/2+len/num*(-10+i);
    y2 = windowy/2-len/2;
    } else {         // rest of the half on the right
    x1 = windowx/2+len/2;
    y1 = windowy/2-len/2+len/num*(i-14);
    x2 = windowx/2+len/2;
    y2 = windowy/2-len/2+len/num*(i-13);
    }

    // sets the coordinates in array
    coordinates[0] = x1;
    coordinates[1] = y1;
    coordinates[2] = x2;
    coordinates[3] = y2;
    // returns the array
    return coordinates;     
}

// returns the circle coordinates
float[] cCircle(float i, float pi, float num){
    float[] coordinates = new float[4]; // return variable
    // It starts from (1, 0) and then clockwise
    coordinates[0] = windowx/2 + r*cos(i*2*pi/num);
    coordinates[1] = windowy/2 + r*sin(i*2*pi/num);
    coordinates[2] = windowx/2 + r*cos((i+1)*2*pi/num);
    coordinates[3] = windowy/2 + r*sin((i+1)*2*pi/num);
    // returns the array
    return coordinates;
}
