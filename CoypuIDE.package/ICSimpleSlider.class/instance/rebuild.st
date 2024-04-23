building
rebuild 

	self isHorizontal ifTrue: [ self buildHorizontal ] ifFalse: [ self buildVertical ]