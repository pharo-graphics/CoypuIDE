initialization
initializeBottomRow
	"add all keys from the bottom row of keyboard"
	self addButton: (self simpleSmallKey: 'fn') key: KeyboardKey function.
	self addButton: (self simpleSmallKey: 'control') key: KeyboardKey controlLeft.
	self addButton: (self simpleSmallKey: 'option') key: KeyboardKey altLeft.
	self addButton: (self wideSmallKey: 'command' span: 1.2) key: KeyboardKey superLeft.
	self addButton: (self wideSmallKey: '' span: 4.5) key: KeyboardKey space.
	self addButton: (self wideSmallKey: 'command' span: 1.2) key: KeyboardKey superRight.
	self addButton: (self simpleSmallKey: 'option') key: KeyboardKey altRight.
	
	self addButton: (self simpleSmallKey: 'left') key: KeyboardKey left.
	self addButton: (self simpleSmallKey: 'up') key: KeyboardKey up.
	self addButton: (self simpleSmallKey: 'right') key: KeyboardKey right.
	self addButton: (self simpleSmallKey: 'down') key: KeyboardKey down.