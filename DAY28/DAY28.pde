import javax.media.opengl.*;
import processing.opengl.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput in;
FFT fft;

void setup()
{
  size(720, 480);
  background ( 0 ) ;
  smooth();
  
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
    if ( fft.getBand(i) > fft.getBand(peak) )
        peak = i;
  }
  centroid /= sum;
  float peakiness = (float) peak / centroid;
  ///------------------------
  
  noStroke();
  fill(0,6);
  rect ( 0,0, width, height );
  
  translate(width/2, height/2);
  fill(200,60);
  for ( int i = 0 ; i < 10 ; i++)
  {
     float circlesize = random(70,100);
     //ellipse ( random(random(-200,-20), random(50,200)), random(random(-200,-20), random(50,200)) , circlesize, circlesize );
    ellipse ( random(-width/2, width/2), random(random(-200,-20), random(50,200)) * peakiness, circlesize, circlesize );
  }
  
  //filter(BLUR, peakiness);
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
