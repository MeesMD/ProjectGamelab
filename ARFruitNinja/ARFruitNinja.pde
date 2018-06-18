import org.openkinect.freenect.*;
<<<<<<< HEAD
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;
=======
import org.openkinect.processing.*;

/********* VARIABLES *********/
>>>>>>> 5e31d0a2c904ef552e2b402c8da3fa8e3a9cd066

import KinectPV2.*;

Kinect kinect;

<<<<<<< HEAD
// Depth image
PImage depthImg;

// Which pixels do we care about?
// These thresholds can also be found with a variaty of methods
float minDepth =  996;
float maxDepth = 2493;

// What is the kinect's angle
float angle;
=======
PImage background;
color circleColor = color(0);
int gameScreen = 0;
int playerHandX, playerHandY;
int handSize = 20;
Kinect kinect2;
PImage img;
/********* SETUP BLOCK *********/

void setup() 
{ 
  frameRate(90);
  size(1280,800,P3D);
  //fullScreen();
  noStroke();
  smooth();
  
  background = loadImage("test.jpg");
  kinect2 = new Kinect(this);
  kinect2.initDepth();
  img = createImage(kinect2.width, kinect2.height, RGB);
  
} 
>>>>>>> 5e31d0a2c904ef552e2b402c8da3fa8e3a9cd066

void setup() {
  size(1280, 480);

<<<<<<< HEAD
  kinect = new Kinect(this);
  kinect.initDepth();
  angle = kinect.getTilt();
=======
void draw() 
{
  if (gameScreen == 0) 
  {
    initScreen();
  } 
  else if (gameScreen == 1) 
  {
    gameScreen();
  } 
  else if (gameScreen == 2) 
  {
    gameOverScreen();
  }
  PImage img = kinect2.getDepthImage();
  
  int skip = 20;
  for(int x = 0; x < img.width; x+=skip){
    for(int y = 0; y < img.height; y+=skip){
    int index = x + y * img.width;
    float b = brightness(img.pixels[index]);
    float z = map(b,0,255,250,-250);
    //float z = b;
    fill(255-b);
    pushMatrix();
    translate(x,y,z);
    rect(0,0,skip/2,skip/2 );
    popMatrix();
    }
  } 
}


/********* SCREEN CONTENTS *********/

void initScreen() 
{
  background(0);
  textAlign(CENTER);
  text("Click to start", width/2, height/2);
}


void gameScreen() 
{
  background(background);
  spawnNewFruit();
  timer.timeDec();
  drawHandCircle();
  
  fruit.update();
  
}
>>>>>>> 5e31d0a2c904ef552e2b402c8da3fa8e3a9cd066

  // Blank image
  depthImg = new PImage(kinect.width, kinect.height);
}

void draw() {
  // Draw the raw image
  image(kinect.getDepthImage(), 0, 0);

  // Calibration
   //minDepth = map(mouseX,0,width, 0, 4500);
  //maxDepth = map(mouseY,0,height, 0, 4500);

  // Threshold the depth image
  int[] rawDepth = kinect.getRawDepth();
  for (int i=0; i < rawDepth.length; i++) {
    if (rawDepth[i] >= minDepth && rawDepth[i] <= maxDepth) {
      depthImg.pixels[i] = color(255);
    } else {
      depthImg.pixels[i] = color(0);
    }
  }

  // Draw the thresholded image
  depthImg.updatePixels();
  image(depthImg, kinect.width, 0);

  //Comment for Calibration
  fill(0);
  text("TILT: " + angle, 10, 20);
  text("THRESHOLD: [" + minDepth + ", " + maxDepth + "]", 10, 36);

  //Calibration Text
  //fill(255);
  //textSize(32);
  //text(minDepth + " " + maxDepth, 10, 64);
}

// Adjust the angle and the depth threshold min and max
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      angle++;
    } else if (keyCode == DOWN) {
      angle--;
    }
    angle = constrain(angle, 0, 30);
    kinect.setTilt(angle);
  } else if (key == 'a') {
    minDepth = constrain(minDepth+10, 0, maxDepth);
  } else if (key == 's') {
    minDepth = constrain(minDepth-10, 0, maxDepth);
  } else if (key == 'z') {
    maxDepth = constrain(maxDepth+10, minDepth, 2047);
  } else if (key =='x') {
    maxDepth = constrain(maxDepth-10, minDepth, 2047);
  }
}
