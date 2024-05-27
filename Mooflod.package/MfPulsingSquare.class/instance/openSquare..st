as yet unclassified
openSquare: aSquare

	| space |
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	aSquare transformDo: [ :c | c translateBy: 200 @ 150 ].
	space root addChild: aSquare.
	space show.
	^ aSquare