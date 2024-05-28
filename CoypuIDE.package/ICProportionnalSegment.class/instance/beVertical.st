accessing
beVertical

	| paint |
	self widgetSize: self widgetSize y @ self widgetSize x.
	paint := BlLinearGradientPaint new
		         stops: {
				         (0.0 -> Color lightGreen).
				         (0.5 -> Color lightGreen).
				         (1.0 -> Color lightGreen darker darker) };
		         start: 0 @ 0;
		         end: self widgetSize x @ 0;
		         yourself.
	self frontPaint: paint.
	
self whenLayoutedDo: [
		| geometry |
		geometry := BlPolygonGeometry vertices: {
				            (0 @ (1 / 12 * self height)).
				            (self width / 2 @ (-1 / 12 * self height)).
				            (self width @ (1 / 12 * self height)).
				            (self width @ (11 / 12 * self height)).
				            (self width / 2 @ (13 / 12 * self height)).
				            (0 @ (11 / 12 * self height)) }.
		self geometry: geometry.
		self widgetSize: self width @ self height ].