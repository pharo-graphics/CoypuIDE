buttons
initializeMinusButton

	| text |
	minus := self createCircle.
	minus constraintsDo: [ :c | c linear vertical alignCenter ].

	text := BlTextElement new text: (self configuredString: '-').
	text text fontSize: 80.
	text constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	minus
		addEventHandlerOn: BlMouseDownEvent
		do: [ :e | self decreaseInput ].
	minus padding: (BlInsets all: 50).
	minus addChild: text.
	self addChild: minus