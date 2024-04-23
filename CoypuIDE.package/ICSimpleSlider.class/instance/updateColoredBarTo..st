as yet unclassified
updateColoredBarTo: aPosition

	self isHorizontal
		ifTrue: [
			coloredBar position:
				bar position.
			coloredBar size:
				(aPosition - coloredBar position) x @ barThickness ]
		ifFalse: [
			coloredBar position:
				aPosition x - (barThickness / 2) @ aPosition y.
			coloredBar size:
				barThickness @ (bar position x + barLength - aPosition y) ]