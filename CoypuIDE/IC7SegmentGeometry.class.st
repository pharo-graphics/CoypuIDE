Class {
	#name : 'IC7SegmentGeometry',
	#superclass : 'BlPolygonGeometry',
	#instVars : [
		'isVertical'
	],
	#category : 'CoypuIDE-led / 7segment',
	#package : 'CoypuIDE',
	#tag : 'led / 7segment'
}

{ #category : 'factory' }
IC7SegmentGeometry class >> horizontal [

	^ self new beHorizontal 
]

{ #category : 'factory' }
IC7SegmentGeometry class >> vertical [

	^ self new beVertical 
]

{ #category : 'initialization' }
IC7SegmentGeometry >> beHorizontal [ 

	isVertical := false
]

{ #category : 'initialization' }
IC7SegmentGeometry >> beVertical [

	isVertical := true
]

{ #category : 'initialization' }
IC7SegmentGeometry >> initialize [

	super initialize.
	isVertical := false.
]

{ #category : 'geometry' }
IC7SegmentGeometry >> matchExtent: anExtent [

	extent := anExtent.
	vertices := isVertical
		            ifTrue: [
			            {
				            (0 @ (1 / 12 * anExtent y)).
				            (anExtent x / 2 @ (-1 / 12 * anExtent y)).
				            (anExtent x @ (1 / 12 * anExtent y)).
				            (anExtent x @ (11 / 12 * anExtent y)).
				            (anExtent x / 2 @ (13 / 12 * anExtent y)).
				            (0 @ (11 / 12 * anExtent y)) } ]
		            ifFalse: [
			            {
				            (1 / 12 * anExtent x @ 0).
				            (11 / 12 * anExtent x @ 0).
				            (13 / 12 * anExtent x @ (anExtent y / 2)).
				            (11 / 12 * anExtent x @ anExtent y).
				            (1 / 12 * anExtent x @ anExtent y).
				            (-1 / 12 * anExtent x @ (anExtent y / 2)) } ]
]
