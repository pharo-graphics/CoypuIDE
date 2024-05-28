initialization
initializeDefaultPaints

	| paint |
	self backPaint: Color black.

	paint := BlLinearGradientPaint vertical
		         from: Color lightGreen
		         to: Color lightGreen  muchDarker.

	self frontPaint: paint