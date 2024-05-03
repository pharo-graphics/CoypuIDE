adding
addStepsToThePattern: nbSteps
	"Add all bars element in the pattern to display them"

	| step changingX |
	nbOfSteps := 0.
	changingX := 2.5.
	(nbSteps between: min and: max) ifTrue: [
		nbOfSteps := nbSteps.
		1 to: nbSteps do: [ :i |
			step := MfStepElement new.
			step transformDo: [ :t | t translateBy: changingX @ 0 ].
			changingX := changingX + 35.
			self addChild: step ] ].
	self size: 35 * nbSteps @ 60.
	self addInstrumentToStep