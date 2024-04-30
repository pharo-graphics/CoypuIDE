as yet unclassified
buildAxis

	| vertical w h horizontal |
	w := self widgetSize x.
	h := self widgetSize y.
	self removeChildWithId: 'xAxis'.
	self removeChildWithId: 'yAxis'.

	vertical := BlElement new
		            size: 10 @ h;
		            background: Color black;
		            position: -5 @ 0;
		            geometry: (BlPolygonGeometry vertices: {
						             (5 @ 0).
						             (10 @ 10).
						             (6 @ 10).
						             (6 @ h).
						             (4 @ h).
						             (4 @ 10).
						             (0 @ 10) }).

	horizontal := BlElement new
		              size: w @ 10;
		              background: Color black;
		              position: 0 @ (h - 5);
		              geometry: (BlPolygonGeometry vertices: {
						               (0 @ 4).
						               (w - 10 @ 4).
						               (w - 10 @ 0).
						               (w @ 5).
						               (w - 10 @ 10).
						               (w - 10 @ 6).
						               (0 @ 6) }).

	self addChild: vertical as: 'yAxis'.
	self addChild: horizontal as: 'xAxis'.
	
	self buildAxisText