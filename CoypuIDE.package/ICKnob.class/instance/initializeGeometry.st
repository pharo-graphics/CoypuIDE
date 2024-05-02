initialization
initializeGeometry

	self size: (radius + 50) asPoint.
	self background: Color veryVeryLightGray.
	self knob: (BlElement new
			 geometry: BlCircleGeometry new;
			 size: radius asPoint;
			 position: 25 asPoint;
			 background: Color lightGray).
	self addChild: self knob