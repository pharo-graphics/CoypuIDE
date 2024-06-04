adding
addElementsLevelOne: aName

	| square label name sect |
	sect := self children at: nbTracks.
	name := BlTextElement new.
	name text: (aName asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color white) }).
	name text fontSize: 18.
	square := MfPulsingSquare new.
	label := MfInstrumentLabelElement new.
	sect addChild: square.
	sect addChild: label.
	sect addChild: name.
	square transformDo: [ :q | q translateBy: 450 @ 15 ].
	name transformDo: [ :t | t translateBy: 130 @ 25 ].
	square addEventHandlerOn: BlClickEvent do: [ :e |
		sect childrenDo: [ :c |
			c removeFromParent.
			nbTracks > 1 ifTrue: [ nbTracks := nbTracks - 1 ] ] ]