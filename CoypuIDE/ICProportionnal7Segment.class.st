Class {
	#name : 'ICProportionnal7Segment',
	#superclass : 'BlElement',
	#instVars : [
		'segments',
		'digit'
	],
	#classVars : [
		'Digits'
	],
	#category : 'CoypuIDE-led / 7segment',
	#package : 'CoypuIDE',
	#tag : 'led / 7segment'
}

{ #category : 'examples' }
ICProportionnal7Segment class >> animatedExample [

	<script>
	| space elt |
	space := BlSpace new extent: 120 @ 250.
	elt := self new.

	elt constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	space root addChild: elt.
	space show.

	0 to: 9 do: [ :i |
		1 second wait.
		elt digit: i ].
	1 second wait.
	elt digit: nil
]

{ #category : 'examples' }
ICProportionnal7Segment class >> example [

	<script>
	| space segment |
	space := BlSpace new extent: 120 @ 250.
	segment := ICProportionnal7Segment new digit: 5.

	segment constraintsDo: [ :c |
		c vertical matchParent.
		c horizontal matchParent ].

	space root addChild: segment.

	space show
]

{ #category : 'as yet unclassified' }
ICProportionnal7Segment class >> fullExampleMatch [

	<script>
	| container space |
	container := BlElement new
		             layout: BlLinearLayout horizontal;
		             constraintsDo: [ :c |
			             c vertical matchParent.
			             c horizontal matchParent ].

	container addChild: (self new constraintsDo: [ :c |
			 c horizontal matchParent.
			 c vertical matchParent ]).
	0 to: 10 do: [ :i |
		| child |
		child := self new
			         digit: i;
			         constraintsDo: [ :c |
				         c vertical matchParent.
				         c horizontal matchParent ].
		container addChild: child ].

	space := BlSpace new extent: 800 @ 150.
	space root addChild: container.
	space show
]

{ #category : 'class initialization' }
ICProportionnal7Segment class >> initialize [

	Digits := {
		          { true. true. true. false. true. true. true }. "0"
		          { false. false. true. false. false. true. false }. "1"
		          { true. false. true. true. true. false. true }. "2"
		          { true. false. true. true. false. true. true }. "3"
		          { false. true. true. true. false. true. false }. "4"
		          { true. true. false. true. false. true. true }. "5"
		          { true. true. false. true. true. true. true }. "6"
		          { true. false. true. false. false. true. false }. "7"
		          { true. true. true. true. true. true. true }. "8"
		          { true. true. true. true. false. true. true } "9"}
]

{ #category : 'accessing' }
ICProportionnal7Segment >> digit [ 

	^ digit
]

{ #category : 'accessing' }
ICProportionnal7Segment >> digit: aNumber [

	aNumber ifNil: [ self segments do: [ :seg | seg switchOff ]. ^ self ].
	digit := aNumber % 10.
	self update
]

{ #category : 'initialization' }
ICProportionnal7Segment >> initialize [

	super initialize.
	self background: Color veryDarkGray.
	self size: 60 @ 100.
	self clipChildren: false.
	self padding: (BlInsets all: 5).
	self layout: BlProportionalLayout new.
	self initializeSegments
]

{ #category : 'initialization' }
ICProportionnal7Segment >> initializeSegments [

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
]

{ #category : 'accessing' }
ICProportionnal7Segment >> segments [ 

	^ segments
]

{ #category : 'accessing' }
ICProportionnal7Segment >> segments: aCollection [

	segments := aCollection
]

{ #category : 'as yet unclassified' }
ICProportionnal7Segment >> switchOff [ 

self segments do: [ :seg | seg switchOff ].
]

{ #category : 'updating' }
ICProportionnal7Segment >> update [ 

	self segments with: (Digits at: digit + 1) do: [ :seg :bool |
		seg lit: bool. ]
]
