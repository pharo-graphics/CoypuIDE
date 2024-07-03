Class {
	#name : 'IC7SegmentContainer',
	#superclass : 'BlElement',
	#instVars : [
		'value',
		'nbDigits',
		'digitElements'
	],
	#category : 'CoypuIDE-led / 7segment',
	#package : 'CoypuIDE',
	#tag : 'led / 7segment'
}

{ #category : 'examples' }
IC7SegmentContainer class >> basicExample [ 

	<script>
	self new value: 12345; openInSpace
]

{ #category : 'examples' }
IC7SegmentContainer class >> basicExampleGetsValueChanged [

	<script>
	| elt |
	elt := self new
		       value: 12345;
		       openInSpace;
		       yourself.
		
	1 second wait.
	elt value: 12.
]

{ #category : 'as yet unclassified' }
IC7SegmentContainer class >> truncatedExample [ 

	<script> 
	
	self new value: 12345678; openInSpace
]

{ #category : 'as yet unclassified' }
IC7SegmentContainer class >> truncatedExampleGetsResized [

	<script>
	| elt |
	elt := self new
		       value: 12345678;
		       openInSpace;
		       yourself.

	1 seconds wait.
	elt nbDigits: 8
]

{ #category : 'evaluating' }
IC7SegmentContainer >> digitElements [ 

	^ digitElements
]

{ #category : 'evaluating' }
IC7SegmentContainer >> digitElements: aCollection [

	digitElements := aCollection 
]

{ #category : 'initialization' }
IC7SegmentContainer >> initialize [

	super initialize.
	self layout: BlLinearLayout horizontal.
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	value := 0.
	self nbDigits: 5
]

{ #category : 'initialization' }
IC7SegmentContainer >> initializeDigitElements [

	| elts |
	elts := OrderedCollection new.
	self digitElements ifNotNil: [ :e | self removeChildren: e].
	1 to: nbDigits do: [ :i |
		| elt |
		elt := IC7Segment new.
		elts add: elt.
		self addChild: elt ].
	self digitElements: elts.
	self updateDisplayedValue
]

{ #category : 'evaluating' }
IC7SegmentContainer >> nbDigits [ 

	^ nbDigits 
]

{ #category : 'evaluating' }
IC7SegmentContainer >> nbDigits: aNumber [

	aNumber = nbDigits ifTrue: [ ^ self ].
	nbDigits := aNumber.
	self initializeDigitElements
]

{ #category : 'as yet unclassified' }
IC7SegmentContainer >> updateDisplayedValue [

	1 to: self nbDigits do: [ :i |
		| newValue |
		newValue := self value // (10 raisedTo: i - 1) % 10.
		(self digitElements at: self nbDigits - i+1) digit: newValue ]
]

{ #category : 'evaluating' }
IC7SegmentContainer >> value [ 

	^ value 
]

{ #category : 'evaluating' }
IC7SegmentContainer >> value: aNumber [

	value := aNumber.
	self updateDisplayedValue
]
