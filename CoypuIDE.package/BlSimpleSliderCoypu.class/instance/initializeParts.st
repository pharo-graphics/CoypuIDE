initialization
initializeParts

	self bar: self defaultBar.
	self positionDefaultBar.
	self addChild: self bar.

	self coloredBar: self defaultColoredBar.
	self positionDefaultColoredBar.
	self addChild: self coloredBar.

	self handle: self defaultHandle.
	self positionDefaultHandle.
	self addChild: self handle.

	