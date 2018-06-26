class Button {
  int circleX, circleY; 
  int circleSize = 93;  
  color circleColor, circleHighlight, baseColor;
  boolean circleOver = false;
  color currentColor;
  
  
  Button()
  {
    circleX = width/2;
    circleY = height/2;
    ellipseMode(CENTER);
    
    circleColor = color(255);
    baseColor = color(102);
    circleHighlight = color(102,205,44);
    currentColor = baseColor;
  }
  
  void show() 
  {
    background(currentColor);
    
    if (circleOver) 
    {
      fill(circleHighlight);
    } 
    else 
    {
      fill(circleColor);
    }
    
    stroke(0);
    ellipse(circleX, circleY, circleSize, circleSize);
  }
  
  void update() 
  {
    if (overCircle(circleX, circleY, circleSize)) 
    {
      circleOver = true;
    }
    else 
    {
      circleOver = false;
    }
    
    show();
  }
  
  boolean overCircle(int x, int y, int diameter) 
  {
    float disX = x - mouseX;
    float disY = y - mouseY;
    if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) 
    {
      return true;
    } 
    else 
    {
      return false;
    }
  } 
}
