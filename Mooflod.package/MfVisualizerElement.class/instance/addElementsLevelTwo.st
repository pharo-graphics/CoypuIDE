adding
addElementsLevelTwo

	| square label pattern m |
	m := self children at: nbTracks.
	
		pattern := MfPatternElement new
			           min: 4;
			           max: 16;
			           nbsteps: 12.
		square := MfPulsingSquare new.
		label := MfInstrumentLabelElement new.
		m addChild: square.
		m addChild: label.
		square transformDo: [ :q | q translateBy: 450 @ 15 ].
		m addChild: pattern.
		pattern transformDo: [ :q | q translateBy: 40 @ 100 ] 