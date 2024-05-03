accessing
clickAt: aPoint

	| center vector newAngle |
	center := self knob position + (diameter / 2).
	vector := aPoint - center.
	self halt.
	newAngle := (vector angleWith: 0 @ -1) * 180.
	self angle: newAngle