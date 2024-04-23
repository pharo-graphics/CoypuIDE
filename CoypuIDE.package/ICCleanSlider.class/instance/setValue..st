api - slider
setValue: aValue

	(aValue < self maxValue and: [ aValue > self minValue ]) ifTrue: [
		self validatedValue: aValue ].