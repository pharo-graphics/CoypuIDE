Class {
	#name : #MfFractalCircleElement,
	#superclass : #ToElement,
	#instVars : [
		'currentX',
		'currentY',
		'value',
		'nbOfChilds'
	],
	#category : #MooflodFractalCircleWidget
}

{ #category : #'as yet unclassified' }
MfFractalCircleElement >> circleExtent [

	^ 390 @ 390
]

{ #category : #'as yet unclassified' }
MfFractalCircleElement >> createCircle: x y: anY [

	| c |
	c := MfCircleElement new size: x @ anY.
	self addChild: c
]

{ #category : #accessing }
MfFractalCircleElement >> currentX [

^currentX.
]

{ #category : #accessing }
MfFractalCircleElement >> currentY [ 
^currentY.
]

{ #category : #initialization }
MfFractalCircleElement >> defaultGeometry [

	^ BlCircleGeometry new matchExtent: self extent.
]

{ #category : #initialization }
MfFractalCircleElement >> initialize [

	super initialize.
	self size: self circleExtent.
	self geometry: self defaultGeometry.
	self border: (BlBorder paint: Color black width: 3).
	self layout: BlFrameLayout new.
	value := 0
]

{ #category : #accessing }
MfFractalCircleElement >> nbOfChilds [

^nbOfChilds 
]

{ #category : #'as yet unclassified' }
MfFractalCircleElement >> openFractalCircle: aCircle [

	| space |
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	aCircle transformDo: [ :c | c translateBy: 200 @ 150 ].
	space toTheme: MfFractalCircleElementTheme new.
	space root addChild: aCircle.
	space show.
	^ aCircle
]

{ #category : #'as yet unclassified' }
MfFractalCircleElement >> setValue: aValue [

	(aValue between: 0 and: 100) ifTrue: [ self value: aValue ]
	ifFalse: [ self value: 100 ].
	nbOfChilds := value / 4.
	self updateCircles
]

{ #category : #'as yet unclassified' }
MfFractalCircleElement >> updateCircles [

	currentX := 390.
	currentY := 390.
	1 to: value / 4 do: [ :i |
		currentX := currentX - 15.
		currentY := currentY - 15.
		self createCircle: currentX y: currentY ]
]

{ #category : #evaluating }
MfFractalCircleElement >> value [

^value.
]

{ #category : #accessing }
MfFractalCircleElement >> value: aValue [	

value:= aValue.
]
