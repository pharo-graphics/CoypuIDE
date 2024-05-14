instance creation
simpleKey: aString

	| button label |
	"assign a key to the button instance created by newButton: "
	button := self newButton: self simpleKeyExtent.

	label := BlTextElement new.
	label tightMeasurement.
	label clipChildren: false.
	label text: (aString asRopedText fontSize: 16).
	label text  attributes:
		{ (BlTextForegroundAttribute paint: Color white) }.
	label constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	button addChild: label.
	^ button