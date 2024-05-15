as yet unclassified
openKeyboard: aKeyboard

	| space |
	space := BlSpace new.
	space root
		background: Color orange;
		layout: BlFlowLayout horizontal.
	aKeyboard transformDo: [ :c |
		c rotateBy: -90.
		c translateBy: 50 @ 350 ].
	space root addChild: aKeyboard.
	space show.
	^ space