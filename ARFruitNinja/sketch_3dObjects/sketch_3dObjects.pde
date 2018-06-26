//import processing.opengl.*;

//PShape Apple;
PShape Appel;
float i;

public void setup() {
  size(640, 360, P3D);

  //Apple = loadShape("Objects/Apple.obj");
  Appel = loadShape("Objects/Appel.obj");
  //Apple.setFill(color(200, 0, 0));
  //Appel.setFill(color(200, 0, 0));
}

public void draw() {
  background(0xffffffff);
  lights();
  translate(width/2, height/2);
  Appel.rotateY(0.02);
  Appel.rotateX(0.02);
  Appel.rotateZ(0.05);
  //shape(Apple, 0, 0);
  shape(Appel, 10, 10);
 }
