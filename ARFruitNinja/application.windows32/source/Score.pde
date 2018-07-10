class Score {
  int score = 0;
  
  void show()
  {
   fill(255);
   textSize(60); 
   text("Score = "+score, 50, 80);
  }

  void addScore()
  {
    score++;
  }
}
