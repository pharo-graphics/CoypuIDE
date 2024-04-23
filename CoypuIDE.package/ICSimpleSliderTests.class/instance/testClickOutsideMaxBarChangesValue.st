tests
testClickOutsideMaxBarChangesValue

	| child |
	child := BlElement new
		         size: 0 @ 0;
		         position: slider size.
	slider addChild: child.
	"The child lets us simulate a click on the slider on a specific position"
	"simulateClickOn: simulates a click in the middle of the element, thus the size 0@0 for the child"
	slider forceLayout.
	"we forceLayout otherwise the child would'nt have the correct position"
	child position: slider size -1.
	BlSpace simulateClickOn: child.
	self assert: slider currentValue equals: 50