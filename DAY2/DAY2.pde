import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.effects.*;

Minim minim;
AudioOutput out;
TriangleWave s1;
TriangleWave s2;
TriangleWave s3;
BandPass bpf;

float circlesize = 50;

void setup()
{
  size(400, 200);
  frameRate(24);
  minim = new Minim(this);
  out = minim.getLineOut(Minim.STEREO);
  
  bpf = new BandPass (500, 100, out.sampleRate() ) ;

  s1 = new TriangleWave(440, 0, out.sampleRate());
  s1.portamento(2000);
  out.addSignal(s1);
  
  s2 = new TriangleWave(450, 0, out.sampleRate());
  s2.portamento(2000);
  out.addSignal(s2);
  
  s3 = new TriangleWave(490, 0, out.sampleRate());
  s3.portamento(2000);
  out.addSignal(s3);
  
  out.addEffect(bpf);
  
  ellipseMode(CENTER);
  smooth();
  noStroke();
  
  s1.setPan(0);
  s2.setPan(1.0);
  s3.setPan(-1.0);
  
  //println(s1.pan() + " " + s2.pan() +" " + s3.pan() );
}

void draw()
{
  background(0);

  fill ( lerpColor (color(255,190,10), color(130,190,180), (s1.pan() + 1)*0.5 ));
  ellipse((s1.pan() * width/2) + width/2, height/2, s1.amplitude() * circlesize , s1.amplitude() * circlesize);
  
  fill ( lerpColor (color(255,190,10), color(130,190,180), (s2.pan() + 1)*0.5 ));
  ellipse((s2.pan() * width/2) + width/2, height/2, s2.amplitude() * circlesize , s2.amplitude() * circlesize);
  
  fill ( lerpColor (color(255,190,10), color(130,190,180), (s3.pan() + 1)*0.5 ));
  ellipse((s3.pan() * width/2) + width/2, height/2, s3.amplitude() * circlesize , s3.amplitude() * circlesize);
  
  if (s1.amplitude() < 0.3)
    s1.setAmp( s1.amplitude() + 0.01);

  if (s2.amplitude() < 0.3)
    s2.setAmp( s2.amplitude() + 0.01);
    
  if (s3.amplitude() < 0.3)
    s3.setAmp( s3.amplitude() + 0.01);
 
  s1.setPan( constrain(s1.pan() + random(-0.01,0.01) ,-1.0,1.0));
  s2.setPan( constrain(s2.pan() + random(-0.01,0.01) ,-1.0,1.0));
  s3.setPan( constrain(s3.pan() + random(-0.01,0.01) ,-1.0,1.0));

}

void mouseClicked(){
  s1.setFreq(s1.frequency() + random(-10,10) );
  s2.setFreq(s2.frequency() + random(-10,10) );
  s3.setFreq(s3.frequency() + random(-10,10) );
  saveFrame();
}

void stop()
{
  out.close();
  minim.stop();
  super.stop();
}
