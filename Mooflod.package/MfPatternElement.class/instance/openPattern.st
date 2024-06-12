action
openPattern

	| space |
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	space root addChild: self.
	space toTheme: MfMooflodTheme new.
	self transformDo: [ :c | c translateBy: 180 @ 200 ].
	space show.
	^ self