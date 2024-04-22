as yet unclassified
moveHandleTo: aPosition

	| newPos |
	newPos := aPosition.
	self isHorizontal
		ifTrue: [
			| newPosX |
			newPosX := newPos x.
			newPos x < bar position x ifTrue: [ newPosX := bar position x ].
			newPos x > (bar position x + barLength) ifTrue: [
				newPosX := bar position x + barLength ].
			handle position: newPosX @ handle position y ]
		ifFalse: [
			| newPosY |
			newPosY := newPos y.
			newPos y < bar position y ifTrue: [ newPosY := bar position y ].
			newPos y > (bar position y + barLength) ifTrue: [
				newPosY := bar position y + barLength ].
			handle position: handle position x @ newPosY ].
	self updateColoredBar.
	self updateValue