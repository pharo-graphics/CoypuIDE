event handling
pressedLookEvent: anEvent
	"Change the color of the widget when clicking on it"
	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e plus background: Color blue.
		e minus background: Color red.
		]. 