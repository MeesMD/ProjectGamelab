class Fruit {
  Score score;
  PShape Appel;
  int fruitSize = 100;
  float fruitX, fruitY;
  float gravity = 0.1;
  float ballSpdVert = 0;
  float shootSpd = random(10, 12);
  boolean drawFruit = true;


  Fruit(PShape shape) 
  {
    fruitX = random(fruitSize/2, width - fruitSize/2);
    fruitY = height;
    Appel = shape;

    shootUp();
  }

  void update () 
  {
    show();
    applyGravity();
    destroy();
  }

  void show() 
  {
    if (drawFruit == true) 
    {
      shape(Appel, fruitX, fruitY);
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
