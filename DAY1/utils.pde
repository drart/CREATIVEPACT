

/*
// copy to setup() to activate
 mm = new MovieMaker(this, width, height, "mysketchoutput.mov",
                       frameRate, MovieMaker.H263, MovieMaker.HIGH);
// copy to the end of draw()
mm.addFrame();
*/


void mouseReleased(){
   println(frameRate);
}

void keyPressed(){
 if(key == ' ')
  saveFrame();

 if (key == 'f')
  println(frameRate); 

 if(key == 's' & mm != null)
    mm.finish();
}
