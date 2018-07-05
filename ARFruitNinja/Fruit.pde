class Fruit {
  int fruitSize = 100;
  float spawnPoint = height + 50;
  float fruitX, fruitY;
  float gravity = 0.1;
  float ballSpdVert = 0;
  float shootSpd = random(10, 12);
  boolean drawFruit = true;
  boolean isHit;
  boolean isSliced = false;


  Fruit() 
  {
    fruitX = random(fruitSize/2, width - fruitSize/2);
    fruitY = spawnPoint;

    shootUp();
  }

  void update () 
  {
    show();
    applyGravity();
    destroy();
    
    if (fruitX < width/2) 
    {
      //fruitX +=2;
    }
  }

  void show() 
  {
    if (drawFruit) 
    {
      fill(255, 0, 0);
      rectMode(CENTER);
      ellipse(fruitX, fruitY, fruitSize, fruitSize);
    }
  }

  void applyGravity()
  {
    ballSpdVert += gravity;
    fruitY += ballSpdVert;
  }

  void shootUp() 
  {
    ballSpdVert -= shootSpd;
  }
  
  void destroy() 
  {
    if (fruitY > height + 101)
    {
      drawFruit = false;
      fruits.remove(0);
    }
  }
}
