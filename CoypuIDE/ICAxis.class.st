Class {
	#name : 'ICAxis',
	#superclass : 'BlElement',
	#instVars : [
		'valueX',
		'valueY',
		'callBack',
		'minX',
		'minY',
		'maxX',
		'maxY',
		'widgetSize',
		'yLabel',
		'xLabel'
	],
	#category : 'CoypuIDE-axis',
	#package : 'CoypuIDE',
	#tag : 'axis'
}

{ #category : 'as yet unclassified' }
ICAxis class >> simpleExample [

	<script>
	| axis |
	axis := ICAxis new widgetSize: 500 @ 200.
	axis minX: 50.
	axis maxX: 100.
	axis minY: 200.
	axis maxY: 400.
	axis callBack: [ :x :y | (x @ y) inspect ].
	axis position: 50 asPoint.
	axis openInSpace
]

{ #category : 'as yet unclassified' }
ICAxis >> buildAxis [

	| vertical w h horizontal |
	w := self widgetSize x.
	h := self widgetSize y.
	self removeChildWithId: 'xAxis'.
	self removeChildWithId: 'yAxis'.

	vertical := BlElement new
		            size: 10 @ h;
		            background: Color black;
		            position: -5 @ 0;
		            geometry: (BlPolygonGeometry vertices: {
						             (5 @ 0).
						             (10 @ 10).
						             (6 @ 10).
						             (6 @ h).
						             (4 @ h).
						             (4 @ 10).
						             (0 @ 10) }).

	horizontal := BlElement new
		              size: w @ 10;
		              background: Color black;
		              position: 0 @ (h - 5);
		              geometry: (BlPolygonGeometry vertices: {
						               (0 @ 4).
						               (w - 10 @ 4).
						               (w - 10 @ 0).
						               (w @ 5).
						               (w - 10 @ 10).
						               (w - 10 @ 6).
						               (0 @ 6) }).

	self addChild: vertical as: 'yAxis'.
	self addChild: horizontal as: 'xAxis'.
	
	self buildAxisText
]

{ #category : 'as yet unclassified' }
ICAxis >> buildAxisText [

	| w h xText yText |
	w := self widgetSize x.
	h := self widgetSize y.

	self removeChildWithId: 'xLabel'.
	self removeChildWithId: 'yLabel'.

	xText := BlTextElement new
		         text: self xLabel asRopedText;
		         position: 0 @ (h + 5).
	yText := BlTextElement new
		         text: self yLabel asRopedText;
		         position: -50 @ (h - 10).

	self addChild: xText as: 'xLabel'.
	self addChild: yText as: 'yLabel'
]

{ #category : 'accessing' }
ICAxis >> callBack [ 

	^ callBack 
]

{ #category : 'accessing' }
ICAxis >> callBack: aBlock [

	callBack := aBlock 
]

{ #category : 'accessing' }
ICAxis >> clickAt: aPoint [

	self removeChildWithId: 'current'.
	self
		addChild: (BlElement new
				 size: 4 asPoint;
				 background: Color red;
				 position: aPoint;
				 transformDo: [ :t | t translateBy: 2 asPoint negated ])
		as: 'current'.
	self valueAt: aPoint
]

{ #category : 'api - bounds' }
ICAxis >> defaultSize [ 

	^ 200@ 150
]

{ #category : 'initialization' }
ICAxis >> initialize [

	super initialize.
	self background: Color veryLightGray.
	self clipChildren: false.
	self initializeDefaultSize.
	self initializeDefaultValues.
	self buildAxis.

	self
		addEventHandlerOn: BlClickEvent
		do: [ :e | self clickAt: e position - self position ]
]

{ #category : 'initialization' }
ICAxis >> initializeDefaultSize [

	self widgetSize: self defaultSize
]

{ #category : 'initialization' }
ICAxis >> initializeDefaultValues [

	self minX: 0.
	self maxX: 100.
	self minY: 0.
	self maxY: 100.
	self xLabel: 'x Label'.
	self yLabel: 'y Label'.
]

{ #category : 'accessing' }
ICAxis >> maxX [

	^ maxX
]

{ #category : 'accessing' }
ICAxis >> maxX: aNumber [

	maxX:= aNumber 
]

{ #category : 'accessing' }
ICAxis >> maxY [

	^ maxY
]

{ #category : 'accessing' }
ICAxis >> maxY: aNumber [

	maxY := aNumber
]

{ #category : 'accessing' }
ICAxis >> minX [ 

	^ minX
]

{ #category : 'accessing' }
ICAxis >> minX: aNumber [

	minX := aNumber
]

{ #category : 'accessing' }
ICAxis >> minY [

	^ minY
]

{ #category : 'accessing' }
ICAxis >> minY:  aNumber [

	minY := aNumber
]

{ #category : 'accessing' }
ICAxis >> valueAt: aPoint [

	self valueX: (self valueAtX: aPoint x).
	self valueY: (self valueAtY: aPoint y).
	self callBack ifNotNil: [ :c | c value: valueX value: valueY ]
]

{ #category : 'api - transformations' }
ICAxis >> valueAtX: aNumber [

	| range value coeff |
	aNumber = 0 ifTrue: [ ^ 0 ].
	range := maxX - minX.
	coeff := self width / aNumber.
	value := minX + (range / coeff).

	^ value asFloat
]

{ #category : 'api - transformations' }
ICAxis >> valueAtY: aNumber [

	| range value coeff |
	aNumber = 0 ifTrue: [ ^ 0 ].
	range := maxY - minY.
	coeff := self height / aNumber.
	value := maxY - (range / coeff).

	^ value asFloat
]

{ #category : 'accessing' }
ICAxis >> valueX [ 

	^ valueX
]

{ #category : 'accessing' }
ICAxis >> valueX: aNumber [

	valueX := aNumber 
]

{ #category : 'accessing' }
ICAxis >> valueY [

	^ valueY 
]

{ #category : 'accessing' }
ICAxis >> valueY: aNumber [

	valueY := aNumber
]

{ #category : 'accessing' }
ICAxis >> widgetSize [ 
	^ widgetSize 
]

{ #category : 'accessing' }
ICAxis >> widgetSize: anExtent [

	widgetSize := anExtent.
	self size: widgetSize.
	self buildAxis
]

{ #category : 'accessing' }
ICAxis >> xLabel [

	^ xLabel 
]

{ #category : 'accessing' }
ICAxis >> xLabel: aString [

	xLabel := aString.
	self buildAxisText
]

{ #category : 'accessing' }
ICAxis >> yLabel [ 

	^ yLabel 
]

{ #category : 'accessing' }
ICAxis >> yLabel: aString [

	yLabel := aString.
	self buildAxisText
]
