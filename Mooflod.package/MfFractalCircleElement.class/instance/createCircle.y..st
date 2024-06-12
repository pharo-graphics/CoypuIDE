internal
createCircle: x y: anY

	| c |
	c := MfCircleElement new size: x @ anY.
	self addChild: c