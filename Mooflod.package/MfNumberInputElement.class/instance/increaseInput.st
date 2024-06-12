buttons
increaseInput

	(validateValueBlock value: value + 1) ifTrue: [
		value := value + 1.
		self changeValueTo: value ]