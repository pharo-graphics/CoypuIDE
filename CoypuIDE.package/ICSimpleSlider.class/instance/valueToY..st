api - transformations
valueToY: aNumber

	| dist valueDiff coeff |
	valueDiff := aNumber - minValue.
	coeff := valueDiff / (maxValue - minValue).
	dist := marginThickness + barLength - (coeff * barLength).
	^ marginThickness @ dist