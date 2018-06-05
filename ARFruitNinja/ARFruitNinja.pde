/********* VARIABLES *********/

Fruit fruit = new Fruit();
Timer timer = new Timer();

Fruit[] fruitArray = new Fruit[0];

PImage background;
color circleColor = color(0);
int gameScreen = 0;
int playerHandX, playerHandY;
int handSize = 20;

/********* SETUP BLOCK *********/

void setup() 
{ 
  frameRate(90);
  size(1280,800);
  //fullScreen();
  noStroke();
  smooth();
  
  background = loadImage("test.jpg");
  
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
