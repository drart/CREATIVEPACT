import ddf.minim.*;
import ddf.minim.analysis.*;
import processing.opengl.*;
import javax.media.opengl.*;

Minim minim;
AudioInput input;

int Segments = 21;
float[][] mylines = new float[Segments*Segments][3];
float[][] myrandomlines = new float[Segments*Segments][3];
float theta;
float phi;
float scalething = 200;
int r = 1;
int p;

color c1 = color(240,0,0);
color c2 = color (20,150,150);

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
            
                        myrandomlines[i*Segments+j][0] = random(0,scalething) - scalething/2;
                        myrandomlines[i*Segments+j][1] = random(0,scalething) - scalething/2;
                        myrandomlines[i*Segments+j][2] = random(0,scalething) - scalething/2;
		}
	}  
}

void draw()
{ 
  background(200);
  translate(width/2, height/2);
  
  float audiolevel = input.mix.level();
  strokeWeight(audiolevel*100);
  c1 = color(audiolevel*2100,80,audiolevel*1400);

  rotateY((float)p/200);
  rotateZ((float)p/123);

  for(int i = 1 ; i < Segments * Segments; i++)
  {
      rotate(random(200));
      beginShape(LINES);
         stroke(c1); 
         vertex(mylines[i][0] * (1.0 - 1.0/r) + myrandomlines[i][0] * (1.0/r), 
            mylines[i][1] * (1.0 - 1.0/r) + myrandomlines[i][1] * (1.0/r), 
            mylines[i][2] * (1.0 - 1.0/r) + myrandomlines[i][2] * (1.0/r));
         stroke(c2); 
         vertex(mylines[i-1][0] * (1.0 - 1.0/r) + myrandomlines[i-1][0] * (1.0/r), 
           mylines[i-1][1] * (1.0 - 1.0/r) + myrandomlines[i-1][1] * (1.0/r),
           mylines[i-1][2]* (1.0 - 1.0/r) + myrandomlines[i-1][2] * (1.0/r) );
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

void mouseClicked(){
 r++; 
  
}

void stop()
{
  input.close();
  minim.stop();
  super.stop();
}
