import ddf.minim.*;
import processing.opengl.*;
import javax.media.opengl.*;

Minim minim;
AudioInput input;

float r;
float inc;

void setup(){
  size(screen.width, screen.height, OPENGL);
  
  hint(ENABLE_OPENGL_4X_SMOOTH);
  
  
  minim = new Minim(this);
  input = minim.getLineIn(Minim.STEREO, 512);
  
  stroke(255, 255, 150);
  noFill();
}

void draw(){
  background(30);
  
  float audiolevel = input.mix.level();
  
  println(audiolevel);
  translate (width/2, height/2,mouseX);
  
  if (audiolevel > 0.01)
    inc++;
  
  r = r + inc;
  
  rotateY(r);
  sphere(200 + audiolevel*1000);
  
  inc = inc * 0.85;
}

void keyPressed()
{
   if (key == ' ')  
   {
      saveFrame();
   }
}

void stop()
{
  input.close();
  minim.stop();
  super.stop();
}
