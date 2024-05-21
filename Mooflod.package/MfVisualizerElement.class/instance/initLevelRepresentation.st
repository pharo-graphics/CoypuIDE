as yet unclassified
initLevelRepresentation
	level == 1 ifTrue: [ self addElementsLevelOne].
		level == 2 ifTrue: [ self addElementsLevelTwo ].
			level == 3 ifTrue: [ self addElementsLevelThree ].
	level == 4 ifTrue: [ self addElementsLevelFour ].
	