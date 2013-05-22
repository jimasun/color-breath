/*
 * Author:        Marius Jigoreanu
 * Last edited:   14 May 2013 19:05:56
 * Web:           http://jima.ro
 * Email:         marius.jigoreanu@gmail.com | mjig@itu.dk
 */



 /***  Breath  *****************************************/

 class Breath extends BreathData {

  public Breath( BreathData breathData ) {

    super( breathData );
    reset();
  }

  public void reset() {

    startTime = millis();
    endTime = startTime + ( spanDuration * repeate );
  }

  public void update() {

    currentTime = millis() - startTime;
    //if ( isBreak() ) return;
    //getSaturation();
    //getBrightness();
    //getSmoothness();
    getStep();
    setColor();
    setMask();
  }

  private boolean isBreak() {

    if ( !variableProgress ) return false;
    return getCurrentPropertyValue( breakPointSet ) == 1  ? true : false;
  }

  private void getStep() {

    currentStep += currentPace;

    if ( currentStep <= 0 ) {

      currentStep = 0;
      currentPace *= -1;
    } 
    else if ( currentStep >= 1 ) {

      currentStep = 1;
      currentPace *= -1;
    }
  }

  private void setColor() {

    int h = round(hue(baseColor));
    int s = round(saturation(baseColor) * currentSaturation);
    int b = round(brightness(baseColor) * currentBrightness);
    emoColor = color(h, s, b);
    currentColor = lerpColor(currentOposedColor, baseColor, currentStep);
  }

  private void setMask() {
  }

  public boolean isEnded() {

    return endTime < millis();
  }

  public color getColor() {

    return currentColor;
  }

  public PImage getMask() {

    return mask.getMask();
  }
}




/***  BreathData  *****************************************/

class BreathData {

  protected String name;
  protected Mask mask;
  protected Breath breath;

  protected color baseColor, emoColor;
  protected color currentOposedColor, currentColor;

  protected boolean variableSaturation;
  protected boolean variableBrightness;
  protected boolean variableProgress;
  protected boolean variableSmoothness;

  protected BreathPropertySet saturationSet;
  protected BreathPropertySet brightnessSet;
  protected BreathPropertySet breakPointSet;
  protected BreathPropertySet smoothnessSet;

  protected float currentSaturation;
  protected float currentBrightness;
  protected float currentSmoothness;
  protected float currentPace;
  protected float currentStep;
  protected float startTime, endTime;
  protected float currentTime, spanDuration;
  protected int repeate;

  public BreathData( BreathData bd ) {

    name = bd.name;
    mask = bd.mask;
    repeate = bd.repeate;
    baseColor = bd.baseColor;
    spanDuration = bd.spanDuration;
    saturationSet = bd.saturationSet;
    brightnessSet = bd.brightnessSet;
    breakPointSet = bd.breakPointSet;
    smoothnessSet = bd.smoothnessSet;
  }

  public BreathData( String name, Mask mask, color baseColor, float spanDuration, 
    int repeate, BreathPropertySet saturationSet, BreathPropertySet brightnessSet, 
    BreathPropertySet breakPointSet, BreathPropertySet smoothnessSet)
  {

    this.name = name;
    this.mask = mask;
    this.baseColor = baseColor;
    this.spanDuration = spanDuration;
    this.repeate = repeate;
    this.saturationSet = saturationSet;
    this.brightnessSet = brightnessSet;
    this.breakPointSet = breakPointSet;
    this.smoothnessSet = smoothnessSet;

    variableSaturation = isVariable( saturationSet );
    variableBrightness = isVariable( brightnessSet );
    variableProgress = isVariable( breakPointSet );
    variableSmoothness = isVariable( smoothnessSet );
  }

  protected boolean isVariable( BreathPropertySet propertySet ) {

    return propertySet.getSet().size() > 1 ? true : false;
  }

  protected float getDefaultPropertyValue( BreathPropertySet propertySet ) {

    return propertySet.getSet().get(0).getValue();
  }

  protected float getCurrentPropertyValue( BreathPropertySet propertySet ) {

    for ( BreathProperty p : propertySet.getSet() ) {
      if ( p.begin <= currentTime && currentTime >= p.endin ) {
        return p.getValue();
      }
    }
    return 0;
  }

  protected void getSaturation() {

    if ( !variableSaturation ) {

      currentSaturation = getDefaultPropertyValue( saturationSet );
    }
    else {

      currentSaturation = getCurrentPropertyValue( saturationSet );
    }
  }

  protected void getBrightness() {

    if ( !variableBrightness ) {

      currentBrightness = getDefaultPropertyValue( brightnessSet );
    }
    else {

      currentBrightness = getCurrentPropertyValue( brightnessSet );
    }
  }

  protected void getSmoothness() {

    if ( !variableSmoothness ) {

      currentSmoothness = getDefaultPropertyValue(smoothnessSet);
    }
    else {

      currentSmoothness = getCurrentPropertyValue( smoothnessSet );
    }

    currentSmoothness = 1.0f / ( spanDuration * frameRate / 1000.0f );

    currentPace = currentPace >= 0 ? currentSmoothness : currentSmoothness * -1;
  }
}




/***  BreathPropertySet  *****************************************/

class BreathPropertySet {

  public ArrayList<BreathProperty> set;

  public BreathPropertySet( BreathProperty[] bp ) {

    set = new ArrayList();
    for ( BreathProperty b : bp ) {

      set.add( b );
    }
  }

  public ArrayList<BreathProperty> getSet() {

    return set;
  }
}




/***  BreathProperty  *****************************************/

class BreathProperty {

  private int begin;
  private int endin;
  private float value;

  public BreathProperty ( int begin, int endin, float value) {

    this.begin = begin;
    this.endin = endin;
    this.value = value;
  }

  public int getBegin() {

    return begin;
  }

  public int getEndin() {

    return endin;
  }

  public float getValue() {

    return value;
  }
}

class Mask {

  private color col;
  private float radiusMin;
  private float radiusMax;
  private PImage maskImage;
  
  public Mask( color col, float radiusMin, float radiusMax ) {

    this.col = col;
    this.radiusMin = radiusMin;
    this.radiusMax = radiusMax;
  }

  public void generateMask() {


  }

  public PImage getMask() {

    return maskImage;
  }
}

class Emotion {

  private String name;
  private color colorPrimary;
  private color colorSecondary;
  private Mask mask;
}