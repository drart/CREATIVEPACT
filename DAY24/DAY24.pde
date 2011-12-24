import javax.media.opengl.*;
import processing.opengl.*;


int jf;

void setup(){
  size(720,480, OPENGL);
  hint(ENABLE_OPENGL_4X_SMOOTH);
  fill(240,30);
}


void draw(){

  background(0);
  jf = int(random(10,50));
  
  beginShape(TRIANGLE_FAN);
  for (int i = 0; i < jf; i++)
    vertex( random(0,width), random(0, height), random(0,100));
  endShape(); 

}

void mouseClicked(){
  saveFrame();
}
