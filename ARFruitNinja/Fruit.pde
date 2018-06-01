class Fruit {
  int fruitSize = 100;
  
  float fruitX, fruitY;
  float gravity = 0.1;
  float ballSpdVert = 0;
  float shootSpd = random(8, 12);
  boolean drawFruit = true;

  Fruit() 
  {
    fruitX = random(fruitSize/2, width - fruitSize/2);
    fruitY = height;
    
    shootUp();
  }
  
  void update () {
    applyGravity();
    destroy();
    draw();
  }
  
  
  void draw() 
  {
    if(drawFruit == true) 
    {
      fill(circleColor);
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
    if(fruitY > height + 200)
    {
      drawFruit = false;
    }
  }
}
