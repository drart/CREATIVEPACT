import javax.media.opengl.*;
import processing.opengl.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput in;
FFT fft;

int numberofparticles = 10000;
float[] x = new float[numberofparticles];
float[] y = new float[numberofparticles];

void setup()
{
  size(720, 480, OPENGL);
  background ( 0 ) ;
  smooth();
  
  
  for (int i = 0; i < x.length ; i++)
    x[i] = (float) i / x.length *  width;
  Arrays.fill(y, height/2);
  
  
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 512);
  fft = new FFT(in.bufferSize(), in.sampleRate());
  fft.noAverages();
}

void draw()
{
  ///------------------------
  // SPECTRAL PEAKINESS
  ///------------------------
  // made this up. not accurate but gives interesting data
  fft.forward(in.mix);
  float sum = fft.getBand(0);
  int peak = 0;
  float centroid = 0;
  
  for( int i = 1 ; i < fft.specSize() ; i++)
  {
    sum += fft.getBand(i);
    centroid += i * fft.getBand(i);
    peak = ( fft.getBand(i) > fft.getBand(peak) ) ? i : peak ;    
  }
  centroid /= sum ;
  float peakiness = (float) peak / centroid;
  ///------------------------

  noStroke();
  fill(0,6);
  rect ( 0,0, width, height );
  
  fill(200,60);
  
  for ( int i = 0 ; i < x.length ; i++)
  {
    ellipse(x[i],y[i],1,1);
    
    y[i] += random(-peakiness,peakiness);
  }
  
}

void stop()
{
  in.close();
  minim.stop();
  super.stop();
}

void mouseClicked()
{
   saveFrame(); 
}
