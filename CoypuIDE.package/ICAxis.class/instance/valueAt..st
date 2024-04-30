accessing
valueAt: aPoint

	self valueX: (self valueAtX: aPoint x).
	self valueY: (self valueAtY: aPoint y).
	self callBack ifNotNil: [ :c | c value: valueX value: valueY ]