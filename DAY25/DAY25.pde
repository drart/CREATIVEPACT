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
  hint( ENABLE_OPENGL_4X_SMOOTH );
  
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 512);
  
  fft = new FFT(in.bufferSize(), in.sampleRate());
  fft.logAverages(50, 2);
  myspectrum = new float[ in.bufferSize() ];
  
  //noFill();
  //stroke(255,40);
  fill(200, 40);
}

void draw()
{
  background(30);
  
  fft.forward(in.mix);
  for(int i= 0; i < in.bufferSize(); i++)
    myspectrum[i] = fft.getBand(i);
  
  features = drawSpectral(myspectrum);
  
  fill(features[0] * 200 + features[1] * 200 + 100, 40);
  
  float level = in.mix.level();

  // lowpass filter to smooth out motion
  level += lastlevel;
  level *= 0.5;
  
  if ( 10 * log (level) > -50 )
     zr++;

  translate( width/2 , height/2 );
  rotateZ ( zr / 50 );

  for ( int i = 0 ; i < 20 ; i++ )
  {
    rotateY( r / 300 );
    rotateX( r / 500 );
    translate(log(level)*i,0,0); // comment this line out for more standard shape
    box(width/4 + 100 + ( 10 * log(level)) +i*3);
  }
  
  r++;
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
