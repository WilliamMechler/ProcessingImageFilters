PImage photo;
void settings() {
  photo = loadImage("cat.jpg");
  size(2*photo.width, photo.height);
}  

void setup() {

  /*color c = photo.get(0,0);
   float r = red(c);
   float g = green(c);
   float b = blue(c); */

  //println(r, g, b);

  //upper-left
  //photo.pixels[0] = color(255,0,0);
  //upper-left pixel get and set are easier to use but are more taxing on the computer
  //photo.set(0,0,color(255,0,0));


  photo.updatePixels();
  image(photo, 0, 0);
  image(negative(photo),width/2,0);
  //image(rotate180(photo),width/2,0); // calls rotate180
  //image(dark(photo),width/2,0); // calls darken filter
}


//Returns the negtaive of the Image that is passes in.
PImage negative(PImage org) {
  PImage result = createImage(org.width, org.height, RGB);
  result.loadPixels();

  for (int i = 0; i < org.pixels.length; i++) {
    color c = org.pixels[i];
    float r = red(c);
    float g = green(c);
    float b = blue(c);
    result.pixels[i] = color(255 - r, 255 - g, 255 - b);
  }

  result.updatePixels();
  return result;
}


//returns the image that is passes in but rotated 180 degrees
PImage rotate180(PImage org) {
  PImage result = createImage(org.width, org.height, RGB);
  result.loadPixels();

  for (int i = 0; i < org.pixels.length; i++) {
    color c = org.pixels[i];
    result.pixels[org.pixels.length-1 - i] = c;
  }

  result.updatePixels();
  return result;
}

//our first filter: darkens by mult rbg by the same factor
PImage dark(PImage org) {
  PImage result = createImage(org.width, org.height, RGB);
  result.loadPixels();

  for (int i = 0; i < org.pixels.length; i++) {
    color c = org.pixels[i];
    float r = red(c);
    float g = green(c);
    float b = blue(c);
    result.pixels[i] = color(r/2, g/2, b/2);
  }

  result.updatePixels();
  return result;
}


void randomCicles() {
  image(photo, 0, 0);
  noStroke();
  //Loop to draw random circles
  for (int count = 0; count < 1000; count++) {
    int x = (int)random(width);
    int y = (int)random(height);
    float size = random(10, 20);

    color c = photo.pixels[y*width+x];
    fill(c, 70);
    circle(x, y, size);
  }

  photo.updatePixels();
}
