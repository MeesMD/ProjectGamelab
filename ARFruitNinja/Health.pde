class Health {
  int health = 5;
  
  void show()
  {
   fill(255);
   textSize(40); 
   text("Health = "+health, 50, 100);
  }

  void decHealth()
  {
    health--;
    println(health);
  }
}
