initialization
initializeKeys
	"create the keys that will be associated to buttons"

	| keys |
	"The key binding are using the physical position so that it works on any keyboard (the key Q on qwerty is the same as the key A on Azerty)."
	keys := #( Q W E R T Y U I A S D F G H J K ) collect: [ :each |
		        KeyboardKey perform: each ].
	keys do: [ :eachKey |
		self addButton: MfMixingButtonElement new key: eachKey ].
	self initializeEventListeners