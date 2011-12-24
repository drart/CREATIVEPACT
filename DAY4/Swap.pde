//package ddf.minim.ugens; // to make into java object for inclusion in new minim

/** A UGen for byte swapping audio signals. Inspired by swap~ from 
 * Johannes M Zmoelnig's Zexy library for PureData. DANGER LOUD!
 * <p>
 * 
 * @author art
 */
// 
public class Swap extends UGen{

  public UGenInput audio;

  Swap()
  {
    audio = new UGenInput(InputType.AUDIO);
  }

  @Override
  protected void uGenerate (float[] channels)
  {
    if ( audio.isPatched() )
    {

      for (int i = 0; i < channels.length; i++){     
        // convert float to short 2^15       
        short temp = (short)( audio.getLastValues()[i] * 32768.);

        // byte swap
        int b1 = temp & 0xff;
        int b2 = (temp >> 8) & 0xff;
        temp = (short)(b1 << 8 | b2 << 0);

        // convert short back to a float
        channels[i] = temp * (1. / 32768.);
      } 
    }  
  }
}
