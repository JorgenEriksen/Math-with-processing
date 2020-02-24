float maxSpeed = 5;  // speed
int r = 10;          // radius of ball
int numBalls = 25;   // number of balls
float ms;            // millis()
float t;             // time value that restarts each run

PVector[] pos = new PVector[numBalls]; // position
PVector[] vel = new PVector[numBalls]; // velocity

void setup(){
    size(500, 500);
    boolean loop;
    float randomX;
    float randomY;
    
    // sets random position to balls and gives them 0 velocity
    for(int i=0; i<numBalls; i++){
      do{
        loop = false;
        randomX = random(r, width-r);
        randomY = random(r, height-r);
        for(int a=0; a<i; a++){ 
          if(distance(new PVector(randomX, randomY), pos[a]) <= r*2){ // if overlap
            loop = true; // then loop so new x/y position can be generated
          }
        }
      } while(loop);
      vel[i] = new PVector(0, 0); // no velocity
      pos[i] = new PVector(randomX, randomY);
    }
    // sets random velocity to ball number 0
    randomX = random(maxSpeed*-1, maxSpeed);
    randomY = random(maxSpeed*-1, maxSpeed);
    vel[0] = new PVector(randomX, randomY).normalize();
}


void draw(){
  background(10, 10, 50);
  t = millis()-ms; // resets the timer
  t = t/20;        // makes the value smaler
  ms = millis();

  for(int i=0; i<numBalls; i++){
     movement(i);     // moves the ball
     collision(i);    // checks for collision and calculates new velocity for colliding ball
     checkEdges(i);   // so it bounces on walls
     fill(255); 
     ellipse(pos[i].x, pos[i].y, r*2, r*2);
  }
}

void movement(int i){
  vel[i].mult(5);
  vel[i].limit(maxSpeed);
  pos[i].x = lerpFormula(t, pos[i].x, vel[i].x + pos[i].x);
  pos[i].y = lerpFormula(t, pos[i].y, vel[i].y + pos[i].y);
}

void collision(int i){
  for(int a=0; a<numBalls; a++){
    // if collision/overlap 
    if(distance(pos[i], pos[a]) <= r*2 && i != a){
      float distanceX = pos[a].x - pos[i].x; 
      float distanceY = pos[a].y - pos[i].y;
      PVector newVel = new PVector(distanceX, distanceY); // new velocity
      newVel.normalize(); // makes it a unit vector
      vel[a] = newVel;    // sets the new velocity
      pos[a].add(vel[a]); // moves out of collision state
    }   
  }
}


void checkEdges(int i){
  if(pos[i].x > width-r){
    vel[i].x = -vel[i].x;
    pos[i].x = width-r;
  } else if (pos[i].x < r) {
    vel[i].x = -vel[i].x;
    pos[i].x = r;
  }
  
  if(pos[i].y > height-r){
    vel[i].y = -vel[i].y;
    pos[i].y = height-r;
  } else if (pos[i].y < r) {
    vel[i].y = -vel[i].y;
    pos[i].y = r;
  }
}

float distance(PVector vector, PVector vector2){
  return sqrt( pow(vector.x-vector2.x, 2) + pow(vector.y-vector2.y, 2) );
}

float lerpFormula(float t, float p1, float p2) {
   return (1-t)*p1 + t*p2;
}
