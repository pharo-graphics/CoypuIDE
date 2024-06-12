as yet unclassified
openFractalCircle: aCircle

	| space |
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	aCircle transformDo: [ :c | c translateBy: 200 @ 150 ].
	space toTheme: MfMooflodTheme new.
	space root addChild: aCircle.
	space show.
	^ aCircle