initialization
initializeDefaultGeometry 

	|w h|
	w := 40.
	h := 8.
	self widgetSize: w @ h.
	self geometry: (BlPolygonGeometry vertices: {
				 (1 / 6 * w @ 0).
				 (5 / 6 * w @ 0).
				 (w @ (h / 2)).
				 (5 / 6 * w @ h).
				 (1 / 6 * w @ h).
				 (0 @ (h / 2)) }).