/*
* Author:        Marius Jigoreanu
* Last edited:   02 Jun 2013 19:11:40
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

  private color col;
  private float radiusMin;
  private float radiusMax;
  private PImage maskImage; // temporary until i figure out how to generate it
  
  public Mask( color col, float radiusMin, float radiusMax ) {

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

  private color colorPrimary;
  private color colorSecondary;
  private color colorCurrent;

  private float pace;
  private float step;
  private float repeate;

  private float timeDuration;
  private float timeStart;
  private float timeEnd;
  private float timeCurrent;

  public Breath( color colorPrimary, color colorSecondary, float duration, int repeate ) {

    this.colorPrimary = colorPrimary;
    this.colorSecondary = colorSecondary;

    this.timeDuration = duration;
    this.repeate = repeate;
    this.pace = 1.0f / ( timeDuration * frameRate / 1000.0f );

    reset();
  }

  public void update() {

    timeCurrent = millis() - timeStart;
    getStep();
    setColor();
  }

  public void draw() {

    background( colorCurrent );
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

    if ( step <= 0 ) {

      step = 0;
      pace *= -1;
    } 
    else if ( step >= 1 ) {

      step = 1;
      pace *= -1;
    }
  }

  private void setColor() {

    colorCurrent = lerpColor(colorPrimary, colorSecondary, step);
  }
}
