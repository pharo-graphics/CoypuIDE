event handling
installLookEvent: anEvent

	super installLookEvent: anEvent.

	anEvent elementDo: [ :e |
		e background: (e valueOfTokenNamed: #'background-color') ]