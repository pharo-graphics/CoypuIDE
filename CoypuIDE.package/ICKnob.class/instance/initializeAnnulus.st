initialization
initializeAnnulus

	| annulus startSegment firstQuarterSegment middleSegment thirdQuarterSegment endSegment |
	annulus := BlElement new
		           background: Color black;
		           size: 150 asPoint.
	annulus geometry: (BlAnnulusSectorGeometry new
			 startAngle: 135;
			 endAngle: 45;
			 innerRadius: 0.7;
			 outerRadius: 0.74).

	startSegment := BlElement new
		                background: Color black;
		                size: 4 @ 10;
		                position: 30 @ 110.

	startSegment transformDo: [ :t | t rotateBy: 45 ].

	firstQuarterSegment := BlElement new
		                       background: Color black;
		                       size: 4 @ 10;
		                       position: 19 @ 49.

	firstQuarterSegment transformDo: [ :t | t rotateBy: -65 ].

	middleSegment := BlElement new
		                 background: Color black;
		                 size: 4 @ 10;
		                 position: 73 @ 10.

	thirdQuarterSegment := BlElement new
		                       background: Color black;
		                       size: 4 @ 10;
		                       position: 128 @ 48.
	thirdQuarterSegment transformDo: [ :t | t rotateBy: 65 ].
	endSegment := BlElement new
		              background: Color black;
		              size: 4 @ 10;
		              position: 116 @ 110.
	endSegment transformDo: [ :t | t rotateBy: -45 ].


	annulus clipChildren: false.
	annulus addChild: startSegment.
	annulus addChild: firstQuarterSegment.
	annulus addChild: middleSegment.
	annulus addChild: thirdQuarterSegment.
	annulus addChild: endSegment.
	self addChild: annulus