initialization
initializeSegments

	self segments: {
			(ICProportionnalSegment horizontalSegment
				 constraintsDo: [ :c | c proportional vertical bottom: (1/13).
	c proportional horizontal left: (1/7); right: (6/7).  ];
				 yourself).
			(ICProportionnalSegment verticalSegment
				 constraintsDo: [ :c | c proportional horizontal right: (1/7).
	c proportional vertical top: (1/13); bottom: (6/13) ];
				 yourself).
			(ICProportionnalSegment verticalSegment
				 constraintsDo: [ :c | c proportional horizontal left: (6/7).c proportional vertical top: (1/13); bottom: (6/13) ];
				 yourself).
			(ICProportionnalSegment horizontalSegment
				 constraintsDo: [ :c | c proportional vertical top: (6/13); bottom: (7/13).
	c proportional horizontal left: (1/7); right: (6/7).  ];
				 yourself).
			(ICProportionnalSegment verticalSegment
				 constraintsDo: [ :c | c proportional horizontal right: (1/7).
	c proportional vertical top: (7/13); bottom: (12/13) ];
				 yourself).
			(ICProportionnalSegment verticalSegment
				 constraintsDo: [ :c | c proportional horizontal left: (6/7).
	c proportional vertical top: (7/13); bottom: (12/13) ];
				 yourself).
			(ICProportionnalSegment horizontalSegment
				 constraintsDo: [ :c | c proportional horizontal left: (1/7); right: (6/7).
	c proportional vertical top: (12/13) ];
				 yourself) }.
	self addChildren: self segments