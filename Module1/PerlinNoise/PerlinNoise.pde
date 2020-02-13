float ms;
float xoff = 0;
float yoff = 0;
float increment;
float random;
void setup() {
  size(800, 800);
  background(10, 10, 50);
}

void draw() {
  background(10, 10, 50);
  ms = millis();
  increment = 0.01;

  loadPixels();
  xoff = 0;
  // Updates the array pixels[]
  for (int x = 0; x < width; x++) {
    yoff = 0;
    for(int y = 0; y < height; y++){
      float r = noise3(xoff, yoff)*255;
      pixels[x+width*y] = color(r, r, r);
      yoff += increment; 
    }
    xoff += increment;
  }
  
  // move changed pixels to screen
  updatePixels();
}


float noise3(float x, float y) {
  return (noise(x,y,256)+0.5*noise(x,y,128)+0.22*noise(x,y,64))/1.75;
}

void keyPressed() {
save("myimage.png");
}
