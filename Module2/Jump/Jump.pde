// Quick note:
// This is implemented with only physics scheme and not interpolation
// since I want to prioritize module 3.

float r = 30;         // radius
float ms;             // millis()
float t;              // time since last draw
PVector pos;          // position
PVector acc;          // acceleration
PVector vel;          // velocity
PVector jumpVel = new PVector(0, -3);   // jump velocity
PVector gravity = new PVector(0, 0.03); // gravity
float accSpeed = 0.05; // acceleration speed
float maxSpeed = 3;    // max speed
int jump;              // jump counter
boolean airborn;       // if ball is in air

void setup() {
  size(800, 600);
  ms = millis(); 
  pos = new PVector(width/2, height/2);
  acc = new PVector(0, 0);
  vel = new PVector(0, 0);
}

void draw() {
  background(10, 10, 50);

  t = millis()-ms; // resets the timer
  t = t/1000;      // to seonds
  print("\n" + t);

  ms = millis(); 
 
  ellipse(pos.x, pos.y, r*2, r*2);
  stroke(255);
  line(0, height/2+r, width, height/2+r);

  if(airborn){     // if ball is in the air
    if(vel.y > 0){ // if ball is going downwards      
      vel.y += gravity.y - vel.y/100; // hang-time
    } else {       // if ball is going upwards
      vel.add(gravity);
    }
    
    if(pos.y >= height/2){ // if back on ground or under
      vel.y = 0;
      pos.y = height/2;
      airborn = false;
    }
  } else { // if on ground
    gravity = new PVector(0, 0.03); // resets the gravity when on ground
    jump = 0;
  }

  move();
  checkEdges();

}

void move(){
  pos.add(new PVector(vel.x*(1+t), vel.y*(1+t)));
}

void keyPressed(){
  if (key == CODED) {
    if (keyCode == LEFT){
      acc = new PVector(-accSpeed, 0);
      vel.add(acc.mult(1+t));
      vel.limit(maxSpeed);
      acc = new PVector(0, 0);
      
    } else if (keyCode == RIGHT){
      acc = new PVector(accSpeed, 0);
      vel.add(acc.mult(1+t));
      vel.limit(maxSpeed);
      acc = new PVector(0, 0);
      
    } else if (keyCode == UP){
      if(jump < 2){
        vel.y = 0;
        if(jump == 0){ // first jump
          vel.add(jumpVel);
        } else {       // second jump
          vel.add(new PVector(0, jumpVel.y*0.6));
        }
        pos.y += jumpVel.y;
        airborn = true;
        gravity = new PVector(0, 0.03); 
        jump++;
      }
    
    } else if (keyCode == DOWN){
      gravity = new PVector(0, 0.16);
    }
  
  }
}

void checkEdges(){
  if(pos.x > width){
    pos.x = pos.x = 0;
  } else if (pos.x < 0) {
    pos.x = pos.x = width;
  }
}
