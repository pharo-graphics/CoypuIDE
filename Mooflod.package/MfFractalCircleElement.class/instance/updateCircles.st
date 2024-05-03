as yet unclassified
updateCircles

	currentX := 390.
	currentY := 390.
	1 to: value / 4 do: [ :i |
		currentX := currentX - 15.
		currentY := currentY - 15.
		self createCircle: currentX y: currentY ]