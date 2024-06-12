opening
openMixingTable
	"create a space to display the mixing table widget"
	
	| space |
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	space toTheme: MfMooflodTheme new.
	self transformDo: [ :c | c translateBy: 180 @ 150 ].
	space root addChild: self.
	space show.
	^ self 