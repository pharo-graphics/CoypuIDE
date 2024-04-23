accessing
currentValue: aNumber

	(aNumber < self minValue or: [ aNumber > self maxValue ]) ifTrue: [ ^ self ].
	currentValue := aNumber