accessing
angle: aNumber

	angle := aNumber.
	aNumber < -135 ifTrue: [ angle := -135 ].
	aNumber > 135 ifTrue: [ angle := 135 ].

	"aNumber traceCr.
	angle traceCr.
	'=' traceCr."

	self knob transformDo: [ :t | t rotateBy: angle ].
	self currentValue: self angleToValue