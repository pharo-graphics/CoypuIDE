as yet unclassified
createCircle: x y: anY color: aColor

	| c color |
	color := Color gray: aColor.
	c := MfCircleElement new size: x @ anY.
	c background: color.
	self addChild: c