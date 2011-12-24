float amp1;
float inc;
float tri;
boolean up;
float downer;

void setup(){
 size(400,300); 
  amp1 = height/2;
  fill(255);
  smooth();
}

void draw(){
  noStroke();
  fill(0,15);
  rect(0,0,width,height);
  stroke(40,197,90);
  fill(255);

  amp1 = pow (10, -tri/10);
  
  if (up)
    downer = -1;
  else 
    downer = 1;  

  for (int i = 0 ; i < width; i++)
  {
     point (i, sin(float(i)/width * TWO_PI + frameCount/PI)*downer * -1 *amp1*height/2 + height/2  - amp1*50) ;  
     point (i, sin(float(i)/width * TWO_PI *2 - frameCount/(3*PI))* downer * amp1*height/4 + height/4) ;  
     point (i, sin(float(i)/width * TWO_PI *20 - frameCount/(9*PI))* downer * amp1*height*.23 + height*.8 + amp1*30) ;  
 
  }
  
  if ( tri >= 20)
  {
    inc = -.2;
    up = !up;
  }
  if ( tri <= 0)
    inc = .16;

  tri = tri + inc;
}

void keyPressed(){
 if (key == ' ')
    saveFrame(); 
}
