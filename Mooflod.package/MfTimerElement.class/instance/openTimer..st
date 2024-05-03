action
openTimer: aTimer

	| space |
	space := BlSpace new.
	aTimer defaultSkin: MfTimerElementSkin new.
	space root layout: BlFlowLayout horizontal.
	aTimer transformDo: [ :c | c translateBy: 200 @ 150 ].
	space root addChild: aTimer.
	space toTheme: MfTimerElementTheme new.
	space show.
	^ aTimer