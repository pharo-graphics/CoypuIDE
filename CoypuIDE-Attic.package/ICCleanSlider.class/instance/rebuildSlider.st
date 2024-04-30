private - building
rebuildSlider

	self disabledRebuilding ifTrue: [ ^ self ].
	self buildSlider