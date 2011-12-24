import javax.media.opengl.*;
import processing.opengl.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
FFT fft;
AudioInput input;

float[] points;

int numberofpoints;

void setup()
{
  size(720,480,OPENGL); 
  hint(ENABLE_OPENGL_4X_SMOOTH);  

  minim = new Minim(this);
  input = minim.getLineIn(Minim.STEREO, 512);
  fft = new FFT(input.bufferSize(), input.sampleRate() );

  numberofpoints = fft.specSize();
  
  points = new float[numberofpoints];  
  for ( int i = 0 ; i < numberofpoints/2; i++)  
  {    
    points[i] = sin( (float)i/numberofpoints*2 * TWO_PI) * height/2 + width/2;
    points[i+numberofpoints/2] = cos( (float)i/numberofpoints*2 * TWO_PI) * height/2 + height/2;
  }

  noStroke();
  fill(0);
  rect(0,0,width,height); 
}

void draw()
{
  
  fill(0,5);
  noStroke();
  rect(0,0,width,height);
  fill(255);
  
  float audiolevel = input.mix.level();
  fft.forward(input.mix);
  
  strokeWeight(5);
  
  for ( int i = 0 ; i < numberofpoints/2; i++)  
  {  
    stroke( fft.getBand(i) * 100);
    point( points[i] , points[i+numberofpoints/2] );
  }  
}

void mousePressed()
{
   noStroke();
   fill(255);
   rect(0,0,width,height); 
}

void keyPressed()
{
  if (key == ' ')
    saveFrame();
}

void stop()
{
  input.close();
  minim.stop();
  super.stop();
}
