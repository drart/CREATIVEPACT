float[] drawSpectral(float[] spec)
{
  
  //==============================
  // SPECTRAL CENTROID
  //==============================
  float m1 = 0;
  float m0 = 0;

  for (int i = 0; i < spec.length; i++){
    m1 += i * spec[i];
    m0 += spec[i]; 
  }

  float centroid = 0.5;
  if (m0 != 0.0)
  {
    centroid = (m1 / m0) / (float) spec.length ;  
  }

  //==============================
  // SPECTRAL ROLLOFF
  //==============================
  float perc = 0.8;
  float[] sumWindow = new float [ spec.length ];
  float total = 0;	
  float sum = 0;
  float specRolloff = 0;
  boolean specdone = false;
  for( int i = 0; i< spec.length; i++)
  {
    sum += spec[i];
    sumWindow[i] = sum;
  }
  total = sumWindow[spec.length-1];

  for ( int i = spec.length-1; i > 1 ; i--){
    if (sumWindow[i] < 0.8 * total)
    {
      specRolloff = (float) i;
      specdone = true;
      break;
    }
  }
  if ( !specdone )
    specRolloff = float(spec.length - 1);
  specRolloff /= spec.length;

  //==============================
  // SPECTRAL COMPATCTNESS
  // code snippet from jAUDIO  
  //==============================
  float[] mag_spec = new float[ spec.length ];
  for (int i = 0; i < spec.length; i++)
  {
    mag_spec[i] = abs( spec[i] );
  }

  double compactness = 0.0;
  for (int i = 1; i < mag_spec.length - 1; i++) {
    if ((mag_spec[i - 1] > 0.0) && (mag_spec[i] > 0.0) && (mag_spec[i + 1] > 0.0)) 
    {
      compactness += Math .abs(
          20.0 * Math.log(mag_spec[i])
          - 20.0 * (Math.log(mag_spec[i - 1]) 
            + Math.log(mag_spec[i]) 
            + Math .log(mag_spec[i + 1])) 
          / 3.0);
    }
  }

 float[] f =  { centroid, specRolloff, (float)compactness };
 return f;
}

