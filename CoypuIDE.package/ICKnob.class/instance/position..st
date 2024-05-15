api - bounds
position: aPoint

	super position: aPoint.
	self whenLayoutedDoOnce: [
	self centerPosition: self positionInSpace + (self size / 2)]