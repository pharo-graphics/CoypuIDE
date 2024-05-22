adding
addElementsLevelTwo: aChildren

	| square label pattern |

	pattern := MfPatternElement new
		           min: 4;
		           max: 16;
		           nbsteps: 12.
	square := MfPulsingSquare new.
	label := MfInstrumentLabelElement new.
	 aChildren addChild: square.
	 aChildren addChild: label.
	square transformDo: [ :q | q translateBy: 450 @ 15 ].
	 aChildren addChild: pattern.
	pattern transformDo: [ :q | q translateBy: 40 @ 100 ].
	square addEventHandlerOn: BlClickEvent do: [ :e |
		 aChildren childrenDo: [ :c |
			c removeFromParent.
			nbTracks := nbTracks - 1 ] ]