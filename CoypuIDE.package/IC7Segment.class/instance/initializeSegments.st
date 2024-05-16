initialization
initializeSegments

	self segments: {
			(ICSegment horizontalSegment
				 position: 10 @ 5;
				 yourself).
			(ICSegment verticalSegment
				 position: 5 @ 10;
				 yourself).
			(ICSegment verticalSegment
				 position: 47 @ 10;
				 yourself).
			(ICSegment horizontalSegment
				 position: 10 @ 46;
				 yourself).
			(ICSegment verticalSegment
				 position: 5 @ 50;
				 yourself).
			(ICSegment verticalSegment
				 position: 47 @ 50;
				 yourself).
			(ICSegment horizontalSegment
				 position: 10 @ 87;
				 yourself) }.
	self addChildren: self segments