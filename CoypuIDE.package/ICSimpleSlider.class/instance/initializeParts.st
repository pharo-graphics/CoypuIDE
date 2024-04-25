initialization
initializeParts

	self bar: self defaultBar.
	self positionDefaultBar: self bar.
	self addChild: self bar.

	self coloredBar: self defaultColoredBar.
	self positionDefaultBar: self coloredBar.
	self addChild: self coloredBar.

	self handle: self defaultHandle.
	self positionDefaultHandle.
	self addChild: self handle

	"initialize segments if segmented"
	
	"self initializeButtons"