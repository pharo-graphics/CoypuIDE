tests
testDecrementValueUpdateUI

	slider currentValue: 25.
	self assert: slider handle position equals: slider size / 2.
	slider decrementValue: 10.
		self
			assert: slider handle position
			equals: slider size / 2 - (slider barLength / 5 @ 0).
	slider decrementValue: 50.
	self
		assert: slider handle position
		equals: slider marginLength @ (slider height / 2)