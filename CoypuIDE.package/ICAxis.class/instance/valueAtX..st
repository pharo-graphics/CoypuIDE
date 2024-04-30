api - transformations
valueAtX: aNumber

	| range value coeff |
	aNumber = 0 ifTrue: [ ^ 0 ].
	range := maxX - minX.
	coeff := self width / aNumber.
	value := minX + (range / coeff).

	^ value asFloat