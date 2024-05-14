initialization
initialize

	super initialize.

	self layout: BlFlowLayout new.
	self size: self keyboardWidth @ self keyboardHeight.
	self background: Color gray.

	keymap := Dictionary new.

	self initializeKeys.
	self initializeEventListeners.
	self requestFocus.