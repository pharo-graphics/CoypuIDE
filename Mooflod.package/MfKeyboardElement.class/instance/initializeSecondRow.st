initialization
initializeSecondRow
	| theKeys |
	
	self addButton: (self wideKey: 'capslock' span: 1.8) key: KeyboardKey capsLock.

	theKeys := #(A S D F G H J K L) collect: [ :each | KeyboardKey perform: each ].
	theKeys do: [ :eachKey | self addButton: (self simpleKey: eachKey name) key: eachKey ].
	
	self addButton: (self simpleKey: ';') key: KeyboardKey semicolon.
	self addButton: (self simpleKey: '''') key: KeyboardKey quote.
	self addButton: (self wideKey: 'return' span: 1.8) key: KeyboardKey enter.