tests
testBuildHorizontalStartsAtMinValue

	self assert: slider isHorizontal.
	self assert: slider currentValue equals: slider minValue 