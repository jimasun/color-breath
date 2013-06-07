/*
* Author:        Marius Jigoreanu
* Last edited:   07 Jun 2013 14:10:37
* Web:           http://jima.ro
* Email:         marius.jigoreanu@gmail.com | mjig@itu.dk
*/


class Emotion {

  private String name;
  private Mask mask;
  private Breath breath;

  public Emotion ( String name, Mask mask, Breath breath ) {

    this.name = name;
    this.mask = mask;
    this.breath = breath;
  }

  public void update() {

    breath.update();
    mask.update();
  }

  public void draw() {

    breath.draw();
    mask.draw();
  }

  public String getName() {

    return name;
  }
}


class Mask {

  private Color col;
  private float radiusMin;
  private float radiusMax;
  private PImage maskImage; // temporary until i figure out how to generate it
  
  public Mask( Color col, float radiusMin, float radiusMax ) {

    this.col = col;
    this.radiusMin = radiusMin;
    this.radiusMax = radiusMax;

    maskImage = loadImage("mask.png");
  }

  public void update() {

  }

  public void draw() {

    image( maskImage, 0, 0 );
  }
}


class Breath {

  private Color colorLow;
  private Color colorHigh;
  private Color colorCurrent;

  private float pace;
  private float step;
  private float repeate;

  private float timeDuration;
  private float timeStart;
  private float timeEnd;
  private float timeCurrent;

  public Breath( Color colorLow, Color colorHigh, float duration, int repeate ) {

    this.colorLow = colorLow;
    this.colorHigh = colorHigh;

    this.timeDuration = duration;
    this.repeate = repeate;
    this.pace = 1.0f / ( ( timeDuration * frameRate ) / 1000.0f );

    reset();
  }

  public void update() {

    timeCurrent = millis() - timeStart;
    getStep();
    setColor();
  }

  public void draw() {

    background( colorCurrent.getColor() );
  }

  public void reset() {

    timeStart = millis();
    timeEnd = timeStart + ( timeDuration * repeate );
  }

  public boolean isEnded() {

    return timeEnd < millis();
  }

  private void getStep() {

    step += pace;

    if ( step <= 0. ) {

      step = 0;
      pace *= -1.;
    } 
    else if ( step >= 1 ) {

      step = 1;
      pace *= -1.;
    }
  }

  private void setColor() {

    int h = (int) lerp( colorLow.h, colorHigh.h, step );
    int s = (int) lerp( colorLow.s, colorHigh.s, step );
    int b = (int) lerp( colorLow.b, colorHigh.b, step );

    colorCurrent = new Color( h, s, b );
  }
}

class Color {

  public int h;
  public int s;
  public int b;

  public Color( int h, int s, int b ) {

    this.h = h;
    this.s = s;
    this.b = b;
  };

  public color getColor() {

    return color( h, s, b );
  }
}