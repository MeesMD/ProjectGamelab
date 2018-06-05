import org.openkinect.freenect.*;
import org.openkinect.processing.*;
/********* VARIABLES *********/

int gameScreen = 0;
color circleColor = color(0);
int ballX, ballY;
int playerHandX, playerHandY;
int ballSize = 40;
int handSize = 20;

Kinect kinect2;

float minThresh = 480;
float maxThresh = 830;
PImage img;

/********* SETUP BLOCK *********/

void setup() {
  
 // size(1600, 900);
  
  /*
  ballX = width/2;
  ballY = height/2;
  */
  
  size(640, 480, P3D );
  
    kinect2 = new Kinect(this);
  kinect2.initDepth();
  img = createImage(kinect2.width, kinect2.height, RGB);
  
}


/********* DRAW BLOCK *********/

void draw() {
  /*
  if (gameScreen == 0) {
    initScreen();
  } else if (gameScreen == 1) {
    gameScreen();
  } else if (gameScreen == 2) {
    gameOverScreen();
  }
  */
  
  background(0);
  
  PImage img = kinect2.getDepthImage();
  //image(img,0,0);

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

 

/********* SCREEN CONTENTS *********/
/*
void initScreen() {
  background(0);
  textAlign(CENTER);
  text("Click to start", width/2, height/2);
}


void gameScreen() {
  background(255);
  drawHandCircle();
  drawBall();
  checkCollision();
}


void gameOverScreen() {
  background(0);
  textAlign(CENTER);
  fill(255);
  textSize(30);
  text("Game Over", height/2, width/2 - 20);
  textSize(15);
  text("Click to Restart", height/2, width/2 + 10);
}


/********* INPUTS *********/
/*
public void mousePressed() {
  if (gameScreen == 0) {
    startGame();
  }
    
  if (gameScreen == 2){
    restart();
  }
}


/********* OTHER FUNCTIONS *********/
/*
void startGame() {
  gameScreen = 1;
}

void restart(){
  gameScreen = 0;
}

void drawHandCircle(){
  playerHandX = mouseX;
  playerHandY = mouseY;
  fill(circleColor);
  rectMode(CENTER);
  ellipse(playerHandX, playerHandY, handSize, handSize);
}

void drawBall(){
  fill(circleColor);
  rectMode(CENTER);
  ellipse(ballX, ballY, ballSize, ballSize);
}

void checkCollision(){
  if(dist(ballX,ballY, playerHandX, playerHandY) <= 25){
   background(255,0,0); 
   //gameOverScreen();
  }
}
