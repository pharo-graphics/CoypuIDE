initialization
initializeThirdRow
	| theKeys |
	"add all keys in the third row, for example the shift left key is a big key
	so we add it as a wideKey"
	self addButton: (self wideKey: 'shift' span: 2.42) key: KeyboardKey shiftLeft.
	
	theKeys := #(Z X C V B N M) collect: [ :each | KeyboardKey perform: each ].
	theKeys do: [ :eachKey | self addButton: (self simpleKey: eachKey name) key: eachKey ].
	
	self addButton: (self simpleKey: ',') key: KeyboardKey comma.
	self addButton: (self simpleKey: '.') key: KeyboardKey period.
	self addButton: (self simpleKey: '/') key: KeyboardKey slash.
	
	self addButton: (self wideKey: 'shift' span: 2.42) key: KeyboardKey shiftRight.