class Fruit {
  Timer timer = new Timer();

  int fruitSize = 100;
  float fruitX, fruitY;
  float gravity = 0.1;
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

  void update () 
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

  void show() 
  {
    if (drawFruit) 
    {
      image(apple, fruitX, fruitY, fruitSize, fruitSize);
    }
  }

  void slicedManager()
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
