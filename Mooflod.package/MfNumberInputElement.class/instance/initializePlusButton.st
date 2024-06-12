buttons
initializePlusButton

	| text |
	plus := self createCircle.
	plus constraintsDo: [ :c | c linear vertical alignCenter ].

	text := BlTextElement new text: (self configuredString: '+').
	text text fontSize: 55.
	text constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	plus
		addEventHandlerOn: BlMouseDownEvent
		do: [ :e | self increaseInput ].
	plus padding: (BlInsets all: 50).
	plus addChild: text.
	
	self addChild: plus