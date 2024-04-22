api - bounds
size: aValue

	super size: aValue.
	self widgetSize: aValue.
	self isSliderBuilt ifTrue: [ self rebuildSlider ]