api - transformations
valueAtY: aNumber

	| range value coeff |
	aNumber = 0 ifTrue: [ ^ 0 ].
	range := maxY - minY.
	coeff := self height / aNumber.
	value := maxY - (range / coeff).

	^ value asFloat