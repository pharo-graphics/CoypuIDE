as yet unclassified
initLevelRepresentation: aName

	level == 1 ifTrue: [ self addElementsLevelOne: aName ].
	level == 2 ifTrue: [ self addElementsLevelTwo: aName].
	level == 3 ifTrue: [ self addElementsLevelThree: aName ].
	level == 4 ifTrue: [ self addElementsLevelFour: aName ]