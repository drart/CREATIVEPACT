import javax.media.opengl.*;
import processing.opengl.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput in;
FFT fft;

float[] x;
float[] y;

int index;

float[] spectrum;
float[] lastspectrum;

void setup()
{
  size(720, 480, OPENGL);
  hint(DISABLE_OPENGL_2X_SMOOTH);
  background ( 0 ) ;
  smooth();
  noStroke();
  
  x = new float[width];
  y = new float[width];
  
  for (int i = 0; i < x.length ; i++)
    x[i] = (float)i ;
  
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 512);
  fft = new FFT(in.bufferSize(), in.sampleRate());
  fft.noAverages();
  
  spectrum = new float[fft.specSize()];
  lastspectrum = new float[fft.specSize()];
  
  Arrays.fill( lastspectrum, 0 ); 
}

void draw()
{

  fft.forward(in.mix);

  ///------------------------
  // SPECTRAL FLUX
  ///------------------------
  float flux = 0;
  for( int i = 0 ; i < fft.specSize() ; i++)
  {
      spectrum[i] = fft.getBand(i);
      flux += spectrum[i] - lastspectrum[i]; 
      // rectified flux
      // float fluxval = spectrum[i] - lastspectrum[i];
      // flux += (fluxval > 0.0 ) ? fluxval : 0.0;
  }
  System.arraycopy( spectrum, 0, lastspectrum, 0, spectrum.length ); 
  ///------------------------
  
  fill(0,6);
  rect ( 0,0, width, height );
 
  fill(200,60); 
  translate(0,height/2); 
  for ( int i = 0 ; i < x.length ; i++)
    ellipse(x[i],y[i],abs(flux),abs(flux));
  
  y[index++%width] = flux; 
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
