/*
* Author:        Marius Jigoreanu
* Last edited:   14 May 2013 19:07:13
* Web:           http://jima.ro
* Email:         marius.jigoreanu@gmail.com | mjig@itu.dk
*/


import controlP5.*;

ControlP5 cp5;
RadioButton basicNormal;

int uiBgWidth = 90;
int uiRound = 10;

void drawGuiBg() {

  noStroke();
  fill(0, 0, 50);
  rect(width - uiBgWidth, 0, uiBgWidth, 100, uiRound, 0, 0, uiRound);
}


void deactivateAll(RadioButton exceptRb) {

  if (exceptRb != basicNormal) basicNormal.deactivateAll();
}


void basicNormalRb(int a) {

  deactivateAll(basicNormal);

  switch( a ) {

    case( 1 ) : breather.setEmotion( ( Emotion ) emotions.get( "anger"         ) ); break;
    case( 2 ) : breather.setEmotion( ( Emotion ) emotions.get( "anticipation"  ) ); break;
    case( 3 ) : breather.setEmotion( ( Emotion ) emotions.get( "joy"           ) ); break;
    case( 4 ) : breather.setEmotion( ( Emotion ) emotions.get( "thrust"        ) ); break;
    case( 5 ) : breather.setEmotion( ( Emotion ) emotions.get( "fear"          ) ); break;
    case( 6 ) : breather.setEmotion( ( Emotion ) emotions.get( "surprise"      ) ); break;
    case( 7 ) : breather.setEmotion( ( Emotion ) emotions.get( "sadness"       ) ); break;
    case( 8 ) : breather.setEmotion( ( Emotion ) emotions.get( "disgust"       ) ); break;
  }
}


void initGui() {

  cp5 = new ControlP5(this);

  basicNormal = cp5
  .addRadioButton("basicNormalRb")
  .setPosition(width - 80, 10)
  .addItem("anger", 1)
  .addItem("anticipation", 2)
  .addItem("joy", 3)
  .addItem("trust", 4)
  .addItem("fear", 5)
  .addItem("surprise", 6)
  .addItem("sadness", 7)
  .addItem("disgust", 8);

  deactivateAll(null);
}
