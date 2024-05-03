event handling
installLookEvent: anEvent
 	"when installing the skin, changes the properties of widget mentionned down here"
	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder paint: Color black).
		e background: e backgroundPaint  ].