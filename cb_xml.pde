/*
 * Author:        Marius Jigoreanu
 * Last edited:   14 May 2013 19:05:45
 * Web:           http://jima.ro
 * Email:         marius.jigoreanu@gmail.com | mjig@itu.dk
 */


 void setXmlData() {

 	emotions = new HashMap();
 	XML data = loadXML( "definitions.xml" );
 	xmlToColorMode( data.getChild( "config/color-mode" ) );
 	for( XML emotion : data.getChildren( "emotions/emotion" ) ) {

 		Emotion emotion = xmlToEmotion( emotion );
		emotions.put( emotion.getName(), emotion );
	}
}

void xmlToColorMode(XML colorMode) {

	int mode = int(colorMode.getChild("mode").getContent());
	int maxFirst = int(colorMode.getChild("max1").getContent());
	int maxSecond = int(colorMode.getChild("max2").getContent());
	int maxThird = int(colorMode.getChild("max3").getContent());

	colorMode(mode, maxFirst, maxSecond, maxThird);
}

Emotion xmlToEmotion(XML emotion) {

	return new Emotion (

		emotion.getChild( "name" ).getContent(),
		xmlToColor( emotion.getChild( "color" ) ),
		xmlToColor( emotion.getChild( "color" ) ),
		xmlToMask( emotion.getChild( "color" ) ),
		xmlToBreath( emotion.getChild( "breath" ) )
	);
}

color xmlToColor(XML colorData) {

	return color (

		( int )colorData.getChild( "hue" ).getContent(),
		( int )colorData.getChild( "saturation" ).getContent(),
		( int )colorData.getChild( "brightness" ).getContent()
	);
}

Mask xmlToMask(XML maskData) {

	float radiusMin = ( float ) maskData.getChild( "radius/minimum" ).getContent();
	float radiusMax = ( float ) maskData.getChild( "radius/maximum" ).getContent();
	color col = xmlToColor( maskData.getChild( "color" ) );

	return new Mask( col, radiusMin, radiusMax );
}

Breath xmlToBreath( XML breathData ) {

	float duration = breathData.getContent( "duration" ).getContent();
	float repeate = breathData.getContent( "repeate" ).getContent();

	return new Breath( duration, repeate );
}
