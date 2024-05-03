tests
testIfCirclesAreAddedCorrectly

	| circle |
	circle := MfFractalCircleElement new.
	circle setValue: 80.
	"Increment the circles in the widget each 4% incrementation"
	self assert: circle nbOfChilds equals: 20.