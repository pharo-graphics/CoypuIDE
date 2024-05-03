as yet unclassified
initEventListeners

	self addEventHandlerOn: BlKeyDownEvent do: [ :anEvent |
		keymap
			at: anEvent key name
			ifPresent: [ :aButton | aButton background: Color random ] ].
	self requestFocus