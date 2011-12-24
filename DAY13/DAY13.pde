import javax.media.opengl.*;
import processing.opengl.*;
import ddf.minim.*;
import ddf.minim.signals.*;

Minim minim;
AudioOutput out;
SineWave sine;

PGraphics graph;
PImage img;
int r;
boolean mybool;
float[] points;
int x;
void setup()
{
  size(720,480,P2D); 
  
  graph = createGraphics(720,480,P2D);
  img = createImage(720,480, RGB);
  
  points = new float[400];  
  for ( int i = 0 ; i < 100; i++)  
  {
    points[i] = width/2 + random(-width/2, width/2) ; 
    points[i+100] = height/2 + random(-height/2, height/2) ;
    points[i+200] = width/2 + random(-width/2, width/2) ; 
    points[i+300] = height/2 + random(-height/2, height/2) ;  
  }
  
  smooth();
  
 
  
 minim = new Minim(this);
 out = minim.getLineOut(Minim.STEREO);
 sine = new SineWave(440, 0.5, out.sampleRate());
 sine.portamento(200); 
 out.addSignal(sine);
}

void draw()
{
  graph.beginDraw();
  graph.background(0);
  graph.noStroke();
  graph.fill(255);
  
  graph.rect(0,0,width,height/2 + x--);
  
  for (int i = 0; i < points.length ; i++)
     points[i] += random(-2,2);
  
  graph.stroke(255);
  graph.strokeWeight(1.4);
  
  for ( int i = 0 ; i < 100; i++)  
    graph.line( points[i] , points[i+100], points[i+200], points[i+300] );
    
  graph.endDraw();
  
  img = graph.get();

  fastBlur(img, 10);
  img.filter(POSTERIZE,3);
  fastBlur(img,4);
  image(img,0,0);
  
  sine.setFreq(440 + x);

}

void keyPressed()
{
  if (key == ' ')
    saveFrame();
}
