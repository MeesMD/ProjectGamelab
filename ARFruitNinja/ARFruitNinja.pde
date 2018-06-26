import processing.opengl.*;
/********* VARIABLES *********/

Fruit fruit;
Button button;
Score score;
Timer timer = new Timer();

ArrayList<Fruit> fruits;
PShape appleShape;
PImage background;
PFont titleFont;
int gameScreen = 0;
int playerHandX, playerHandY;
int handSize = 20;
/********* SETUP BLOCK *********/

void setup() 
{ 
  frameRate(90);
  size(1280, 800, P3D);
  //fullScreen();
  smooth();

  appleShape = loadShape("Objects/Appel.obj");
  background = loadImage("test.jpg");
  titleFont = loadFont("KristenITC-Regular-48.vlw");

  fruits = new ArrayList<Fruit>();
} 

/********* DRAW BLOCK *********/

void draw() 
{
  lights();

  if (gameScreen == 0) 
  {
    initScreen();
    textFont(titleFont, 24);
    text("Fruit Ninja", width/2, height/4);
  } else if (gameScreen == 1) 
  {
    gameScreen();
  } else if (gameScreen == 2) 
  {
    gameOverScreen();
  }
}


/********* SCREEN CONTENTS *********/

void initScreen() 
{ 
  button = new Button();
  button.update();
}


void gameScreen() 
{
  background(background);
  score.checkCollision();
  spawnNewFruit();
  drawHandCircle();

  if (fruit != null) {
    for (int i = fruits.size() - 1; i >= 0; i--) {
      Fruit fruit = fruits.get(i);
      fruit.update();
    }
  }
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
  if (button.circleOver) 
  {
    if (gameScreen == 0)
    {
      startGame();
    }
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
  fill(255, 0, 255);
  rectMode(CENTER);
  ellipse(playerHandX, playerHandY, handSize, handSize);
}

void spawnNewFruit()
{  
  timer.timeDec();

  if (timer.timeEnd == true)
  {
    fruit = new Fruit(appleShape);
    fruits.add(fruit);
  }
}     
