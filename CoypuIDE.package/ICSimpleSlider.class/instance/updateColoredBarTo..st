as yet unclassified
updateColoredBarTo: aPosition

	self
		ifHorizontal: [
			coloredBar position: bar position.
			coloredBar size: (aPosition - coloredBar position) x @ barThickness ]
		ifVertical: [
			coloredBar position: aPosition x - (barThickness / 2) @ aPosition y.
			coloredBar size:
				barThickness @ (bar position y + barLength - aPosition y) ]