accessing
currentValue: aNumber

	currentValue := aNumber.
	aNumber < self minValue ifTrue:[ currentValue := minValue].
	aNumber > self maxValue ifTrue: [ currentValue := maxValue].
	