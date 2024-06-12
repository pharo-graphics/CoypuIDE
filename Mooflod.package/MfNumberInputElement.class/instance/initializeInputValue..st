initialization
initializeInputValue: aValue

	inputValue := BlTextElement new.
	inputValue size: 30 @ 30.
	inputValue constraintsDo: [ :c | c linear vertical alignCenter ].
	self changeValueTo: aValue.
	inputValue padding: (BlInsets all: 50).
	self addChild: inputValue