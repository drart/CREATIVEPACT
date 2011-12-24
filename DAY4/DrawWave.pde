class DrawWave implements AudioListener
{
  private float[] left;
  private float[] right;
  private int x;
  private int y;
  private int width;
  private int height;
  private color c;
  private color bg;
  private boolean drawbackground;
  
  DrawWave(int xx, int yy, int ww, int hh)
  {
    left = null; 
    right = null;
    
    this.x = xx;
    this.y = yy;
    this.width = ww;
    this.height = hh;
    
    c = color (255);
    bg = color (30, 189, 210);
    drawbackground = false;
  }
  
  synchronized void samples(float[] samp)
  {
    left = samp;
  }
  
  synchronized void samples(float[] sampL, float[] sampR)
  {
    left = sampL;
    right = sampR;
  }
  
  synchronized void draw()
  {
    if ( left != null && right != null )
    {
      // playing nice by localizing style    
      pushStyle();
      stroke(c);
      
      if (drawbackground)
      {
        fill (bg);
        rect(this.x, this.y, this.width-1, this.height);
      }
      noFill();
       
      float inc = (float)this.width / left.length;
      
      float quarterheight = this.height / 4;
      float threequarterheight = quarterheight * 3;
  
      beginShape(POINTS);
      for (int step=0;step<left.length;step++) {
             vertex ( (inc*step) + this.x, left[step]* quarterheight + this.y + quarterheight);
      }
      endShape();

      beginShape(POINTS);
      for (int step=0;step<right.length;step++) {
             vertex ( (inc*step) + this.x, right[step]* quarterheight + this.y + threequarterheight);
      }
      endShape();
      
      popStyle();
    }    
  }
  
  /// setter methods
  public void setColour(color cc)
  {
     c = cc; 
  }
  
  public void background(boolean b)
  {
     drawbackground = b; 
  }
  
  public void setBackgroundColour(color cc)
  {
    bg = cc;
  }
}
