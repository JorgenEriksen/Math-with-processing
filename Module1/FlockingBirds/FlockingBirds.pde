float randomX;
float randomY;

float r = 5;           // radius
int numObj = 30;

PVector[] acc = new PVector[numObj];
PVector[] pos = new PVector[numObj];
PVector[] vel = new PVector[numObj];
float[] theta = new float[numObj];
PVector target = new PVector(0, 0);

PVector rule1; 
PVector rule2;
PVector rule3;
float weight = 20;
float seperationWeight = 30;



//PVector acc = new PVector(0,0);
//PVector pos = new PVector(width/2,height/2);
//PVector vel = new PVector(0,-2);

float visionField = 200;
float seperationField = 50;

float maxSpeed = 6;
float maxForce = 0.1;

boolean once = false;

void setup() {
  size(800, 600);
  background(10, 10, 50);

  
  // sets acceleration, and random start velocity and positions for birds
  for(int i=0; i<numObj; i++){
    randomX = random(0, width);
    randomY = random(0, height);
    pos[i] = new PVector(randomX, randomY);
    
    randomX = random(maxSpeed*-1, maxSpeed);
    randomY = random(maxSpeed*-1, maxSpeed);
    vel[i] = new PVector(randomX, randomY);
    
    acc[i] = new PVector(0, 0);
  }
  

}


void draw() {
  background(10, 10, 50);
  
  if(once == false){
    //med klokken
    PVector test2 = new PVector (2, 3);
    print("\natan2: " + atan2(test2.y, test2.x)*180/PI);
    test2 = new PVector (3, 2);
    print("\natan2: " + atan2(test2.y, test2.x)*180/PI);
    print("\ntest2:" + test2);
    test2 = new PVector(test2.y, -test2.x);
    print("\ntest2:" + test2);
    test2 = new PVector(test2.y, -test2.x);
    print("\ntest2:" + test2);
    
    //mot klokken
    print("\n**********");
    test2 = new PVector (2, 3);
    print("\ntest2:" + test2);
    test2 = new PVector(-test2.y, test2.x);
    print("\ntest2:" + test2);
    test2 = new PVector(-test2.y, test2.x);
    print("\ntest2:" + test2);
  }
  
  for(int i=0; i<numObj; i++){

    // rules to create target
    rule1 = avgPos(i);
    rule2 = avgVel(i);
  
    
    rule3=seperation(i);

    //PVector test = PVector.sub(rule2, rule3);

    
    // movment
    target = rule1.add(rule2.x*weight, rule2.y*weight);
    target.add(rule3.x*seperationWeight, rule3.y*seperationWeight);
    steer(i);
    
    update(i);
    checkEdges(i);
    display(i);
  }
  
    //  fill(10, 10, 10);
  //ellipse(pos[0].x, pos[0].y, seperationField, seperationField);
  
  
  
  once = true;
    
}


PVector avgPos(int i){
  int counter = 0;
  float sumX = 0;
  float sumY = 0;
  for(int a=0; a<numObj; a++){
    if(dist(pos[i].x, pos[i].y, pos[a].x, pos[a].y) <= visionField){
    sumX += pos[a].x;
    sumY += pos[a].y;
    counter++;
    }
  }
  
  
  
  return new PVector(sumX/counter, sumY/counter);
}

PVector avgVel(int i){
  int counter = 0;
  float sumX = 0;
  float sumY = 0;
  for(int a=0; a<numObj; a++){
    if(dist(pos[i].x, pos[i].y, pos[a].x, pos[a].y) <= visionField){
    sumX += vel[a].x;
    sumY += vel[a].y;
    counter++;
    }
  }
  return new PVector(sumX/counter, sumY/counter);

}

PVector seperation(int i){
  PVector avgVel;
  int counter = 0;
  float sumX = 0;
  float sumY = 0;
  
  for(int a=0; a<numObj; a++){
    // 0 is self
    if(dist(pos[i].x, pos[i].y, pos[a].x, pos[a].y) <= seperationField && dist(pos[i].x, pos[i].y, pos[a].x, pos[a].y) != 0){
       sumX += vel[a].x;
       sumY += vel[a].y;
      counter++;
    }
  }
  
  // so doesnt return NaN.
  if(counter == 0){
    return new PVector(0, 0);
  }
  
  avgVel = new PVector(sumX/counter, sumY/counter);
  float avgVelDegree = atan2(avgVel.y, avgVel.x)*180/PI;
  float vecDegree = atan2(vel[i].y, vel[i].x)*180/PI;
  
  if(vecDegree >= avgVelDegree){
    return new PVector(vel[i].y, -vel[i].x);
  } else {
    return new PVector(-vel[i].y, vel[i].x);
  }

  
}


void steer(int i){
  PVector desired; // the desired destination for bird
  PVector steer;
  
  
  desired = PVector.sub(target, pos[i]);  // A vector pointing from the position to the target

  // Scale to maximum speed
  desired.setMag(maxSpeed);

  // Steering = Desired minus velocity
  steer = PVector.sub(desired, vel[i]);
  steer.limit(maxForce);  // Limit to maximum steering force
  acc[i].add(steer);
}

void update(int i) {
  vel[i].add(acc[i]);
  vel[i].limit(maxSpeed);
  pos[i].add(vel[i]);
  acc[i].mult(0); // set acceleration 
}

void display(int i){
  theta[i] = vel[i].heading2D() + PI/2;
   if(i == 0){
    // print("\n#... theta: " + theta[i]);
  }
  if(i==0){
    fill(255, 100, 50);
  } else {
    fill(240, 240, 240);
  }
  strokeWeight(1);
  stroke(0);
  pushMatrix();
  translate(pos[i].x, pos[i].y);
  rotate(theta[i]);
  beginShape();
  vertex(r, r*2);
  vertex(-r, r*2);
  vertex(0, -r*2);
  endShape(CLOSE);
  popMatrix();
}

void checkEdges(int i){
  if(pos[i].x > width){
    pos[i].x = pos[i].x = 0;
  } else if (pos[i].x < 0) {
    pos[i].x = pos[i].x = width;
  }
  
  if(pos[i].y > height){
    pos[i].y = pos[i].y = 0;
  } else if (pos[i].y < 0) {
    pos[i].y = pos[i].y = height;
  }
  

}
