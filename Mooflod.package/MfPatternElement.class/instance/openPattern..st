action
openPattern: aPattern

	| space |
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	aPattern transformDo: [ :c | c translateBy: 180 @ 200 ].
	space root addChild: aPattern.
	space toTheme: MfMooflodTheme new.
	space show.
	^ aPattern