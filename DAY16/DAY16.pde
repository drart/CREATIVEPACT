import javax.media.opengl.*;
import processing.opengl.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;
Oscil o;
Damp env;

float a;

void setup()
{
  size(720,480,OPENGL); 
  hint(ENABLE_OPENGL_4X_SMOOTH);  
  
  minim = new Minim(this); 
  out = minim.getLineOut(Minim.STEREO);
  env = new Damp();
  o = new Oscil(50,1.0, Waves.SINE);
  o.patch(env).patch(out);
  
  fill(0);
  noStroke();
  rect(0,0,width,height);
}

void draw()
{
  noStroke();
  fill(0,6);
  rect(0,0,width,height);
}

void mouseClicked()
{

   fill(255);
   rect(0,0,width,height);
   o.setPhase(0);
   env.activate();
}
