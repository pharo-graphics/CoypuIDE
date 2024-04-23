api - transformations
valueToY: aNumber

	| dist valueDiff coeff |
	valueDiff := aNumber - minValue.
	coeff := valueDiff / (maxValue - minValue).
	dist := marginThickness + barLength - (coeff * barLength).
	self forceLocalLayout.
	"This is needed so handle position != 0"
	^ handle position x @ dist