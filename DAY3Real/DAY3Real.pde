import ddf.minim.*;
import ddf.minim.ugens.*;
import controlP5.*;

ControlP5 controlP5;
Slider bdslider;
public float bitdepth;

Minim minim;
LiveInput in;
AudioOutput out;
Constant controls = new Constant();
BitCrush fx1 = new BitCrush();

void setup(){
  size(500, 400);
  minim = new Minim(this);
  out = minim.getLineOut();
  in = new LiveInput( minim.getInputStream(out.getFormat().getChannels(), out.bufferSize(), out.sampleRate(), out.getFormat().getSampleSizeInBits()) ); 
  
  controlP5 = new ControlP5(this);
  bdslider = controlP5.addSlider("bitdepth",1,16,  15,height/3-80 , width-100,30);

  bdslider.setValue(8);
  
  controls.patch(fx1.bitRes);
  controls.setConstant (bitdepth); 

 in.patch(fx1).patch(out);
}

void draw(){
  background(50);
  stroke( 255 );
  
  controls.setConstant (bitdepth); 
  
  for( int i = 0; i < out.bufferSize() - 1; i++ )
  {
    float x1  =  map( i, 0, out.bufferSize(), 0, width );
    float x2  =  map( i+1, 0, out.bufferSize(), 0, width );
    line( x1, height*.75 + out.left.get(i)*50, x2, height*.75 + out.left.get(i+1)*50);
    line( x1, height*.75 + 50 + out.right.get(i)*50, x2, height*.75 + 50 + out.right.get(i+1)*50);
  }  
  controlP5.draw(); 
}

void keyPressed(){
  if (key == ' ')
    saveFrame();
}

void stop()
{
  in.close();
  out.close();
  minim.stop();
  super.stop();
}
