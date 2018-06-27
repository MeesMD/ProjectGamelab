class Fruit {
  Score score;
  int fruitSize = 100;
  float fruitX, fruitY;
  float gravity = 0.1;
  float ballSpdVert = 0;
  float shootSpd = random(10, 12);
  boolean drawFruit = true;
  boolean isHit = false;


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
    checkCollision();
    show();
  }

  void show() 
  {
    if (drawFruit == true) 
    {
      fill(0);
      rectMode(CENTER);
      ellipse(fruitX, fruitY, fruitSize, fruitSize);
    }
  }

  void checkCollision()
  {
    if (dist(fruitX, fruitY, playerHandX, playerHandY) <= 50)
    {
      background(255, 0, 0);
      isHit = true;
      println(isHit);
    }
    isHit = false;
  }

  void applyGravity()
  {
    ballSpdVert += gravity;
    fruitY += ballSpdVert;
  }

  void shootUp() 
  {
    ballSpdVert -= shootSpd;

    if (fruitX > width/2) {
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
}
