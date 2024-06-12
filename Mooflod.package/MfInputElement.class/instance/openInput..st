action
openInput: anInput
	"sets configuration to display the input element in a space"

	| space |
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	anInput transformDo: [ :c | c translateBy: 250 @ 200 ].
	space root addChild: anInput.
	space toTheme: MfMooflodTheme new.
	space show.
	^ anInput