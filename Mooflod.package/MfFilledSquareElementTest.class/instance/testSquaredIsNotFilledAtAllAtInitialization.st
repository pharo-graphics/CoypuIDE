tests
testSquaredIsNotFilledAtAllAtInitialization

	| square |
	square := MfFilledSquareElement new.
	self assert: square currentY equals: 0 