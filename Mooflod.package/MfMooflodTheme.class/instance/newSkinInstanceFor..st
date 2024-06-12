accessing
newSkinInstanceFor: anElement

	| space |
	space := anElement space.
	^ (space notNil and: [ space root == anElement ])
		  ifTrue: [ self newRootSkinInstance ]
		  ifFalse: [ anElement newMooflodSkin ]