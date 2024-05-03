action
decreaseInput
	"Check if the value is not 0, then create a new updated value"

	value > 0 ifTrue: [ value := value - 1 ].
	inputValue := self setInputValue: value