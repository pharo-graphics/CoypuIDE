action
openInput: anInput
	"sets configuration to display the input element in a space"

	| space |
	space := BlSpace new.
	anInput defaultSkin: MfInputElementSkin new.
	space root layout: BlFlowLayout horizontal.
	anInput transformDo: [ :c | c translateBy: 250 @ 200 ].
	space root addChild: anInput.
	space toTheme: MfInputElementTheme new.
	space applyAllSkinInstallers .
	space show.
	^ anInput