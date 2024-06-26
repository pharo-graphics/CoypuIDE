Class {
	#name : 'IC7Segment',
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
IC7Segment class >> animatedExample [

	<script>
	| elt |
	elt := self new.

	elt openInSpace.

	0 to: 9 do: [ :i |
		1 second wait.
		elt digit: i ].
	1 second wait. 
	elt digit: nil
]

{ #category : 'examples' }
IC7Segment class >> example [

	<script> 
	self new
		digit: 5;
		openInSpace
]

{ #category : 'as yet unclassified' }
IC7Segment class >> fullExample [

	<script>
	| container |
	container := BlElement new
		             layout: BlLinearLayout horizontal;
		             constraintsDo: [ :c |
			             c vertical fitContent.
			             c horizontal fitContent ].

	container addChild: self new.
	0 to: 10 do: [ :i | container addChild: (self new digit: i) ].

	container openInSpace
]

{ #category : 'class initialization' }
IC7Segment class >> initialize [

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
IC7Segment >> digit [ 

	^ digit
]

{ #category : 'accessing' }
IC7Segment >> digit: aNumber [

	aNumber ifNil: [ self segments do: [ :seg | seg switchOff ]. ^ self ].
	digit := aNumber % 10.
	self update
]

{ #category : 'initialization' }
IC7Segment >> initialize [

	super initialize.
	self background: Color veryDarkGray.
	self size: 60 @ 100.
	self clipChildren: false.
	self initializeSegments
]

{ #category : 'initialization' }
IC7Segment >> initializeSegments [

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
]

{ #category : 'accessing' }
IC7Segment >> segments [ 

	^ segments
]

{ #category : 'accessing' }
IC7Segment >> segments: aCollection [

	segments := aCollection
]

{ #category : 'as yet unclassified' }
IC7Segment >> switchOff [ 

self segments do: [ :seg | seg switchOff ].
]

{ #category : 'updating' }
IC7Segment >> update [ 

	self segments with: (Digits at: digit + 1) do: [ :seg :bool |
		seg lit: bool. ]
]
