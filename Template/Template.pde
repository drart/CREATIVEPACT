
import processing.opengl.*;
import javax.media.opengl.*;
int r;

void setup(){
  size(screen.width, screen.height, OPENGL);
  frameRate(24);
  
  hint(ENABLE_OPENGL_4X_SMOOTH);
  
  stroke(255, 255, 150);
  noFill();
}

void draw(){
  background(30);
  translate (width/2, height/2,mouseX);
  rotateY(r++);
  sphere(60);
 // sphereDetail(30+(int)random(0,10));
  println(frameRate);
}

void keyPressed()
{
   if (key == ' ')  
   {
      saveFrame();
   }
}
