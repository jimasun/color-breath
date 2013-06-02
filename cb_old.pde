/*

class BreathOLD extends BreathData {

  private boolean isBreak() {

    if ( !variableProgress ) return false;
    return getCurrentPropertyValue( breakPointSet ) == 1  ? true : false;
  }
}


class BreathData {

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
  protected float startTime, endTime;
  protected float currentTime, spanDuration;
  protected int repeate;

  public BreathData() { }

  public BreathData( BreathData bd ) {

    repeate = bd.repeate;
    spanDuration = bd.spanDuration;
    saturationSet = bd.saturationSet;
    brightnessSet = bd.brightnessSet;
    breakPointSet = bd.breakPointSet;
    smoothnessSet = bd.smoothnessSet;
  }

  public BreathData( String name, Mask mask, color baseColor, float spanDuration, 
    int repeate, BreathPropertySet saturationSet, BreathPropertySet brightnessSet, 
    BreathPropertySet breakPointSet, BreathPropertySet smoothnessSet) {

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
