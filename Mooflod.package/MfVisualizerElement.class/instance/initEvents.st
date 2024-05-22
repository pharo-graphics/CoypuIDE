as yet unclassified
initEvents

	self childrenDo: [ :c |
		c addEventHandlerOn: BlMouseDownEvent do: [ :e |
			nbTracks < 4 & c children isEmpty ifTrue: [
				nbTracks := nbTracks + 1.
				self initLevelRepresentation: c ] ] ]