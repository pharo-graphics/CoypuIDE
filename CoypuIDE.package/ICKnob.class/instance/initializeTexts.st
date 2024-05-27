initialization
initializeTexts

	| minLabel maxLabel currentLabel labels |
	minLabel := BlTextElement new text: self minValue asRopedText.
	maxLabel := BlTextElement new text: self maxValue asRopedText.

	currentLabel := BlTextElement new text: self currentValue asRopedText.

	labels := BlElement new clipChildren: false.

	labels addChild: minLabel.
	labels addChild: maxLabel.
	labels addChild: currentLabel.

	self addChild: labels.

	self callBack: [ :v |
		currentLabel text: v rounded asRopedText ].

	currentLabel position: 70 @ 130.
	minLabel position: 20 @ 125.
	maxLabel position: 120 @ 125