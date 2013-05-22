/*
* Author:        Marius Jigoreanu
* Last edited:   14 May 2013 19:07:19
* Web:           http://jima.ro
* Email:         marius.jigoreanu@gmail.com | mjig@itu.dk
*/


static class STATE {

  public final static int BREATHING = 0;
  public final static int PAUSE = 1;
  public final static int STOP = 2;
}

class Breather {

  private int                 state;
  private int                 index;
  private Emotion             emotion;
  private ArrayList<Emotion>  story;
  private boolean             repeate;

  public Breather() {

    init();
  }

  public Breather( Emotion emotion ) {

    init();
    this.emotion            = emotion;
  }

  public Breather( ArrayList<Emotion> story ) {

    init();
    this.story              = story;
    this.emotion            = story.get( index );
  }

  private void init() {

    state                   = STATE.STOP;
    index                   = 0;
    repeate                 = true;
  }

  public void breathe() {

    if ( state == STATE.BREATHING ) {

      if ( emotion.breath.isEnded() ) {

        if ( story != null ) {

          if ( story.size() < index )  index++; 
          else if ( repeate )          index = 0;
          else                         stop();

          emotion = story.get( index );
        }
        else if ( repeate ) emotion.breath.reset();
        else                stop();
      }
      else {

        emotion.update();
      }
    }
  }

  public void pause() {

    state = (state == STATE.PAUSE) ? STATE.BREATHING : STATE.PAUSE;
  }

  public void stop() {

    init();
  }

  public void draw() {

    if ( emotion != null ) emotion.draw();
  }

  public void setEmotion( Emotion emotion ) {

    init();
    story = null;
    this.emotion = emotion;
    state = STATE.BREATHING;
  }

  public void setStory( ArrayList<Emotion> story ) {

    init();
    this.story      = story;
    this.emotion    = story.get( index );
  }
}
