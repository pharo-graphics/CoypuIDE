accessing
clickAt: aPoint

	self removeChildWithId: 'current'.
	self
		addChild: (BlElement new
				 size: 4 asPoint;
				 background: Color red;
				 position: aPoint;
				 transformDo: [ :t | t translateBy: 2 asPoint negated ])
		as: 'current'.
	self valueAt: aPoint