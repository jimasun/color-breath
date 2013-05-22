/*
 * Author:        Marius Jigoreanu
 * Last edited:   14 May 2013 19:07:19
 * Web:           http://jima.ro
 * Email:         marius.jigoreanu@gmail.com | mjig@itu.dk
 */


 public static class STATE {

  public final static int BREATHING = 0;
  public final static int PAUSE = 1;
  public final static int STOP = 2;
}

public class Breather {

  private int                 state;
  private int                 index;
  private Breath              breath;
  private ArrayList<Breath>   story;
  private boolean             repeate;

  public Breather() {

    init();
  }

  public Breather( Breath b ) {

    init();
    breath                  = b;
  }

  public Breather( ArrayList<Breath> s ) {

    init();
    story                   = s;
    breath                  = s.get(index);
  }

  private void init() {

    state                   = STATE.STOP;
    index                   = 0;
    repeate                 = true;
  }

  public void breathe() {

    if ( state == STATE.BREATHING ) {

      if ( breath.isEnded() ) {

        if ( story != null ) {

          if ( story.size() < index )  index++; 
          else if ( repeate )          index = 0;
          else                         stop();

          breath = story.get( index );
        }
        else if ( repeate ) breath.reset();
        else                stop();
      }
      else {

        breath.update();
      }
    }
  }

  public void pause() {

    if (state == STATE.PAUSE)
    state = STATE.BREATHING;
    else
    state = STATE.PAUSE;
  }

  public void stop() {

    init();
  }

  public void draw() {

    if (breath == null) return; 
    background(breath.getColor());
    image(breath.getMask(), 0, 0);
  }

  public void setBreath( BreathData bd ) {

    init();
    story = null;
    breath = new Breath(bd);
    state = STATE.BREATHING;
  }

  public void setStory( ArrayList<Breath> s ) {

    init();
    story = s;
    breath = s.get(index);
  }
}
