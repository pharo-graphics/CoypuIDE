initialization
label: aString

	inputLabel := BlTextElement new.
	inputLabel text: (self configuredString: aString).
	inputLabel text fontSize: 25.
	inputLabel constraintsDo: [ :c |
		c ignoreByLayout.
		c ignored horizontal alignCenter ].
	inputLabel padding: (BlInsets all: 10).
	self addChild: inputLabel