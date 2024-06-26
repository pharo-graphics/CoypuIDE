Class {
	#name : 'ICSegment',
	#superclass : 'BlElement',
	#instVars : [
		'lit',
		'widgetSize',
		'backPaint',
		'frontPaint'
	],
	#category : 'CoypuIDE-led / 7segment',
	#package : 'CoypuIDE',
	#tag : 'led / 7segment'
}

{ #category : 'factory' }
ICSegment class >> horizontalExample [

	<script>
	| elt |
	elt := self new.
	elt position: 50 asPoint.

	elt addEventHandlerOn: BlClickEvent do: [ :e | elt lit: elt isLit not ].
	elt openInSpace
]

{ #category : 'factory' }
ICSegment class >> horizontalSegment [

	^ self new.
]

{ #category : 'factory' }
ICSegment class >> verticalExample [

	<script>
	| elt w h paint |
	h := 40.
	w := 8.
	paint := BlLinearGradientPaint new
		         stops: {
				         (0.0 -> Color lightGreen).
				         (0.5 -> Color lightGreen).
				         (1.0 -> Color lightGreen darker darker) };
		         start: 0 @ 0;
		         end: w @ 0;
		         yourself.
	elt := self new
		       widgetSize: w @ h;
		       frontPaint: paint.
	elt geometry: (BlPolygonGeometry vertices: {
				 (w @ (1 / 6 * h)).
				 (w @ (5 / 6 * h)).
				 (w / 2 @ h).
				 (0 @ (5 / 6 * h)).
				 (0 @ (1 / 6 * h)).
				 (w / 2 @ 0) }).

	elt position: 50 asPoint.

	elt
		addEventHandlerOn: BlClickEvent
		do: [ :e | elt lit: elt isLit not ].
	elt openInSpace
]

{ #category : 'factory' }
ICSegment class >> verticalSegment [

	| elt w h paint |
	h := 40.
	w := 8.
	paint := BlLinearGradientPaint new
		         stops: {
				         (0.0 -> Color lightGreen).
				         (0.5 -> Color lightGreen).
				         (1.0 -> Color lightGreen darker darker) };
		         start: 0 @ 0;
		         end: w @ 0;
		         yourself.
	elt := self new
		       widgetSize: w @ h;
		       frontPaint: paint.
	elt geometry: (BlPolygonGeometry vertices: {
				 (w @ (1 / 6 * h)).
				 (w @ (5 / 6 * h)).
				 (w / 2 @ h).
				 (0 @ (5 / 6 * h)).
				 (0 @ (1 / 6 * h)).
				 (w / 2 @ 0) }).

	^ elt
]

{ #category : 'accessing' }
ICSegment >> backPaint [ 

	^ backPaint 
]

{ #category : 'accessing' }
ICSegment >> backPaint: aBlPaint [

	backPaint := aBlPaint 
]

{ #category : 'accessing' }
ICSegment >> frontPaint [

	^ frontPaint
]

{ #category : 'accessing' }
ICSegment >> frontPaint: aBlPaint [

	frontPaint := aBlPaint
]

{ #category : 'initialization' }
ICSegment >> initialize [

	super initialize.
	lit := false.
	self initializeDefaultGeometry.
	self initializeDefaultPaints.
	self update
]

{ #category : 'initialization' }
ICSegment >> initializeDefaultGeometry [ 

	|w h|
	w := 40.
	h := 8.
	self widgetSize: w @ h.
	self geometry: (BlPolygonGeometry vertices: {
				 (1 / 6 * w @ 0).
				 (5 / 6 * w @ 0).
				 (w @ (h / 2)).
				 (5 / 6 * w @ h).
				 (1 / 6 * w @ h).
				 (0 @ (h / 2)) }).
]

{ #category : 'initialization' }
ICSegment >> initializeDefaultPaints [

	| paint |
	self backPaint: Color black.

	paint := BlLinearGradientPaint new
		         stops: {
				         (0.0 -> Color lightGreen).
				         (0.5 -> Color lightGreen).
				         (1.0 -> Color lightGreen darker darker) };
		         start: 0 @ 0;
		         end: 0 @ self widgetSize y;
		         yourself.
	self frontPaint: paint
]

{ #category : 'testing' }
ICSegment >> isLit [

	^ lit 


]

{ #category : 'testing' }
ICSegment >> lit: aBoolean [

	lit := aBoolean.
	self update
]

{ #category : 'as yet unclassified' }
ICSegment >> switchOff [ 

	lit := false.
	self update.
]

{ #category : 'as yet unclassified' }
ICSegment >> switchOn [

	lit := true.
	self update
]

{ #category : 'updating' }
ICSegment >> update [

	self
		background: (self isLit
		ifTrue: [ self frontPaint ]
		ifFalse: [ self backPaint ])
]

{ #category : 'testing' }
ICSegment >> widgetSize [ 

	^ widgetSize
]

{ #category : 'testing' }
ICSegment >> widgetSize: aPoint [

	self size: aPoint.
	widgetSize := aPoint
]
