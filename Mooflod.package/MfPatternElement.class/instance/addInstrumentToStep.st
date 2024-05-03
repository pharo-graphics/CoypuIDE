adding
addInstrumentToStep
	"Change the value of the drum attribute for the bar clicked, and update his color for visualization undestanding"

	self childrenDo: [ :child |
		child addEventHandlerOn: BlMouseDownEvent do: [ :evt |
			child instrument not
				ifTrue: [
					child background: Color black.
					child assignInstrument  ]
				ifFalse: [
					child background: Color white.
					child removeInstrument  ] ] ]