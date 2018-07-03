class Fruit {
  Score score = new Score();
  int fruitSize = 100;
  float fruitX, fruitY;
  float gravity = 0.1;
  float ballSpdVert = 0;
  float shootSpd = random(10, 12);
  boolean drawFruit = true;
  boolean isHit;
  boolean isSliced;


  Fruit() 
  {
    fruitX = random(fruitSize/2, width - fruitSize/2);
    fruitY = height;

    shootUp();
  }

  void update () 
  {
    applyGravity();
    destroy();

    show();
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

    if (fruitX > width/2) 
    {
      //change angle
    }
  }

  void destroy() 
  {
    if (fruitY > height + 200)
    {
      drawFruit = false;
      fruits.remove(0);
    }
  }

  void slicedManager()
  {
    fill(0);
    println("issliced");
  }
}
