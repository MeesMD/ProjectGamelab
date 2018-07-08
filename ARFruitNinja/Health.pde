class Health {
  int healthAmount = 5;
  
  void show()
  {
   fill(255);
   textSize(60); 
   text("Health = "+healthAmount, 50, 150);
  }

  void decHealth()
  {
    //healthAmount--;
  }
}
