import ddf.minim.*;

Minim minim;
AudioInput in;

PImage img;
PGraphics graph;
int r;
void setup() 
{
  size(720,480,P2D);
  
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 512);
  
  img = createImage(width,height, ARGB);
  graph = createGraphics(width/2, height, P2D);
  graph.smooth();

  graph.beginDraw();
  graph.background( color (290, 39, 111, 80));
  graph.stroke(200);
  for (int i = 0 ; i < 30 ; i++)
    graph.line(0,0,random(graph.width/2, graph.width) , random(graph.height/2, graph.height));
  graph.endDraw(); 

  img.loadPixels();
  for (int i = 0 ; i < img.pixels.length ; i++)
     img.pixels[i] = color( sin(random (0,TWO_PI)) *122 + 122);
  img.updatePixels();  
}


void draw()
{
  background(sin((float)frameCount/20) * 20 + 20 );
  image (graph,0,0);
  
  graph.beginDraw();
  graph.stroke(200);
  graph.rotate(r++);
  graph.rect(graph.width/2, graph.height/2, 40,40);
  graph.endDraw(); 
  

  pushMatrix();   
  scale(-1.0, 1.0);

  image(graph,-width,0);
  popMatrix();
    
  if ( in.mix.level() > 0.1 )
  {
     blend(img, 0,0,width,height, 0,0, width,height, DODGE);
     saveFrame();
   }
}

void mouseClicked ()
{
 saveFrame();
}

void stop()
{
  in.close();
  minim.stop();  
  super.stop();
}

