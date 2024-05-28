initialization
initializeDefaultGeometry

	| w h |
	w := 40.
	h := 8.
	self widgetSize: w @ h.
	self whenLayoutedDo: [ "self geometry: (BlPolygonGeometry vertices: {
				 (1 / 6 * w @ 0).
				 (5 / 6 * w @ 0).
				 (w @ (h / 2)).
				 (5 / 6 * w @ h).
				 (1 / 6 * w @ h).
				 (0 @ (h / 2)) })"
		| geometry |
		geometry := BlPolygonGeometry vertices: {
				            ((1/12 * self width) @ 0).
				            ((11/12 *self width) @ 0).
				            (13 / 12 * self width @ (self height / 2)).
				            ((11/12 *self width) @ self height).
				            ((1/12 * self width) @ self height).
				            (-1 / 12 * self width @ (self height / 2)) }.
		self geometry: geometry.
		self widgetSize: self width @ self height ]