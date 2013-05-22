/*
 * Author:        Marius Jigoreanu
 * Last edited:   22 May 2013 17:22:19
 * Web:           http://jima.ro
 * Email:         marius.jigoreanu@gmail.com | mjig@itu.dk
 */


 Breather   breather;
 HashMap    emotions;
 
 void setup() {

 	setXmlData();
 	breather = new Breather();
 	size( 1100, 600 );
 	frameRate( 60 );
  initGui();
 }

 void draw() {

 	breather.breathe();
 	breather.draw();
 	drawGuiBg();
 }
