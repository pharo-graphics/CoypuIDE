tests
testNothingAddedIfValueIsTooHigh

	| circle |
	circle := MfFractalCircleElement new.
	circle setValue: 108.
	"The fractal circle works with percentage, so value is set to max if too high"
	self assert: circle value equals: 100.
	self assert: circle numberOfCircles equals: 25.