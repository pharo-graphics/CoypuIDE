buttons
changeValueTo: aValue

	inputValue text: (self configuredString: aValue asString).
	inputValue text fontSize: 30.
	value := aValue