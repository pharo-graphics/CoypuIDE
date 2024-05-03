as yet unclassified
updateSquare

	currentY := 0.
	1 to: value do: [ :i |
		currentY := currentY + 2.
		self updateFill: currentY ]