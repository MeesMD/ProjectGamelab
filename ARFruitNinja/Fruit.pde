class Fruit {
  int fruitSize = 100;
  float fruitX, fruitY;
  float gravity = 0.1;
  float ballSpdVert = 0;
  float shootSpd = random(12, 14);
  boolean drawFruit = true;
  boolean isSliced = false;
  boolean isActive = true;

  Fruit() 
  {
    fruitX = random(fruitSize/2, width - fruitSize/2);
    fruitY = 850;

    shootUp();
  }

  void update () 
  {
    show();
    applyGravity();
    slicedManager();
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

  void slicedManager()
  {
    if (isActive == false)
    {
      //apple is sliced
    } 
    else
    {
      if (fruitY > height + 100)
      {
        health.decHealth();
      }
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
