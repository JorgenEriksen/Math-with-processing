// Note: This solution does not work for more than 2 balls
// as explained by my video(https://youtu.be/guWIF87CmBg)
// See the many balls version for the fix. 

Ball b1, b2;

void setup(){
  size(800,600);
  b1 = new Ball(100,height/2,100);
  b2 = new Ball(500,height/2,50);
}

void draw(){
  background(255);
  b1.display();
  b1.move();
  b2.display();
  b2.move();
  collision(b1,b2);
}

void collision(Ball b1, Ball b2){
  float dx = b2.x - b1.x;
  float dy = b2.y - b1.y;
  float dist = sqrt(dx*dx+dy*dy);
  
  if(dist < b1.radius + b2.radius){
    float angle = atan2(dy,dx);
    float sin = sin(angle), cos = cos(angle);
    
    float x1 = 0, y1 = 0;
    
    // rotate velocity
    float vx1 = b1.vx*cos+b1.vy*sin;
    float vy1 = b1.vy*cos-b1.vx*sin;
    float vx2 = b2.vx*cos+b2.vy*sin;
    float vy2 = b2.vy*cos-b2.vx*sin;
    
    //resolve 1D velocity, use temp variables
    float vx1final = ((b1.mass-b2.mass)*vx1+2*b2.mass*vx2)/(b1.mass+b2.mass);
    float vx2final = ((b2.mass-b1.mass)*vx2+2*b1.mass*vx1)/(b1.mass+b2.mass);
    
    // update velocity
    vx1 = vx1final;
    vx2 = vx2final;
    
    //rotate vel back
    b1.vx = vx1*cos-vy1*sin;
    b1.vy = vy1*cos+vx1*sin;
    b2.vx = vx2*cos-vy2*sin;
    b2.vy = vy2*cos+vx2*sin;
    
    
   
    }
 
}
