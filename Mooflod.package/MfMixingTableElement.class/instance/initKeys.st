accessing
initKeys

	| keys |
	keys := #( Q W E R T Y U I O P ). keys do: [ :eachKey |
		        self addButton: MfMixingButtonElement new key: eachKey ].
	self initEventListeners