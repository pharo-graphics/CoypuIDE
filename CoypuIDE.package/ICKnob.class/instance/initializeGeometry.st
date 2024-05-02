initialization
initializeGeometry

	| marker |
	self size: (diameter + 50) asPoint.
	self background: Color veryVeryLightGray.
	self clipChildren: false.
	self layout: BlFrameLayout new.
	self knob: (BlElement new
			 geometry: BlCircleGeometry new;
			 size: diameter asPoint;
			 clipChildren: false;
			 background: Color lightGray;
			 constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter ]).
	self addChild: self knob.
	marker := BlElement new
		          size: 4 @ 20;
		          transformDo: [ :t | t translateBy: -2 @ 0 ];
		          geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
		          background: Color darkGray;
		          position: diameter / 2 @ 5.
	self knob addChild: marker