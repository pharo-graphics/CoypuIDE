accessing
digit: aNumber

	aNumber ifNil: [ self segments do: [ :seg | seg switchOff ]. ^ self ].
	digit := aNumber % 10.
	self update