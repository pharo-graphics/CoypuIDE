factory
verticalSegment
	"| elt w h paint |
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
	elt whenLayoutedDo: [
		| geometry |
		geometry := BlPolygonGeometry vertices: {
				            (0 @ (1 / 12 * elt height)).
				            (elt width / 2 @ (-1 / 12 * elt height)).
				            (elt width @ (1 / 12 * elt height)).
				            (elt width @ (11 / 12 * elt height)).
				            (elt width / 2 @ (13 / 12 * elt height)).
				            (0 @ (11 / 12 * elt height)) }.
		elt geometry: geometry.
		elt widgetSize: elt width @ elt height ]."

	| elt |
	elt := self new beVertical yourself.

	^ elt