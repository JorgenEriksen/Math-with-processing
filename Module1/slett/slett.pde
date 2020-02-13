PVector location, velocity, target,acceleration;
 
void setup() {
  size(400,400);
  location = new PVector(200,0);
  target = new PVector(width, height);
  acceleration = new PVector(0,0);
  velocity = new PVector();
}
 
void draw() {
  location.sub(target);
  location.setMag(2);
  acceleration = location;
  velocity.add(acceleration);
  target.add(velocity);
  velocity.limit(5);
  fill(255);
  ellipse(target.x,target.y,20,20);
}
