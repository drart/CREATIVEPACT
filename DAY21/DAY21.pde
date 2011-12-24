import javax.media.opengl.*;
import processing.opengl.*;

int r;
int numberoflines = 9000;

float[] x = new float [numberoflines];
float[] y = new float [numberoflines];
float[] z = new float [numberoflines];

void setup(){
  size(720,480, OPENGL);
  hint(ENABLE_OPENGL_4X_SMOOTH);
  smooth();
  fill(240,30);
  stroke(140,40); // try 240,30
  
  for (int i = 0 ; i < numberoflines ; i++)
  {
    x[i] = random(-width/2, width/2);
    y[i] = random(-height/2, height/2);
    z[i] = random(0,500);
  }
}


void draw(){

  background(0);

  translate(width/2, height/2,-500);
  rotate((float)r++/800);
  //rotateY((float)r++/500); // comment out this line for better motion
  noFill();
  strokeWeight(4);
  beginShape();
  for (int i = 0; i < x.length; i++)
  {
    vertex( x[i], y[i], z[i]);
  }
  endShape(); 
  
  for (int i = 0; i < x.length; i++)
  {
    x[i] += random(-1,1);
    y[i] += random(-1,1);
    z[i] += random(-1,1);
    
    z[i] += random( (float) i * .001);
  }  
}

void mouseClicked(){
  saveFrame(); 
}
