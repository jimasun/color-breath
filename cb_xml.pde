/*
* Author:        Marius Jigoreanu
* Last edited:   07 Jun 2013 14:12:05
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
		xmlToMask( emotionXml.getChild( "mask" ) ),
		xmlToBreath( emotionXml.getChild( "breath" ) )
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

		xmlToColor( breatXml.getChild( "color-primary" ) ),
		xmlToColor( breatXml.getChild( "color-secondary" ) ),
		float( breatXml.getChild( "duration" ).getContent() ),
		int  ( breatXml.getChild( "repeate"  ).getContent() )
	);
}

Color xmlToColor( XML colorXml ) {

	return new Color (

		int( colorXml.getChild( "hue" 			 ).getContent() ),
		int( colorXml.getChild( "saturation" ).getContent() ),
		int( colorXml.getChild( "brightness" ).getContent() )
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
