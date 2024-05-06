as yet unclassified
initEventListeners
	"add the handler that changes color when pressing a key"

	self addEventHandlerOn: BlKeyDownEvent do: [ :anEvent |
		keymap
			at: anEvent key name
			ifPresent: [ :aButton | aButton background: Color red ] ].
			self addEventHandlerOn: BlKeyUpEvent do: [ :anEvent |
		keymap
			at: anEvent key name
			ifPresent: [ :aButton | aButton background: Color darkGray ] ].
	self requestFocus