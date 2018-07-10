class Particle { // class of a particle object
  
  int maxrandvel = 5; // maximum random velocity
  PVector loc; // location initializing
  PVector vel; // velocity initializing
  PVector gravity; // initializes gravity vector


  Particle (float x,float y) 
  {  // gives loc and vel original values  
    loc = new PVector (x, y);

    vel = new PVector (random(-5,5),random(-5,5));
    gravity = new PVector (0,0.1);
    ellipse(2,2,5,5);
  }
  
  void simulate() 
  { 
    vel.add(gravity);
    loc.add(vel);
  }

  void show() 
  { // hurr dur durrr... display a particle
    fill(255);  // point color
    line(loc.x, loc.y, loc.x-vel.x, loc.y-vel.y); // line consiting of (xlocation, ylocation to xlocation-xvelocity, ylocation-yvelocity)
  }
}
