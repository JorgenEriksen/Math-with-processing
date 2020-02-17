float randomX;
float randomY;
boolean loop;
float maxSpeed = 3;
int r = 10;
int numBalls = 20;


PVector[] pos = new PVector[numBalls];
PVector[] vel = new PVector[numBalls];



void setup(){
    size(500, 500);
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
    
    randomX = random(maxSpeed*-1, maxSpeed);
    randomY = random(maxSpeed*-1, maxSpeed);
    vel[0] = new PVector(randomX, randomY);

}


void draw(){
  background(10, 10, 50);

  
  for(int i=0; i<numBalls; i++){
     movement(i);
     collision(i);
     checkEdges(i);
     
     if(i==0) {
       fill(200, 0, 0);
     } else {
       fill(255); 
     }
     ellipse(pos[i].x, pos[i].y, r*2, r*2);
  }
  

}

void collision(int i){
  print("\nHER");
  for(int a=0; a<numBalls; a++){
    if(distance(pos[i], pos[a]) <= r*2 && distance(pos[i], pos[a]) != 0){
      float distanceX = pos[a].x - pos[i].x;
      float distanceY = pos[a].y - pos[i].y;
      
      float angle = atan2(distanceY, distanceX);
      float sin = sin(angle);
      float cos = cos(angle);
      

      
      float vx2 = vel[i].x*cos+vel[i].y*sin;
      float vy2 = vel[i].y*cos-vel[i].x*sin;
      
      float vx1 = 0;
      float vy1 = 0;
      

      /*
      float vx1 = vel[i].x*cos+vel[i].y*sin;
      float vy1 = vel[i].y*cos-vel[i].x*sin;
      
      float vx2 = vel[a].x*cos+vel[a].y*sin;
      float vy2 = vel[a].y*cos-vel[a].x*sin;
      */
      
      print("\nvel[i]: " + vel[i]);
      print("\nvel[a]: " + vel[a]);
      
      print("\nvx1 :" + vx1);
      print("\nvy1 :" + vy1);
      print("\nvx2 :" + vx2);
      print("\nvy2 :" + vy2);
      
      vel[i].x = vx1;
      vel[i].y = vy1;
      
      vel[a].x = vx2;
      vel[a].y = vy2;
      
      
    
    }
  }


}

void movement(int i){
  vel[i].limit(maxSpeed);
  pos[i].add(vel[i]);
}

void checkEdges(int i){
  if(pos[i].x > width-r){
    vel[i].x = -vel[i].x;
  } else if (pos[i].x < r) {
    vel[i].x = -vel[i].x;
  }
  
  if(pos[i].y > height-r){
    vel[i].y = -vel[i].y;
  } else if (pos[i].y < r) {
    vel[i].y = -vel[i].y;
  }

}

float distance(PVector vector, PVector vector2){
  return sqrt( pow(vector.x-vector2.x, 2) + pow(vector.y-vector2.y, 2) );
}
