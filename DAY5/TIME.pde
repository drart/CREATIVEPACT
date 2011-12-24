class DrawTime implements AudioListener
{
  private float[] left;
  private float[] right;

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
    if (left != null && left.length > 0)
    {
      //RMS
      float rms = 0.0;

      for (int i = 0; i < left.length; i++)
        rms += (left[i] * left[i] );

      if (rms!= 0.0)
      {
        rms /= left.length;
        rms = sqrt(rms);
      }
      pushStyle();
          noFill();
          stroke (255, 90,90);
          line(0, height - rms*height, width, height - rms*height);
      popStyle();  

      // ZERO-CROSSING RATE (normalized)
      // detected / buffsize

      float zcr = 0;

      for (int i = 0; i < left.length - 1; i++)
      {
        if (left[i] > 0.0 && left[i + 1] < 0.0)
          zcr++;
        else if (left[i] < 0.0 && left[i + 1] > 0.0)
          zcr++;
        else if (left[i] == 0.0 && left[i + 1] != 0.0)
          zcr++;
      }
      zcr = zcr / (float) left.length;
      pushStyle();
          noFill();
          stroke (90, 90,255);
          line(0, height - zcr*height, width, height - zcr*height); 
      popStyle();  
    }
  }
}
