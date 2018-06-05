import org.openkinect.freenect.*;
import org.openkinect.processing.*;

/********* VARIABLES *********/

Fruit fruit = new Fruit();
Timer timer = new Timer();

Fruit[] fruitArray = new Fruit[0];

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

/********* DRAW BLOCK *********/

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


void gameOverScreen() 
{
  background(0);
  textAlign(CENTER);
  fill(255);
  textSize(30);
  text("Game Over", height/2, width/2 - 20);
  textSize(15);
  text("Click to Restart", height/2, width/2 + 10);
}


/********* INPUTS *********/

public void mousePressed() 
{
  if (gameScreen == 0) 
  {
    startGame();
  }
    
  if (gameScreen == 2)
  {
    gameOver();
  }
}


/********* OTHER FUNCTIONS *********/

void startGame() 
{
  gameScreen = 1;
}

void gameOver()
{
  gameScreen = 2;
}

void drawHandCircle()
{
  playerHandX = mouseX;
  playerHandY = mouseY;
  fill(255,0,255);
  rectMode(CENTER);
  ellipse(playerHandX, playerHandY, handSize, handSize);
}

void spawnNewFruit()
{
   timer.timeDec();
   
   if(timer.timeEnd == true)
   {
     println("YOINK"); 
     fruit = new Fruit();
   }
}     
