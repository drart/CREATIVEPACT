import ddf.minim.*;

  Minim minim;
  AudioInput in;

int r;
ArrayList shapes = new ArrayList();

void setup()
{
  size(720,480, P3D);
  hint(ENABLE_OPENGL_4X_SMOOTH);
  
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 512);

  shapes.add( new PVector(10,20,30) );
  stroke(240,50);
  fill(180,100);
}

void draw()
{
  background(0);
  
  shapes.add ( new PVector ( in.mix.level()*width , in.mix.level()*height, 10*log(in.mix.level())  ) );
  
  translate(width/2, height/2);
  rotateY((float)r++/300); 
  beginShape();
  for ( int i = 0 ; i < shapes.size() ; i++ )
  {
     float[] p1 = ( (PVector)shapes.get(i) ).array();
     vertex( p1[0], p1[1] ,p1[2]  );  
  }
  endShape();
  
}

void mousePressed()
{
  saveFrame();
}
