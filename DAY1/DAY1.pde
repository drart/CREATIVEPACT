import ddf.minim.*;
import processing.video.*;

Minim minim;
AudioInput input;
WaveformRenderer waveform;

MovieMaker mm;

void setup()
{
  size(640, 480, P2D);
  frameRate(24);
  
  minim = new Minim(this);
  input = minim.getLineIn(Minim.STEREO, 512);
  waveform = new WaveformRenderer();
  input.addListener(waveform);

  mm = new MovieMaker(this, width, height, "mysketchoutput.mov", 24, MovieMaker.H263, MovieMaker.HIGH);
}

void draw()
{
  //background(0);
  fill(0,20);
  noStroke();
  rect(0,0,width,height);
  // see waveform.pde for an explanation of how this works
  waveform.draw();
  mm.addFrame();
}

void stop()
{
  // always close Minim audio classes when you are done with them
  input.close();
  // always stop Minim before exiting.
  minim.stop();
  super.stop();
   mm.finish();
}

void captureEvent(Capture myCapture) {
  myCapture.read();
}

class WaveformRenderer implements AudioListener
{
  private float[] left;
  private float[] right;
  
  color a = color (38,148,200);
  color b = color(200,148,38);
  
  WaveformRenderer()
  {
    left = null; 
    right = null;
  }
  
  synchronized void samples(float[] samp)
  {
    left = samp;
  }
  
  synchronized void samples(float[] sampL, float[] sampR)
  {
    left = sampL;
    right = sampR;
  }
  
  synchronized void draw()
  {
    if ( left != null && right != null )
    {
      noFill();

      float rms = 0;
      for (int i = 0 ; i < left.length; i++)
        rms += left[i];
      rms *= rms;
      //rms /= left.length;
      
      fill(lerpColor(a,b,rms*255));
  
      beginShape();
      for (int step=0;step<left.length;step++) {

             float l = 5-step;  
             int x=(int) (left[step]*l*Math.sin(l*Math.PI/left.length));
             int y=(int) (left[step]*l*Math.cos(l*Math.PI/left.length));
             vertex ( width/4 + x + rms, height/2 + y);
      }
      endShape();

      beginShape();
      for (int step=0;step<right.length;step++) {
             float l = 5-step;  
             int x=(int) (right[step]*l*Math.sin(l*Math.PI/right.length));
             int y=(int) (right[step]*l*Math.cos(l*Math.PI/right.length));
             vertex ( 0.75*width + x - rms, height/2 + y);
      }
      endShape();
    }
  }
}
