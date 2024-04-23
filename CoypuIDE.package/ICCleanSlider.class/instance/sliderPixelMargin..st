accessing
sliderPixelMargin: anObject

	sliderPixelMargin := anObject.
	self isSliderBuilt ifTrue: [ 
		self rebuildSlider ]