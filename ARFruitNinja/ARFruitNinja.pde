import processing.opengl.*;
import org.openkinect.freenect.*;
import org.openkinect.processing.*;
import ddf.minim.*;
/********* VARIABLES *********/

Kinect kinect;
KinectTracker tracker;

Minim minim;
AudioSample fruitSpawn;
AudioSample startFlute;
AudioSample fruitSlice;
AudioSample missedFruit;
AudioPlayer mainMenu;
AudioPlayer inGame;
AudioPlayer gameOver;

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
PImage apple;
PImage logo;
PFont titleFont;
int gameScreen = 0;
float playerHandX, playerHandY;
int handSize = 20;
int Swidth = 1280; 
int Sheight = 800;
boolean fullscreen = true;

/********* SETUP BLOCK *********/

void setup() 
{ 
  //size(1280, 800);
  size(1920, 1080);
  //fullScreen();
  smooth();

  fruits = new ArrayList<Fruit>();
  
  minim = new Minim(this);
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  
  missedFruit = minim.loadSample("missedFruit.wav");
  fruitSpawn = minim.loadSample("fruitSpawn.wav");
  startFlute = minim.loadSample("startFlute.wav");
  fruitSlice = minim.loadSample("fruitSlice.wav");
  mainMenu = minim.loadFile("mainMenu.wav");
  inGame = minim.loadFile("inGame.wav");
  gameOver = minim.loadFile("gameOver.wav");
  
  titleFont = loadFont("KristenITC-Regular-48.vlw");
  apple = loadImage("apple.png");
  background = loadImage("background.jpeg");
  logo = loadImage("logo.png");
} 

/********* DRAW BLOCK *********/

void draw() 
{
  tracker.track();
  textFont(titleFont, 24);
  PVector v1 = tracker.getPos();
  fill(0, 0, 255);
  noStroke();
  ellipse(v1.x, v1.y, 20, 20);

  if (gameScreen == 0) 
  {     
    mainMenu.play();
    mainMenu.setGain(-10);
    
    background(background);
    
    image(logo,500,0);
    logo.resize(1000,650);
    
    button = new Button();
    button.position(width/2-50, height/2+120);
    button.Text("Start Game");
    button.update();

    quitButton = new Button();
    quitButton.position(width/2-50, height/2+240);
    quitButton.Text("Quit");
    quitButton.update();
  } 
  
  else if (gameScreen == 1) 
  { 
    inGame.play();
    mainMenu.pause();
    mainMenu.rewind();
    gameOver.rewind();
    
    background(background);
    tracker.display();//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
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
      health.healthAmount = 5;
    }
  } 
  
  else if (gameScreen == 2)
  {
    gameOver.play();
    gameOver.setGain(-8);
    inGame.pause();
    inGame.rewind();
    background(background);
  
    restart = new Button();
    restart.position(width/2, height/2);
    restart.Text("Restart");
    restart.update();
  
    quitGame = new Button();
    quitGame.position(width/2, height/2+120);
    quitGame.Text("Quit");
    quitGame.update();
 
  
    textAlign(LEFT);
    fill(255);
    textSize(30);
    text("Game Over", width/2, height/4);
    textSize(15);
    
    for (int i = fruits.size() - 1; i >= 0; i--) {
        Fruit fruit = fruits.get(i);
        fruit.drawFruit = false;
        fruits.remove(i);
      }
      score.score = 0;
      timer.interval = 0;
      timer.interval = 0;
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
        startFlute.trigger();
        startFlute.setGain(-3);
        gameScreen = 1;
      }
    }
    else if (quitButton.circleOver)
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
    else if (restart.circleOver)
    {
      gameScreen = 0;
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
        timer.interval += 500;
        timer.interval2 += 500;

        score.addScore();
        fruit.isSliced = true;
        fruit.isActive = false;
        fruitSlice.trigger();
        
        fruit.drawFruit = false;
        
      }
    } 
    else 
    {
      fruit.isSliced = false;
    }
  }
}

void drawHandCircle()
{
  //GEBRUIK DIT ALS KINECT VOOR HAND
  PVector v1 = tracker.getPos();
  playerHandX = v1.x;
  playerHandY =  v1.y;

  //playerHandX = mouseX;
  //playerHandY = mouseY;
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
    fruitSpawn.trigger();
  }
} 
