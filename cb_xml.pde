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
 	for( XML emotionXml : data.getChildren( "emotions/emotion" ) ) {

 		Emotion emotion = xmlToEmotion( emotionXml );
		emotions.put( emotion.getName(), emotion );
	}
}

Emotion xmlToEmotion( XML emotionXml ) {

	return new Emotion (

		emotionXml.getChild( "name" ).getContent(),
		xmlToColor( emotionXml.getChild( "color" ) ),
		xmlToColor( emotionXml.getChild( "color" ) ),
		xmlToMask( emotionXml.getChild( "color" ) ),
		xmlToBreath( emotionXml.getChild( "breath" ) )
	);
}

color xmlToColor( XML colorXml ) {

	return color (

		int( colorXml.getChild( "hue" 				).getContent() ),
		int( colorXml.getChild( "saturation" ).getContent() ),
		int( colorXml.getChild( "brightness" ).getContent() )
	);
}

Mask xmlToMask( XML maskXml ) {

	return new Mask (

		xmlToColor( maskXml.getChild( "color" ) ),
		float( maskXml.getChild( "radius/minimum" ).getContent() ),
		float( maskXml.getChild( "radius/maximum" ).getContent() )
	);
}

Breath xmlToBreath( XML breatXml ) {

	return new Breath (

		float( breatXml.getChild( "duration" ).getContent() ),
		int  ( breatXml.getChild( "repeate"  ).getContent() )
	);
}

void xmlToColorMode( XML colorModeXml ) {

	colorMode (

		int( colorModeXml.getChild("mode").getContent() ),
		int( colorModeXml.getChild("max1").getContent() ),
		int( colorModeXml.getChild("max2").getContent() ),
		int( colorModeXml.getChild("max3").getContent() )
	);
}
