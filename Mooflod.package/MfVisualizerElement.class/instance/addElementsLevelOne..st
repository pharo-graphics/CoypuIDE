adding
addElementsLevelOne: aChildren

	| square label |
	square := MfPulsingSquare new.
	label := MfInstrumentLabelElement new.
	aChildren addChild: square.
	aChildren addChild: label.
	square transformDo: [ :q | q translateBy: 450 @ 15 ].
	square addEventHandlerOn: BlClickEvent do: [ :e |
		aChildren childrenDo: [ :c |
			c removeFromParent.
			nbTracks := nbTracks - 1  ] ]