class Score {
  Fruit fruit;
  int score = 0;
  boolean ishit = false;

  void AddScore()
  {
    if (fruit.isHit)
    {
      if (ishit==false)
      {
        score ++;
        println(score);
      }
      ishit = true;
    } else
    {
      ishit = false;
    }
  }
}
