import processing.opengl.*;
import javax.media.opengl.*;

int pointer;
float [][] mouse;

void setup() {
 size(400,400, OPENGL);
 smooth();
 mouse = new float[20][width];
}

void draw() {

 camera(300, height/10.0, (height/2.0) / tan(PI*60.0 / 360.0),width/2.0, height/2.0, 0, 0, 1, 0);

 for (int i = 0; i < width; i++) {
   float mousePlace = map(mouseY, 0, width, 0, 10); //scale mouseY values down to 10
   mouse [pointer][i] = mousePlace;

   background(255);
   noFill();
   translate(-width/4, height - 50);  //pulls curves to left, and raises by 50

   for (int k = 1; k < 10; k++) {
    stroke(((float)k/10)*255.0); // I can't see this black-white transition happening, why?

     beginShape();
     for (i = 0; i < width; i++) {
      curveVertex(i * float(width/2) , mouse[ (pointer + k) % 20 ][i] * height/2 );
     }
     endShape();
     translate(0, 0, -200);
   }
 }
 pointer = (pointer + 1) % 20;
}
