initialization
initializeTopRow
	| theKeys |
	
	self addButton: (self simpleKey: '`') key: KeyboardKey grave.
	
	theKeys := #(one two three four five six seven eight nine zero) collect: [ :each | KeyboardKey perform: each ].
	theKeys do: [ :eachKey | self addButton: (self simpleKey: eachKey name) key: eachKey ].
	
	self addButton: (self simpleKey: '-') key: KeyboardKey minus.
	self addButton: (self simpleKey: '=') key: KeyboardKey equal.
	self addButton: (self wideKey: 'delete' span: 1.45) key: KeyboardKey backspace.