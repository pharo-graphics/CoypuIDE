adding
addElementsLevelTwo: aName

	| square label pattern sect name |
	sect := self children at: nbTracks.
	name := BlTextElement new.
	name text: (aName asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color white) }).
	name text fontSize: 18.
	pattern := MfPatternElement new
		           min: 4;
		           max: 16;
		           nbsteps: 12.
	square := MfPulsingSquare new.
	label := MfInstrumentLabelElement new.
	sect addChild: square.
	sect addChild: label.
	sect addChild: name.
	square transformDo: [ :q | q translateBy: 450 @ 15 ].
	sect addChild: pattern.
	pattern transformDo: [ :q | q translateBy: 40 @ 100 ].
	name transformDo: [ :t | t translateBy: 130 @ 25 ]
	