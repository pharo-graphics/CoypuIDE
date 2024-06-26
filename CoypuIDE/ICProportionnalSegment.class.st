Class {
	#name : 'ICProportionnalSegment',
	#superclass : 'BlElement',
	#instVars : [
		'lit',
		'backPaint',
		'frontPaint'
	],
	#category : 'CoypuIDE-led / 7segment',
	#package : 'CoypuIDE',
	#tag : 'led / 7segment'
}

{ #category : 'factory' }
ICProportionnalSegment class >> horizontalExample [

	<script>
	| elt |
	elt := self horizontalSegment size: 80@20.
	
	elt position: 50 asPoint.
	elt
		addEventHandlerOn: BlClickEvent
		do: [ :e | elt lit: elt isLit not ].
		
	elt openInSpace
]

{ #category : 'factory' }
ICProportionnalSegment class >> horizontalSegment [

	^ self new.
]

{ #category : 'factory' }
ICProportionnalSegment class >> verticalExample [

	<script>
	| elt |
	elt := self verticalSegment size: 20 @ 80.

	elt position: 50 asPoint.

	elt
		addEventHandlerOn: BlClickEvent
		do: [ :e | elt lit: elt isLit not ].

	elt openInSpace
]

{ #category : 'factory' }
ICProportionnalSegment class >> verticalSegment [

	| elt paint |

	paint := BlLinearGradientPaint horizontal
		         from: Color lightGreen
		         to: Color lightGreen muchDarker.

	elt := self new beVertical frontPaint: paint.


	^ elt
]

{ #category : 'accessing' }
ICProportionnalSegment >> backPaint [ 

	^ backPaint 
]

{ #category : 'accessing' }
ICProportionnalSegment >> backPaint: aBlPaint [

	backPaint := aBlPaint 
]

{ #category : 'accessing' }
ICProportionnalSegment >> beVertical [

	| paint |
	"self widgetSize: self widgetSize y @ self widgetSize x."
	paint := BlLinearGradientPaint horizontal from: Color lightGreen to: Color lightGreen darker darker.
	
		       
	self frontPaint: paint.

	self geometry: IC7SegmentGeometry vertical
]

{ #category : 'accessing' }
ICProportionnalSegment >> frontPaint [

	^ frontPaint
]

{ #category : 'accessing' }
ICProportionnalSegment >> frontPaint: aBlPaint [

	frontPaint := aBlPaint
]

{ #category : 'initialization' }
ICProportionnalSegment >> initialize [

	super initialize.
	lit := false.
	self initializeDefaultGeometry.
	self initializeDefaultPaints.
	self update
]

{ #category : 'initialization' }
ICProportionnalSegment >> initializeDefaultGeometry [

	| w h |
	w := 40.
	h := 8.
	"self widgetSize: w @ h."
	self geometry: IC7SegmentGeometry horizontal
]

{ #category : 'initialization' }
ICProportionnalSegment >> initializeDefaultPaints [

	| paint |
	self backPaint: Color black.

	paint := BlLinearGradientPaint vertical
		         from: Color lightGreen
		         to: Color lightGreen  muchDarker.

	self frontPaint: paint
]

{ #category : 'testing' }
ICProportionnalSegment >> isLit [

	^ lit 


]

{ #category : 'testing' }
ICProportionnalSegment >> lit: aBoolean [

	lit := aBoolean.
	self update
]

{ #category : 'as yet unclassified' }
ICProportionnalSegment >> switchOff [ 

	lit := false.
	self update.
]

{ #category : 'as yet unclassified' }
ICProportionnalSegment >> switchOn [

	lit := true.
	self update
]

{ #category : 'updating' }
ICProportionnalSegment >> update [

	self
		background: (self isLit
		ifTrue: [ self frontPaint ]
		ifFalse: [ self backPaint ])
]
