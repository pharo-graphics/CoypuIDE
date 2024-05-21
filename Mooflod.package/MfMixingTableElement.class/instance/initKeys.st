accessing
initKeys
	"create the keys that will be associated to buttons"

	| keys |
	keys := #( Q W E R T Y U I A S D F G H J K ) collect: [ :each |
		        KeyboardKey perform: each ].
	keys do: [ :eachKey |
		self addButton: MfMixingButtonElement new key: eachKey ].
	self initEventListeners