updating
update

	self
		background: (self isLit
		ifTrue: [ self frontPaint ]
		ifFalse: [ self backPaint ])