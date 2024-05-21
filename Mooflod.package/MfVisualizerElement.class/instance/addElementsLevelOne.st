adding
addElementsLevelOne

	
	| square label m |
	m := self children at: nbTracks.


	square := MfPulsingSquare new.
	label := MfInstrumentLabelElement new.
	m addChild: square.
	m addChild: label.
	square transformDo: [ :q | q translateBy: 450 @ 15 ].
