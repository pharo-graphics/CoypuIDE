initialization
initializeDefaultPaints

	| paint |
	self backPaint: Color black.

	paint := BlLinearGradientPaint new
		         stops: {
				         (0.0 -> Color lightGreen).
				         (0.5 -> Color lightGreen).
				         (1.0 -> Color lightGreen darker darker) };
		         start: 0 @ 0;
		         end: 0 @ self widgetSize y;
		         yourself.
	self frontPaint: paint