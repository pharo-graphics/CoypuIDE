accessing
angle: aNumber

	| tmp |
	tmp := aNumber.
	aNumber >= 180 ifTrue: [ tmp := aNumber - 360 ].
	angle := tmp.
	tmp < -135 ifTrue: [ angle := -135 ].
	tmp > 135 ifTrue: [ angle := 135 ].

	self knob transformDo: [ :t | t rotateBy: angle ].
	self currentValue: self angleToValue