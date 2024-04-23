building
rebuild

	self
		ifHorizontal: [ self buildHorizontal ]
		ifVertical: [ self buildVertical ]