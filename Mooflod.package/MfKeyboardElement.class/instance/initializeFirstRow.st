initialization
initializeFirstRow
	| theKeys |
	"add all keys from first row to the keys dico"
	self addButton: (self wideKey: 'tab' span: 1.45) key: KeyboardKey tab.
	
	theKeys := #(Q W E R T Y U I O P) collect: [ :each | KeyboardKey perform: each ].
	theKeys do: [ :eachKey | self addButton: (self simpleKey: eachKey name) key: eachKey ].
	
	self addButton: (self simpleKey: '[') key: KeyboardKey bracketLeft.
	self addButton: (self simpleKey: ']') key: KeyboardKey bracketRight.
	self addButton: (self simpleKey: '\') key: KeyboardKey backslash.