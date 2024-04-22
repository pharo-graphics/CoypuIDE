as yet unclassified
updateColoredBar

	self isHorizontal
		ifTrue: [
			coloredBar position:
				bar position.
			coloredBar size:
				(handle position - coloredBar position) x @ barThickness ]
		ifFalse: [
			coloredBar position:
				handle position x - (barThickness / 2) @ handle position y.
			coloredBar size:
				barThickness @ (bar position x + barLength - handle position y) ]