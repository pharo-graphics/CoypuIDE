accessing
angle: aNumber

	aNumber < -135 ifTrue: [
		angle := -135.
		^ self ].
	aNumber > 135 ifTrue: [
		angle := 135.
		^ self ].
	angle := aNumber.

	self currentValue: self angleToValue.