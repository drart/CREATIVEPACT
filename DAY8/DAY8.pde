import ddf.minim.*;
import ddf.minim.analysis.*;
import processing.opengl.*;
import javax.media.opengl.*;

Minim minim;
AudioInput input;
BeatDetect detectorGadget;


void setup(){
  size(640,480,OPENGL);  

  minim = new Minim(this);
  input = minim.getLineIn(Minim.STEREO, 512);
  detectorGadget = new BeatDetect();
  
 stroke(255, 255, 150);
 fill(3,190,129);
}

void draw(){
  background(30);

  float audiolevel = input.mix.level();
  detectorGadget.detect(input.mix);
  
  translate (width/2, height/2,200);

  if(detectorGadget.isOnset())
  {
    for (int i = 0 ; i < 100; i++)
    {
      ellipse(0,0, 1000*audiolevel,1000*audiolevel);
      box(10,10,100);
      rotate(audiolevel);
      translate(log(audiolevel),0);
    }
  }
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
