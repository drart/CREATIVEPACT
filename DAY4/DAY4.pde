/**
* Adam R. Tindale <br>
* <a href="http://www.adamtindale.com">www.adamtindale.com</a> <br>
* September 4, 2010 <br>
* <a href="http://www.inclusiveimprov.co.uk/doku.php/events:creativepact_2010">Creative Pact 2010</a><br>
*
* <p> 
* Experiment with MINIM. Uses UGen API and the AudioListener. DrawWave is a simple class that uses
* rect() like sytax to display a waveform in an area. Swap is a user space UGen that does simple
* byte swapping, one of my favourite effects from zexy in PD.
* </p>
*/

import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
LiveInput in;
AudioOutput out;
Swap fx1;
DrawWave renderer;

void setup(){
  size(400, 200);
  smooth();
  
  minim = new Minim(this);
  out = minim.getLineOut();
  in = new LiveInput( minim.getInputStream(out.getFormat().getChannels(), out.bufferSize(), out.sampleRate(), out.getFormat().getSampleSizeInBits()) ); 
  fx1 = new Swap();
  in.patch(fx1).patch(out);
 
  renderer = new DrawWave(0,0, width, height);
  out.addListener(renderer);
}

void draw(){
  noStroke();
  fill(0, 40);
  rect(0,0,width,height);
  renderer.draw();
}

void keyPressed(){
  if (key == ' ')
    saveFrame();
}

void stop()
{
  in.close();
  out.close();
  minim.stop();
  super.stop();
}
