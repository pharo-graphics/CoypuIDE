tests
testSetsAtMinValue 

	slider incrementValue: 10.
	self deny: slider currentValue equals: slider minValue.
	slider setToMin.
	self assert: slider currentValue equals: slider minValue