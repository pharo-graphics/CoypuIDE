as yet unclassified
openSquare: aSquare

	| space |
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.

	space toTheme: Mf3DSquareTheme new.

	space root addChild: self initBottomRight.
	space root addChild: self initTopLeft.
	space root addChild: self initBottomLeft.
		space root addChild: aSquare.
	space root addChild: self initTopRight.
	space root childrenDo: [ :s |
		s transformDo: [ :c | c translateBy: 200 @ 150 ] ].


	space show.
	^ aSquare