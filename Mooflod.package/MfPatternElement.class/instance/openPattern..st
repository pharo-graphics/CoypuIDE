action
openPattern: aPattern

	| space |
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	aPattern transformDo: [ :c | c translateBy: 180 @ 200 ].
	space root addChild: aPattern.
	space toTheme: MfPatternElementTheme new.
	space applyAllSkinInstallers .
	space show.
	^ aPattern