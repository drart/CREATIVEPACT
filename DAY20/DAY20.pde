import ddf.minim.*;
import ddf.minim.analysis.*;
import javax.media.opengl.*;
import processing.opengl.*;

Minim minim;
AudioInput input;
FFT fft;

float[][] spectra;
int pointer;

int r;

void setup()
{  
  size(720,480,OPENGL); 
  hint(ENABLE_OPENGL_4X_SMOOTH);

  smooth();
  minim = new Minim(this); 
  input = minim.getLineIn(Minim.STEREO);
  fft = new FFT(input.bufferSize(), input.sampleRate() ); 
  
  fft.logAverages(22, 2);
  
  spectra = new float[50][fft.avgSize()];
  
  colorMode(HSB,1000);
}

void draw()
{
  camera(width/2.0, height/10.0 + cos (r++/TWO_PI)*100, (height/2.0) / tan(PI*60.0 / 360.0) , width/2.0, height/2.0, 0,    0, 1, 0);
  
  fft.forward(input.mix);
  
  for (int i = 0 ; i < fft.avgSize() ; i++)
    spectra[ pointer ][i] = fft.getAvg(i);
  
  background(0);
  
  noFill();
  
  translate(0,height - 100);
  
  for ( int q = 1 ; q <= 50 ; q++)
  {  
    stroke(200,1000 - (q*20), 1000 - (q*20) );  

    beginShape();
    for (int i = 0 ; i < fft.avgSize() ; i++)
      curveVertex(i * (float)width/fft.avgSize() , spectra[ (pointer+q) % 50 ][i] * height );
    endShape();  
    translate(0,0, -200);
  }
  
  pointer = (pointer + 1) % 50;
}

void keyPressed()
{
  if (key == ' ')
    saveFrame(); 
}
