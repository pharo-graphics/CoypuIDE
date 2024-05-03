initialization
initializeEventListeners
"when pressing a key, changes the color of it and notify a down/unknown if the key is not in the dico"
	self addEventHandlerOn: BlKeyDownEvent do: [ :anEvent |
		('down: ' , anEvent key asString) traceCr.
		StringSignal emit: 'down: ' , anEvent key asString.
		keymap
			at: anEvent key
			ifPresent: [ :aButton |
			aButton background: Color veryVeryLightGray ]
			ifAbsent: [
				self inform: 'Unknown: ' , anEvent key asString.
				NonInteractiveTranscript stdout
					show: 'Unknown: ' , anEvent key asString;
					cr ] ].
			"doing the same when keyup by reset the key color and sending up notification"
	self addEventHandlerOn: BlKeyUpEvent do: [ :anEvent |
		('up ' , anEvent key asString) traceCr.
		StringSignal emit: 'up: ' , anEvent key asString.
		keymap
			at: anEvent key
			ifPresent: [ :aButton | aButton background: Color white ] ]