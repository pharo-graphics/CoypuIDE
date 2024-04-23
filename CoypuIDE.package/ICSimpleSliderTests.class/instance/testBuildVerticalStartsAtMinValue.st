tests
testBuildVerticalStartsAtMinValue

	slider := ICSimpleSlider beVertical.
	self deny: slider isHorizontal.
	self assert: slider currentValue equals: slider minValue 