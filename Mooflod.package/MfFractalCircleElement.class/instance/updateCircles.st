as yet unclassified
updateCircles

	| c |
	c := 1.
	currentX := 390.
	currentY := 390.
	1 to: value / 4 do: [ :i |
		c := c - 0.04.
		currentX := currentX - 15.
		currentY := currentY - 15.
		self createCircle: currentX y: currentY color: c ]