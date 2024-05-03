as yet unclassified
redefineKeys: keys

	| v |
	v := keymap values.
	keymap := Dictionary new.
		keys withIndexDo: [ :key :index |
			| elem |
			elem := v at: index.
			keymap at: key put: elem ] .
	self initEventListeners