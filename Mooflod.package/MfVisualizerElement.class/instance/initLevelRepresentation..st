as yet unclassified
initLevelRepresentation: aChildren

	level == 1 ifTrue: [ self addElementsLevelOne: aChildren  ].
	level == 2 ifTrue: [ self addElementsLevelTwo: aChildren  ].
	level == 3 ifTrue: [ self addElementsLevelThree: aChildren  ].
	level == 4 ifTrue: [ self addElementsLevelFour: aChildren  ]