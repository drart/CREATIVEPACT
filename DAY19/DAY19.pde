import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput input;
FFT fft;

float[] newspectrum;
blob newblob;

ArrayList drawings;

int r;

void setup()
{  
  size(720,480,P3D); 
   smooth();
  minim = new Minim(this); 
  input = minim.getLineIn(Minim.STEREO);
  fft = new FFT(input.bufferSize(), input.sampleRate() ); 
 
  drawings = new ArrayList();
  // .add(index)  .remove(index)
  
  colorMode(HSB,1000);
}

void draw()
{
  fft.forward(input.mix);
  
  background(0);
  
  newspectrum = new float[fft.specSize()];
  for (int i = 0 ; i < newspectrum.length ; i++)
    newspectrum[i] = fft.getBand(i);

  newblob = new blob(newspectrum);
  drawings.add(newblob);

  for(int i = 0 ; i < drawings.size() ; i++)
  {
     blob b = (blob)drawings.get(i);
     b.drawme();
  }

}


class blob
{
  float[] f;
  int z;
  float size = 50;
  blob(float[] points)
  {
     f = points;
  } 

  void drawme()
  {   
    pushMatrix();
    translate(0,0,z--);
    fill(20, 1000+z, 1000+z);
    stroke(20,1000+z, 1000+z);
    beginShape();
    for(int i = 0 ; i < f.length ; i++)
      curveVertex(i* width/f.length , f[i] *size);
    endShape();
    popMatrix();
  }

}
