PImage photo;
void settings() {
  photo = loadImage("jello.jpg");
  size(3 * photo.width, 2 * photo.height + max(photo.width, photo.height));

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

 gallery();
  //photo.updatePixels();
  //image(photo, 0, 0);
  //image(brighten(photo, 2), width/2, 0); // calls brightn
  //image(posterize(photo, 10), width/2, 0); // calls the Poster filter
  //image(negative(photo),width/2, 0); // calls negative
  //image(yellowScale(photo), width/2, 0);
  //image(redAndWhite(photo, 175), width/2, 0);
  //image(whiteAndBlack(photo), width/2, 0); // calls white and black filter
  //image(grayScale(photo),width/2, 0); // calls gray scale
  //image(negative(photo),width/2, 0); // calls negative
  //image(rotate180(photo),width/2, 0); // calls rotate180
  //image(dark(photo),width/2, 0); // calls darken filter
}

//Use mouse location to set value in a or many filters
void mouseMoved(){
  float factorBright = map(mouseX, 0, width, 0, 10);
  float factorPost = map(mouseX, 0, width, 1, 255);
  float factorRed = map(mouseX, 0, width, 0, 255);
  image(brighten(photo, factorBright), width/3, 0);
  image(posterize(photo, (int)factorPost), 0, photo.height);
  image(redAndWhite(photo, (int)factorRed), photo.width*2, photo.height);
}

void gallery(){
  photo.updatePixels();
  image(photo, 0, 0);
  image(negative(photo), photo.width*2, 0);
  image(yellowScale(photo), photo.width,  photo.height);
  image(rotateRight(photo), 0,  photo.height*2);
  image(shrink(photo), photo.width,  photo.height*2);
  //image(surprise(photo), photo.width*2,  photo.height*2);
}

//Rotates the image 90 degrees to the right
PImage rotateRight(PImage org) {
  PImage result = createImage(org.height, org.width, RGB);
  result.loadPixels();

  for (int x = 0; x < result.width; x++) {
   for (int y = 0; y < result.height; y++) {
      result.set(x, y, org.get(y, org.height-1 - x));
   }
}
  result.updatePixels();
  return result;
}


//shrink org by 1/2. IE height/2 and width/2;
PImage shrink(PImage org) {
  PImage result = createImage(org.width/2, org.height/2, RGB);
  result.loadPixels();
  int row = 0;
  int col = 0;
  for (int i = 0; i < result.pixels.length; i++) {
    row = i % result.height;
    col = i / result.width;
    result.pixels[i] = org.pixels[(row+col)];
}

  result.updatePixels();
  return result;
}


PImage redAndWhite(PImage org, int threshold) {
  PImage result = createImage(org.width, org.height, RGB);
  result.loadPixels();

  for (int i = 0; i < org.pixels.length; i++) { // might be right as is.
    color c = org.pixels[i];
    float r = red(c);
    float g = green(c);
    float b = blue(c);
    if ((r+g+b/3) >= threshold) { // bigger than or equal to threshold = white
      result.pixels[i] = color(255);
    } else { // less than threshold = red
      result.pixels[i] = color(255,0,0);
    }
  }

  result.updatePixels();
  return result;
}

PImage yellowScale(PImage org) {
  PImage result = createImage(org.width, org.height, RGB);
  result.loadPixels();

  for (int i = 0; i < org.pixels.length; i++) {
    color c = org.pixels[i];
    float r = red(c);
    float g = green(c);
    float b = blue(c);
    float avg = (r+g+b)/3;
    result.pixels[i] = color(avg, avg, 0);
  }

  result.updatePixels();
  return result;
}


PImage brighten(PImage org, float factor) {
  PImage result = createImage(org.width, org.height, RGB);
  result.loadPixels();

  for (int i = 0; i < org.pixels.length; i++) {
    color c = org.pixels[i];
    float r = red(c);
    float g = green(c);
    float b = blue(c);
    result.pixels[i] = color(r*factor, g*factor, b*factor);
  }

  result.updatePixels();
  return result;
}


PImage posterize(PImage org, int multiple) {
  PImage result = createImage(org.width, org.height, RGB);
  result.loadPixels();

  for (int i = 0; i < org.pixels.length; i++) { // might be right as is.
    color c = org.pixels[i];
    float r = red(c);
    float g = green(c);
    float b = blue(c);
    
    int newR = (int)(r / multiple) * multiple;
    int newG = (int)(g / multiple) * multiple;    
    int newB = (int)(b / multiple) * multiple;    
    
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
    result.pixels[i] = color(abs(255 - r), abs(255 - g), abs(255 - b));
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

void draw(){ // literally here just so the mouse move works
}
