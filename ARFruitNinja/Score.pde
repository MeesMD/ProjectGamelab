class Score {
  Fruit fruit;
  int score = 0;
  boolean isHit = false;

  void checkCollision()
  {
    if (dist(fruit.fruitX, fruit.fruitY, playerHandX, playerHandY) <= 50)
    {
      if (isHit==false)
      {
        score ++;
        //println(score);
      }
      
      background(255, 0, 0);
      isHit = true;
    }

    else
    {
      isHit = false;
    }
  }
}
