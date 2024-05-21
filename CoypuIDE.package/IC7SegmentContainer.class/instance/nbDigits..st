evaluating
nbDigits: aNumber

	aNumber = nbDigits ifTrue: [ ^ self ].
	nbDigits := aNumber.
	self initializeDigitElements