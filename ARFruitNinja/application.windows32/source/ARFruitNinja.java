import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.opengl.*; 
import org.openkinect.freenect.*; 
import org.openkinect.processing.*; 
import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ARFruitNinja extends PApplet {





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

public void setup() 
{ 
  //size(1280, 800);
  
  

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

public void draw() 
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
public void keyPressed() {
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

public void checkCollision()
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

public void drawHandCircle()
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

public void spawnNewFruit()
{  
  timer.timeDec();

  if (timer.timeEnd == true)
  {
    fruit = new Fruit();
    fruits.add(fruit);
    fruitSpawn.trigger();
  }
} 
class Button {
  int circleX, circleY; 
  int circleSize = 93;  
  int circleColor, circleHighlight;
  boolean circleOver = false;
  int currentColor;
  int textColor;


  Button() 
  {
    circleX = width/2;
    circleY = height/2;
    ellipseMode(CENTER);

    circleColor = color(255);
    circleHighlight = color(102, 205, 44);
    textSize(30);
    fill(255);
  }
  public void position(int x, int y)
  {
    circleX = x;
    circleY = y;
  }
  public void Text(String text)
  {
    fill(255);
    text(text, circleX+circleSize/2 + 20, circleY);
  }
  public void show() 

  { 
    if (circleOver) 
    {
      fill(102, 205, 44);

      {

        if (circleOver) 
        {
          fill(circleHighlight);
        } else 
        {
          fill(255);
        }
      }
    }
    //stroke(0);
    ellipse(circleX, circleY, circleSize, circleSize);
  }

  public void update() 
  {
    if (overCircle(circleX, circleY, circleSize)) 
    {
      circleOver = true;
    } else 
    {
      circleOver = false;
    }
    show();
  }

  public boolean overCircle(int x, int y, int diameter) 
  {
    float disX = x - mouseX;
    float disY = y - mouseY;
    if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) 
    {
      return true;
    } else 
    {
      return false;
    }
  }
}
class Fruit {
  Timer timer = new Timer();

  int fruitSize = 100;
  float fruitX, fruitY;
  float gravity = 0.1f;
  float ballSpdVert = 0;
  float shootSpd = random(12, 14);
  float xSpeed = random(1,4);
  boolean drawFruit = true;
  boolean isSliced = false;
  boolean isActive = true;
  boolean spawnedLeft;



  Fruit() 
  {
    fruitX = random(fruitSize/2+800, width - fruitSize/2-200); // spawn x 800 - 1720
    fruitY = height + 50;
    if (fruitX < 1240)
    {
      spawnedLeft = true;
    } else
    {
      spawnedLeft = false;
    }
    
    shootUp();
  }

  public void update () 
  {
    if(spawnedLeft)
    {
      fruitX += xSpeed;
    }
    else
    {
      fruitX -= xSpeed;
    } 
    show();
    applyGravity();
    slicedManager();
    destroy();
  }

  public void show() 
  {
    if (drawFruit) 
    {
      image(apple, fruitX, fruitY, fruitSize, fruitSize);
    }
  }

  public void slicedManager()
  {
    if (isActive == false)
    {
      //apple is sliced
    } else
    {
      if (fruitY > height + 100)
      {
        health.decHealth();
        missedFruit.trigger();

        timer.interval -= 500;
        timer.interval2 -= 500;
      }
    }
  }

  public void applyGravity()
  {
    ballSpdVert += gravity;
    fruitY += ballSpdVert;
  }

  public void shootUp() 
  {
    ballSpdVert -= shootSpd;
  }

  public void destroy() 
  {
    if (fruitY > height + 101)
    {
      drawFruit = false;
      fruits.remove(0);
    }
  }
}
class Health {
  int healthAmount = 5;
  
  public void show()
  {
   fill(255);
   textSize(60); 
   text("Health = "+healthAmount, 50, 150);
  }

  public void decHealth()
  {
    healthAmount--;
  }
}
class KinectTracker {

  // Depth threshold
  int threshold = 745;

  // Raw location
  PVector loc;

  // Interpolated location
  PVector lerpedLoc;

  // Depth data
  int[] depth;
  
  // What we'll show the user
  PImage display;
   
  KinectTracker() {
    // This is an awkard use of a global variable here
    // But doing it this way for simplicity
    kinect.initDepth();
    kinect.enableMirror(true);
    // Make a blank image
    display = createImage(kinect.width, kinect.height, RGB);
    // Set up the vectors
    loc = new PVector(0, 0);
    lerpedLoc = new PVector(0, 0);
  }

  public void track() {
    // Get the raw depth as array of integers
    depth = kinect.getRawDepth();

    // Being overly cautious here
    if (depth == null) return;

    float sumX = 0;
    float sumY = 0;
    float count = 0;

    for (int x = 0; x < kinect.width; x++) {
      for (int y = 0; y < kinect.height; y++) {
        
        int offset =  x + y*kinect.width;
        // Grabbing the raw depth
        int rawDepth = depth[offset];

        // Testing against threshold
        if (rawDepth < threshold) {
          sumX += x;
          sumY += y;
          count++;
        }
      }
    }
    // As long as we found something
    if (count != 0) {
      if(fullscreen)
      {
        loc = new PVector(sumX/count * (displayWidth/640), sumY/count*(displayHeight/360));
      }
      else
      {
        loc = new PVector(sumX/count * (Swidth/640), sumY/count*(Sheight/360));
      }
    }

    // Interpolating the location, doing it arbitrarily for now
    lerpedLoc.x = PApplet.lerp(lerpedLoc.x, loc.x, 0.3f);
    lerpedLoc.y = PApplet.lerp(lerpedLoc.y, loc.y, 0.3f);
  }

  public PVector getLerpedPos() {
    return lerpedLoc;
  }

  public PVector getPos() {
    return loc;
  }

  public void display() {
    PImage img = kinect.getDepthImage();

    // Being overly cautious here
    if (depth == null || img == null) return;

    // Going to rewrite the depth image to show which pixels are in threshold
    // A lot of this is redundant, but this is just for demonstration purposes
    display.loadPixels();
    for (int x = 0; x < kinect.width; x++) {
      for (int y = 0; y < kinect.height; y++) {

        int offset = x + y * kinect.width;
        // Raw depth
        int rawDepth = depth[offset];
        int pix = x + y * display.width;
        if (rawDepth < threshold) {
          // A red color instead
          display.pixels[pix] = color(150, 50, 50);
        } else {
          display.pixels[pix] = img.pixels[offset];
        }
      }
    }
    display.updatePixels();

    // Draw the image
    image(display, 0, 0);
  }

  public int getThreshold() {
    return threshold;
  }

  public void setThreshold(int t) {
    threshold =  t;
  }
}
class Score {
  int score = 0;
  
  public void show()
  {
   fill(255);
   textSize(60); 
   text("Score = "+score, 50, 80);
  }

  public void addScore()
  {
    score++;
  }
}
class Timer { 
 float lasttimecheck = millis();
 boolean timeEnd = false;
 float begintimer = 3000;
 float interval = 0;
 float interval2 = 0;
 
 
 public void timeDec() 
 {
   
   if(millis() > lasttimecheck + begintimer) 
   {
     lasttimecheck = millis();
     timeEnd = true;
      
     if(interval >= 3000 || interval2 >= 4000)
     {
       interval = 3000;
       interval2 = 4000;
     }
  
     begintimer = random(4000-interval,5000-interval2);
   }
   else 
   {
     timeEnd = false;
   }
 }
}
  public void settings() {  fullScreen();  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#675EF5", "--stop-color=#711010", "ARFruitNinja" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
