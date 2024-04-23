tests
testClickInsideBarChangesUI

	| child |
	child := BlElement new size: 0 @ 0.
	slider addChild: child.
	"The child lets us simulate a click on the slider on a specific position"
	"simulateClickOn: simulates a click in the middle of the element, thus the size 0@0 for the child"
	self skip.
	"this is not called, putting self fail into the block closure doesn't fail the test"
	slider whenLayoutedDoOnce: [
		child position: slider size / 2.
		BlSpace simulateClickOn: child.
		self assert: slider handle position equals: slider size / 2.
		self assert: slider coloredBar width equals: slider barLength / 2 ]