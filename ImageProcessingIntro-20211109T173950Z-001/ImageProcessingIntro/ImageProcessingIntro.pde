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
  //image(Poster(photo), width/2, 0); // calls the Poster filter
  //image(whiteAndBlack(photo), width/2, 0); // calls white and black filter
  //image(grayScale(photo),width/2, 0); // calls gray scale
  //image(negative(photo),width/2, 0); // calls negative
  //image(rotate180(photo),width/2, 0); // calls rotate180
  //image(dark(photo),width/2, 0); // calls darken filter
}

PImage Poster(PImage org) {
  PImage result = createImage(org.width, org.height, RGB);
  result.loadPixels();

  for (int i = 0; i < org.pixels.length; i++) { // might be right as is.
    color c = org.pixels[i];
    float r = red(c);
    float g = green(c);
    float b = blue(c);
    
    int newR = (int)(r / 32) * 32;
    int newG = (int)(r / 32) * 32;    
    int newB = (int)(r / 32) * 32;    
    
    result.pixels[i] = color(newR, newG, newB);
  }

  result.updatePixels();
  return result;
}


//Returns the White and Black verison of the Image that is passes in.
PImage whiteAndBlack(PImage org) {
  PImage result = createImage(org.width, org.height, RGB);
  result.loadPixels();

  for (int i = 0; i < org.pixels.length; i++) { // might be right as is.
    color c = org.pixels[i];
    float r = red(c);
    float g = green(c);
    float b = blue(c);
    if ((r+g+b/3) >= 128) { // closer to white
      result.pixels[i] = color(255);
    } else { // closer to black
      result.pixels[i] = color(0);
    }
  }

  result.updatePixels();
  return result;
}

//Returns the grayScale of the Image that is passes in.
//But taking the avg of the r,g,b values
PImage grayScale(PImage org) {
  PImage result = createImage(org.width, org.height, RGB);
  result.loadPixels();

  for (int i = 0; i < org.pixels.length; i++) {
    color c = org.pixels[i];
    float r = red(c);
    float g = green(c);
    float b = blue(c);
    result.pixels[i] = color((r+g+b)/3);
  }

  result.updatePixels();
  return result;
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
