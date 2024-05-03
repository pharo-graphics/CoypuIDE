instance creation
wideKey: aString span: aNumber
	| button label |
	
	button := self newButton: (self wideWidth: aNumber) @ self rowHeight.

	label := BlTextElement new.
	label tightMeasurement.
	label clipChildren: false.
	label text: (aString asRopedText fontSize: 13).
	label constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	button addChild: label.
	^ button