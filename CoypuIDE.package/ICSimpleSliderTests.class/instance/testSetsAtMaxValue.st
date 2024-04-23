tests
testSetsAtMaxValue 

	self deny: slider currentValue equals: slider maxValue.
	slider setToMax.
	self assert: slider currentValue equals: slider maxValue