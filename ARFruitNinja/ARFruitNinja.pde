import processing.opengl.*;
import org.openkinect.freenect.*;
import org.openkinect.processing.*;
/********* VARIABLES *********/

Kinect kinect;
KinectTracker tracker;

Fruit fruit;
Button button;
Button quitButton;
Button restart;
Button quitGame;
Score score = new Score();
Health health = new Health();
Timer timer = new Timer();

ArrayList<Fruit> fruits;
PImage background;
PFont titleFont;
int gameScreen = 2;
float playerHandX, playerHandY;
int handSize = 20;
int Swidth = 1280; 
int Sheight = 800;
boolean fullscreen = true;

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

  kinect = new Kinect(this);
  tracker = new KinectTracker();
} 

/********* DRAW BLOCK *********/

void draw() 
{
  fill(0);
  textFont(titleFont, 24);
  text("Fruit Ninja", width/2, height/4);


  tracker.track();



  PVector v1 = tracker.getPos();
  fill(0, 0, 255);
  noStroke();
  ellipse(v1.x, v1.y, 20, 20);

  // Display some info
  int t = tracker.getThreshold();
  fill(0);

  textSize(20);
  text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " + 
    "UP increase threshold, DOWN decrease threshold", 10, 500);


  if (gameScreen == 0) 
  {
    background(background);
    button = new Button();
    button.position(width/2, height/2);
    button.Text("Start Game");
    button.update();

    textFont(titleFont, 24);

    quitButton = new Button();
    quitButton.position(width/2, height/2+120);
    quitButton.Text("Quit MOAN");
    quitButton.update();

    textFont(titleFont, 35);
    fill(255);

    text("Fruit Ninja", width/2, height/4);
  } else if (gameScreen == 1) 
  {
    background(background);
    //tracker.display();//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    tracker.track();
    spawnNewFruit();
    drawHandCircle();

    if (fruit != null) {
      checkCollision();
      score.show();
      health.show();

      for (int i = fruits.size() - 1; i >= 0; i--) {
        Fruit fruit = fruits.get(i);
        fruit.update();
      }
    }

    if (health.healthAmount == 0)
    {
      gameScreen = 2;
      println("ded");
    }
  } else if (gameScreen == 2)

{
  background(background);

  restart = new Button();
  restart.position(width/2, height/2);
  restart.Text("Restart");
  restart.update();

  quitGame = new Button();
  quitGame.position(width/2, height/2+120);
  quitGame.Text("Quit MOAN");
  quitGame.update();

  //quitButton = new Button();
  //quitButton.position(width/2, height/2 +120);
  //quitButton.Text("Quit");
  //quitButton.update();

  textAlign(LEFT);
  fill(255);
  textSize(30);
  text("Game Over", width/2, height/4);
  textSize(15);
}
}


/********* INPUTS *********/

public void mousePressed() 
{
  if (gameScreen  == 0)
  {
    if (button.circleOver) 
    {
      if (gameScreen == 0)
      {
        gameScreen = 1;
      }
    }
    if (quitButton.circleOver)
    {
      exit();
    }
  }
  if (gameScreen == 2)
  {
    if (quitGame.circleOver)
    {
      exit();
    }
    if (restart.circleOver)
    {
      gameScreen = 1;
    }
  }

  if (gameScreen == 1)
  {
    if (health.healthAmount == 0)
    {
      gameScreen = 2;
      println("ded");
    }
  }
}


/********* OTHER FUNCTIONS *********/
void keyPressed() {
  int t = tracker.getThreshold();
  if (key == CODED) {
    if (keyCode == UP) {
      t+=5;
      tracker.setThreshold(t);
    } else if (keyCode == DOWN) {
      t-=5;
      tracker.setThreshold(t);
    }
  }
}

void checkCollision()
{
  for (int i = fruits.size() - 1; i >= 0; i--) {
    Fruit fruit = fruits.get(i);

    if (dist(fruit.fruitX, fruit.fruitY, playerHandX, playerHandY) < fruit.fruitSize)
    {
      if (fruit.isSliced == false && fruit.isActive)
      {
        score.addScore();
        fruit.isSliced = true;
        fruit.isActive = false;
      }
    } else 
    {
      fruit.isSliced = false;
    }
  }
}

void drawHandCircle()
{
  //GEBRUIK DIT ALS KINECT VOOR HAND
  //PVector v1 = tracker.getPos();
  //playerHandX = v1.x;
  //playerHandY =  v1.y;

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
