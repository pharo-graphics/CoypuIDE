accessing
beVertical

	| paint |
	"self widgetSize: self widgetSize y @ self widgetSize x."
	paint := BlLinearGradientPaint horizontal from: Color lightGreen to: Color lightGreen darker darker.
	
		       
	self frontPaint: paint.

	self geometry: IC7SegmentGeometry vertical