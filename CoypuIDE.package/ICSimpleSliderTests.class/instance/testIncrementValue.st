tests
testIncrementValue 

	self assert: slider currentValue equals: 0.
	slider incrementValue: 15.
	self assert: slider currentValue equals: 15.
	slider incrementValue: 50.
	self assert: slider currentValue equals: 50