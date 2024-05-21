as yet unclassified
updateDisplayedValue

	1 to: self nbDigits do: [ :i |
		| newValue |
		newValue := self value // (10 raisedTo: i - 1) % 10.
		(self digitElements at: self nbDigits - i+1) digit: newValue ]