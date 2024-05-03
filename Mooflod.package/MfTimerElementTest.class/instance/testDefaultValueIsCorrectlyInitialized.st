tests
testDefaultValueIsCorrectlyInitialized

	| timer |
	
	timer := MfTimerElement new value: 20.
	self assert: timer value equals: 20