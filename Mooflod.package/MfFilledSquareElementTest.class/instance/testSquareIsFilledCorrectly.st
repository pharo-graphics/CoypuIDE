tests
testSquareIsFilledCorrectly

	| square |
	square := MfFilledSquareElement new.
	square setValue: 56.
	"increase the y coordonate of the rectangle that fills the square by (2x value) "
	self assert: square currentY equals: 112