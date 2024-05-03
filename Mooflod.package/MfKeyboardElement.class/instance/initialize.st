initialization
initialize
	super initialize.
	
	self layout: BlFlowLayout new.
	self size: self keyboardWidth @ self keyboardHeight.
	self background: (Color gray alpha: 0.1).
	
	keymap := Dictionary new.
	
	self initializeKeys.
	self initializeEventListeners.
	self requestFocus