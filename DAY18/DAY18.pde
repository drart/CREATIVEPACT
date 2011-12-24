import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput input;
FFT fft;
boolean darkness = false;
int r;

void setup()
{
  size(720,480,P2D); 
  smooth();
  minim = new Minim(this); 
  input = minim.getLineIn(Minim.STEREO);
  fft = new FFT(input.bufferSize(), input.sampleRate() );
  fft.linAverages(10);
  background(0);
}

void draw()
{
  fft.forward(input.mix);

  noStroke();
  fill(0,19);
  rect(0,0,width,height);
  
  stroke(input.mix.level() * 255);
  strokeWeight(.1);
  
  pushMatrix();
  translate(width/4,height/4);
  rotate(PI - (float)r/100);
  beginShape();
  for (int i = 0 ; i < fft.avgSize(); i++)
  {      
      fill( fft.getBand(i) * 255 , 40);
      curveVertex(sin ( (float)i/fft.avgSize() * 2 *TWO_PI) *fft.getBand(i)  * width/2 , cos( (float)i/fft.avgSize() * 2 * TWO_PI) * fft.getBand(i)  * height/2  );
  }  
  endShape(CLOSE);
  popMatrix();
  
  pushMatrix();
  translate(width/4*3,height/4*3);
  rotate(PI + (float)r++/100);
  beginShape();
  for (int i = 0 ; i < fft.avgSize(); i++)
  {      
      fill( fft.getBand(i) * 255 , 40);
      curveVertex(sin ( (float)i/fft.avgSize() * 2 *TWO_PI) *fft.getBand(i)  * width/2 , cos( (float)i/fft.avgSize() * 2 * TWO_PI) * fft.getBand(i)  * height/2  );
  }  
  endShape(CLOSE);
  popMatrix();
  
  int spacing = width / fft.avgSize();
  
  if (!darkness)
    stroke(180);
  
  for (int i = 0 ; i < fft.avgSize(); i++)
  {
     strokeWeight(fft.getBand(i) * 50); 
     line( spacing * i + spacing/2, 0, spacing * i + spacing/2, height);  
  }
}

void stop()
{
  input.close();
  minim.stop();
  super.stop();
}

void keyPressed()
{
 if (key == ' ')
  saveFrame(); 
  
 if (key == 'd' | key == 'D' )
  darkness = !darkness; 
}
