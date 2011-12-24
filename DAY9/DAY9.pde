import ddf.minim.*;
import ddf.minim.analysis.*;
import processing.opengl.*;
import javax.media.opengl.*;

Minim minim;
AudioInput input;

int Segments = 21;
float[][] mylines = new float[Segments*Segments][3];
float theta;
float phi;
float scalething = 200;
int r;

color c1 = color(240,0,0);
color c2 = color (200,150,150);

void setup()
{
  size(640,480, OPENGL);

  
  minim = new Minim(this);
  input = minim.getLineIn(Minim.STEREO, 512);

  	for(int i=0;i<Segments;++i)
	{
		theta = (float)i/Segments * 2 * PI;
		for(int j=0;j<Segments;++j)
		{
			phi = (float)j/Segments * PI;

			mylines[i*Segments+j][0] = sin(theta)*cos(phi)*scalething;
			mylines[i*Segments+j][1] = sin(theta)*sin(phi)*scalething;
			mylines[i*Segments+j][2] = cos(theta)*scalething;
		}
	}  
}

void draw()
{ 
  translate(width/2, height/2);
  
  float audiolevel = input.mix.level();
  strokeWeight(audiolevel*100);
  c1 = color(audiolevel*2100,0,0);

  rotateX((float)r++/800);
  rotateY((float)r/200);
  rotateZ((float)r/80);
  
  background(90);
  for(int i = 1 ; i < Segments * Segments; i++)
  {
      beginShape(LINES);
         stroke(c1); vertex(mylines[i][0], mylines[i][1], mylines[i][2] );
         stroke(200, 150, 150); vertex(mylines[i-1][0], mylines[i-1][1],mylines[i-1][2]);
      endShape();
  }
}

void keyPressed()
{
   if (key == ' ')  
   {
      saveFrame();
   }
}

void stop()
{
  input.close();
  minim.stop();
  super.stop();
}
