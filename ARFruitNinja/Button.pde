class Button {
  int circleX, circleY; 
  int circleSize = 93;  
  color circleColor, circleHighlight;
  boolean circleOver = false;
  color currentColor;
  
  
  Button()
  {
    circleX = width/2;
    circleY = height/2;
    ellipseMode(CENTER);
    
    circleColor = color(255);
    circleHighlight = color(102,205,44);
  }
  
  void show() 
  { 
    if (circleOver) 
    {
      fill(102,205,44);
    } 
    else 
    {
      fill(255);
    }
    
    //stroke(0);
    
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
