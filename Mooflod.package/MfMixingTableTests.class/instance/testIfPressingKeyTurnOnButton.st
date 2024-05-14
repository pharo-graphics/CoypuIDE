tests
testIfPressingKeyTurnOnButton

	| m |
	m := MfMixingTableElement new
		     nbButtons: 10;
		     nbButtonPerRow: 5.
	"Here we simulate a press on the left key"
	BlSpace simulateKeyDownOn: m key: KeyboardKey Q.
	"Check if his color has changed"
	self
		assert: (m children at: 1) background paint color
		equals: Color red