adding
addInstrument: aName

	nbTracks < 4 ifFalse: [ ^ self ].
	nbTracks := nbTracks +1.
	self initLevelRepresentation: aName