as yet unclassified
openVisualizer: aVisualizer

	| space |
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	aVisualizer transformDo: [ :c | c translateBy: 200 @ 50 ].
	space root addChild: aVisualizer.
	space toTheme: MfMooflodTheme new.
	space show.
	^ aVisualizer