class Score {
  int score = 0;
  
  void show()
  {
   fill(255);
   textSize(40); 
   text("Score = "+score, 50, 50);
  }

  void addScore()
  {
    score++;
  }
}
