tests
testDecrementValue 

	slider currentValue: 30.
	self assert: slider currentValue equals: 30.
	slider decrementValue: 15.
	self assert: slider currentValue equals: 15.
	slider decrementValue: 50.
	self assert: slider currentValue equals: 0