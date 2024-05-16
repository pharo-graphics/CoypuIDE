factory
verticalSegment

	| elt w h paint |
	h := 40.
	w := 8.
	paint := BlLinearGradientPaint new
		         stops: {
				         (0.0 -> Color lightGreen).
				         (0.5 -> Color lightGreen).
				         (1.0 -> Color lightGreen darker darker) };
		         start: 0 @ 0;
		         end: w @ 0;
		         yourself.
	elt := self new
		       widgetSize: w @ h;
		       frontPaint: paint.
	elt geometry: (BlPolygonGeometry vertices: {
				 (w @ (1 / 6 * h)).
				 (w @ (5 / 6 * h)).
				 (w / 2 @ h).
				 (0 @ (5 / 6 * h)).
				 (0 @ (1 / 6 * h)).
				 (w / 2 @ 0) }).

	^ elt