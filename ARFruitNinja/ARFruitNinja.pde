import processing.opengl.*;
/********* VARIABLES *********/

Fruit fruit;
Button button;
Score score = new Score();
Timer timer = new Timer();

ArrayList<Fruit> fruits;
PImage background;
PFont titleFont;
int gameScreen = 0;
int playerHandX, playerHandY;
int handSize = 20;
boolean isHit;

/********* SETUP BLOCK *********/

void setup() 
{ 
  frameRate(90);
  size(1280, 800);
  //fullScreen();
  smooth();

  background = loadImage("test.jpg");
  titleFont = loadFont("KristenITC-Regular-48.vlw");

  fruits = new ArrayList<Fruit>();
} 

/********* DRAW BLOCK *********/

void draw() 
{
  if (gameScreen == 0) 
  {
    button = new Button();
    button.update();

    textFont(titleFont, 24);
    text("Fruit Ninja", width/2, height/4);
  } 
  
  else if (gameScreen == 1) 
  {
    background(background);
    spawnNewFruit();
    drawHandCircle();
    checkCollision();
    score.show();

    if (fruit != null) {
      for (int i = fruits.size() - 1; i >= 0; i--) {
        Fruit fruit = fruits.get(i);
        fruit.update();
      }
    }
  } 
  
  else if (gameScreen == 2) 
  {
    background(0);
    textAlign(CENTER);
    fill(255);
    textSize(30);
    text("Game Over", height/2, width/2 - 20);
    textSize(15);
    text("Click to Restart", height/2, width/2 + 10);
  }
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

void checkCollision()
{
  if (dist(fruit.fruitX, fruit.fruitY, playerHandX, playerHandY) <= fruit.fruitSize)
  {
    if (isHit==false)
    {
      score.addScore();
      fruit.slicedManager();
    }
    isHit = true;
  } else
  {
    isHit = false;
  }
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
    fruit = new Fruit();
    fruits.add(fruit);
  }
}     
