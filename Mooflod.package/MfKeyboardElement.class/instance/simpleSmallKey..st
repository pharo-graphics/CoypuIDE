instance creation
simpleSmallKey: aString

	| button label |
	button := self newButton: self simpleKeyExtent.

	label := BlTextElement new.
	label tightMeasurement.
	label clipChildren: false.
	label text: (aString asRopedText fontSize: 11).
		label text attributes:
		{ (BlTextForegroundAttribute paint: Color white) }.
	label constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	button addChild: label.
	^ button