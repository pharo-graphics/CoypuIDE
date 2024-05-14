as yet unclassified
openPiano: aPiano

	| space |
	space := BlSpace new.
	space root
		background: Color lightRed ;
		layout: BlFlowLayout horizontal.
	aPiano transformDo: [ :c | c translateBy: 200 @ 200 ].
	space root addChild: aPiano.
	space show.
	^ space