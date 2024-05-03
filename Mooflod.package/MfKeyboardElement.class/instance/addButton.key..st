initialization
addButton: anElement key: aKey
	"add the key passed as parameter to the key dictionnary"
	keymap at: aKey put: anElement.
	self addChild: anElement