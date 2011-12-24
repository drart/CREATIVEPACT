import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
AudioPlayer jingle;
FFT fft;
DrawTime dt;

int w;
float[]  myspectrum;

void setup()
{
  size(512, 200, P3D);

  minim = new Minim(this);
  jingle = minim.loadFile("jingle.mp3", 2048);
  jingle.loop();
  
  fft = new FFT(jingle.bufferSize(), jingle.sampleRate());
  // calculate averages based on a miminum octave width of 22 Hz
  // split each octave into three bands
  fft.logAverages(22, 3);
  
  dt = new DrawTime();
  jingle.addListener(dt);

  myspectrum = new float[ jingle.bufferSize() ];
  
  rectMode(CORNERS);
}

void draw()
{
  background(0);
  fill(255);
  stroke(0);
  
  fft.forward(jingle.mix);
  // avgWidth() returns the number of frequency bands each average represents
  // we'll use it as the width of our rectangles
  w = int(width/fft.avgSize());

  for(int i = 0; i < fft.avgSize(); i++)
  {
    rect(i*w, height, i*w + w, height - fft.getAvg(i)*5);
  }
  
  for(int i= 0; i < jingle.bufferSize(); i++)
    myspectrum[i] = fft.getBand(i);
  
  dt.draw();
  drawSpectral(myspectrum);
}

void keyPressed(){
    if (key == ' ')
        saveFrame();
}

void stop()
{
  jingle.close();
  minim.stop();
  super.stop();
}
