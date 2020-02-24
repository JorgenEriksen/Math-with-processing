float ms;            // millis()
float t;             // time value that restarts each run
float r = 9;         // radius
float spawnTimer;          // used together with objPerSeconds
float objPerSeconds = 10;  // how many objects will be spawn per seconds
float velWeight = 3.5;     // the weight of velocity vector
float acceleration = 0.05; // acceleration y-axis
ArrayList<PhysOb> object;  // array of objects

void setup() {
  size(800, 600);
  object = new ArrayList<PhysOb>();
  object.add(new PhysOb(new PVector(width/2, height/2)));
  ms = millis();
}

void draw() {
  background(10, 10, 50);
  t = millis()-ms; // resets the timer
  t = t/1000;      // to seonds
  ms = millis();   // stores the ms to next draw
  spawnTimer += t*objPerSeconds;
  
  // launch each objPerSeconds
  if(spawnTimer >= 1){
    object.add(new PhysOb(new PVector(width/2, height/2))); // creates new object
    spawnTimer = 0;
  }
  
  // loops through all objects on screen
  for(int i = 0; i<object.size(); i++){
    PhysOb obj = object.get(i);
    obj.update();  // movement
    obj.display(); // draw the object
    
    // deletes the object if its position is under the ground
    if(obj.checkHeight()){
      object.remove(i);
    }
  } 
}

class PhysOb  {
  PVector pos;
  PVector vel;
  PVector acc;

  // constructor
  PhysOb (PVector position) {
    acc = new PVector(0, acceleration);
    float degree = random(-135, -45); // random degree
    float radians = degree * PI/180;  // degree to radians
    vel = new PVector(cos(radians), sin(radians));
    vel.mult(velWeight);
    pos = position;
  }

  void update() {
    vel.add(acc.mult(1+t));
    pos.add(vel.mult(1+t));
  }

  void display() {
    // color goes from orange to black based on pos.y
    fill( ((height-pos.y)/height/2)*4*255, ((height-pos.y)/height/2)*2*255, 0); 
    ellipse(pos.x, pos.y, r*2, r*2);
  }

  boolean checkHeight() {
    if (pos.y > height+r) {
      return true;
    } else {
      return false;
    }
  }
}
