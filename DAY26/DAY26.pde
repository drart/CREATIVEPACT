import javax.media.opengl.*;
import processing.opengl.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput in;
FFT fft;

float r;
float zr;

float lastlevel;
float[]  myspectrum;
float[] features;

void setup()
{
  size(720, 480, OPENGL);

  //http://code.google.com/p/processing/issues/detail?id=217&q=opengl&colspec=Stars%20ID%20Type%20Status%20Priority%20Owner%20Summary
  //http://code.google.com/p/processing/issues/detail?id=53&q=opengl&colspec=Stars%20ID%20Type%20Status%20Priority%20Owner%20Summary
  //noSmooth();
  hint( DISABLE_OPENGL_2X_SMOOTH );
  hint( ENABLE_OPENGL_4X_SMOOTH );
  //smooth();
  
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 512);
  
  fft = new FFT(in.bufferSize(), in.sampleRate());
  myspectrum = new float[ in.bufferSize() ];

  fill(200, 40);
  stroke(30,40);
}

void draw()
{
  background(30);
  lights();

  fft.forward(in.mix);
  for(int i= 0; i < fft.specSize(); i++)
    myspectrum[i] = fft.getBand(i);
  
  //==============================
  // SPECTRAL CENTROID
  //==============================
  float m1 = 0;
  float m0 = 0;

  for (int i = 0; i < myspectrum.length; i++){
    m1 += i * myspectrum[i];
    m0 += myspectrum[i]; 
  }

  float centroid = 0.5;
  if (m0 != 0.0)
  {
    centroid = (m1 / m0) / (float) myspectrum.length ;  
  }
  //==============================
  
  float level = in.mix.level();
  // lowpass filter to smooth out motion
  level += lastlevel;
  level *= 0.5;

  translate( width/2 , height/2 );
  rotateX ( zr++ / 50 );

  // set range of centroid to -1 -> 1
  directionalLight( 200,100,230, centroid * 2 -1 ,0,-1 );
  
  float spacing = (float)width / fft.specSize() ;
  float boxsize = 10;
  for ( int i = 0 ; i < fft.specSize() ; i++ )
  { 
    pushMatrix();
    translate( (i * spacing) - (width/2) + boxsize - 10 ,0,0);
    box(boxsize - 10*log(level) - 30);
    popMatrix();
  }
  
  lastlevel = level;
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
