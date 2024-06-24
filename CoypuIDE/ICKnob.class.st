Class {
	#name : #ICKnob,
	#superclass : #BlElement,
	#instVars : [
		'minValue',
		'maxValue',
		'currentValue',
		'callBack',
		'stepValue',
		'knob',
		'diameter',
		'angle',
		'minAngle',
		'maxAngle',
		'centerPosition'
	],
	#category : #'CoypuIDE-knob'
}

{ #category : #examples }
ICKnob class >> basicExample [

	<script>
	| knob |
	knob := self new position: 100 @ 100.

	knob openInSpace.

	"knob callBack: [ :v | v inspect ]"
]

{ #category : #accessing }
ICKnob >> angle [ 

	^ angle 
]

{ #category : #accessing }
ICKnob >> angle: aNumber [

	| tmp |
	tmp := aNumber.
	aNumber >= 180 ifTrue: [ tmp := aNumber - 360 ].
	angle := tmp.
	tmp < -135 ifTrue: [ angle := -135 ].
	tmp > 135 ifTrue: [ angle := 135 ].

	self knob transformDo: [ :t | t rotateBy: angle ].
	self currentValue: self angleToValue
]

{ #category : #'as yet unclassified' }
ICKnob >> angleToValue [

	| normalized mapped |
	normalized := self angle - self minAngle
	              / (self maxAngle - self minAngle).
	mapped := normalized * (self maxValue - self minValue)
	          + self minValue.
	^ mapped asFloat
]

{ #category : #accessing }
ICKnob >> callBack [ 

	^ callBack 
]

{ #category : #accessing }
ICKnob >> callBack: aBlock [

	callBack := aBlock 
]

{ #category : #accessing }
ICKnob >> centerPosition [

	^ centerPosition 
]

{ #category : #accessing }
ICKnob >> centerPosition: aPosition [

	centerPosition := aPosition
]

{ #category : #accessing }
ICKnob >> clickAt: aPoint [

	| vector newAngle |
	vector := aPoint - centerPosition.
	newAngle := (0 @ -1 angleWith: vector) radiansToDegrees.
	self angle: newAngle
]

{ #category : #accessing }
ICKnob >> currentValue [

	^ currentValue
]

{ #category : #accessing }
ICKnob >> currentValue: aNumber [

	currentValue := aNumber.
	self callBack ifNotNil: [ :c | c value: currentValue  ]
]

{ #category : #accessing }
ICKnob >> diameter [

	^ diameter
]

{ #category : #accessing }
ICKnob >> diameter: aNumber [

	diameter := aNumber
]

{ #category : #initialization }
ICKnob >> initialize [

	super initialize.
	self initializeDefaultValues.
	self initializeGeometry.
	self initializeEvents.
	self initializeAnnulus.
	self initializeTexts.
	"Here to define the centerPosition once layouted"
	self setValue: self minValue.
	self position: 0 @ 0
]

{ #category : #initialization }
ICKnob >> initializeAnnulus [

	| annulus startSegment firstQuarterSegment middleSegment thirdQuarterSegment endSegment |
	annulus := BlElement new
		           background: Color black;
		           size: 150 asPoint.
	annulus geometry: (BlAnnulusSectorGeometry new
			 startAngle: 135;
			 endAngle: 45;
			 innerRadius: 0.7;
			 outerRadius: 0.74).

	startSegment := BlElement new
		                background: Color black;
		                size: 4 @ 10;
		                position: 30 @ 110.

	startSegment transformDo: [ :t | t rotateBy: 45 ].

	firstQuarterSegment := BlElement new
		                       background: Color black;
		                       size: 4 @ 10;
		                       position: 19 @ 49.

	firstQuarterSegment transformDo: [ :t | t rotateBy: -65 ].

	middleSegment := BlElement new
		                 background: Color black;
		                 size: 4 @ 10;
		                 position: 73 @ 10.

	thirdQuarterSegment := BlElement new
		                       background: Color black;
		                       size: 4 @ 10;
		                       position: 128 @ 48.
	thirdQuarterSegment transformDo: [ :t | t rotateBy: 65 ].
	endSegment := BlElement new
		              background: Color black;
		              size: 4 @ 10;
		              position: 116 @ 110.
	endSegment transformDo: [ :t | t rotateBy: -45 ].


	annulus clipChildren: false.
	annulus addChild: startSegment.
	annulus addChild: firstQuarterSegment.
	annulus addChild: middleSegment.
	annulus addChild: thirdQuarterSegment.
	annulus addChild: endSegment.
	self addChild: annulus
]

{ #category : #accessing }
ICKnob >> initializeDefaultValues [

	minValue := 0.
	maxValue := 100.
	stepValue := nil.
	diameter := 100.
	minAngle := -135.
	maxAngle := 135
]

{ #category : #initialization }
ICKnob >> initializeEvents [

	self addEventHandlerOn: BlKeyDownEvent do: [ :e |
		e key name = #LEFT ifTrue: [
			self angle: self angle - 15
			"self knob transformDo: [ :t |
				self angle: self angle - 15.
				t rotateBy: angle ]" ].
		e key name = #RIGHT ifTrue: [
			self angle: self angle + 15.
			"self knob transformDo: [ :t |
				self angle: self angle + 15
				t rotateBy: angle ]" ] ].
	self
		addEventHandlerOn: BlClickEvent
		do: [ :e | self clickAt: e position ].
	self addEventHandlerOn: BlDragStartEvent do: [ :event |
		event consumed: true.
		self clickAt: event position ].
	self
		addEventHandlerOn: BlDragEvent
		do: [ :event | self clickAt: event position ].
	self requestFocus
]

{ #category : #initialization }
ICKnob >> initializeGeometry [

	| marker |
	self size: (diameter + 50) asPoint.
	self background: Color veryVeryLightGray.
	self clipChildren: false.
	self layout: BlFrameLayout new.
	self knob: (BlElement new
			 geometry: BlCircleGeometry new;
			 size: diameter asPoint;
			 clipChildren: false;
			 background: Color lightGray;
			 constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter ]).
	self addChild: self knob.
	marker := BlElement new
		          size: 4 @ 20;
		          transformDo: [ :t | t translateBy: -2 @ 0 ];
		          geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
		          background: Color darkGray;
		          position: diameter / 2 @ 5.
	self knob addChild: marker
]

{ #category : #initialization }
ICKnob >> initializeTexts [

	| minLabel maxLabel currentLabel labels |
	minLabel := BlTextElement new text: self minValue asRopedText.
	maxLabel := BlTextElement new text: self maxValue asRopedText.

	currentLabel := BlTextElement new text: self currentValue asRopedText.

	labels := BlElement new clipChildren: false.

	labels addChild: minLabel.
	labels addChild: maxLabel.
	labels addChild: currentLabel.

	self addChild: labels.

	self callBack: [ :v |
		currentLabel text: v rounded asRopedText ].

	currentLabel position: 70 @ 130.
	minLabel position: 20 @ 125.
	maxLabel position: 120 @ 125
]

{ #category : #accessing }
ICKnob >> knob [ 

	^ knob 
]

{ #category : #accessing }
ICKnob >> knob: anElement [

	knob := anElement 
]

{ #category : #accessing }
ICKnob >> maxAngle [

	^ maxAngle
]

{ #category : #accessing }
ICKnob >> maxAngle: aNumber [

	maxAngle := aNumber 
]

{ #category : #accessing }
ICKnob >> maxValue [

	^ maxValue
]

{ #category : #accessing }
ICKnob >> maxValue: aNumber [

	maxValue := aNumber
]

{ #category : #accessing }
ICKnob >> minAngle [ 

	^ minAngle 
]

{ #category : #accessing }
ICKnob >> minAngle: aNumber [

	minAngle := aNumber
]

{ #category : #accessing }
ICKnob >> minValue [

	^ minValue 
]

{ #category : #accessing }
ICKnob >> minValue: aNumber [

	minValue := aNumber
]

{ #category : #'api - bounds' }
ICKnob >> position: aPoint [

	super position: aPoint.
	self whenLayoutedDoOnce: [
	self centerPosition: self positionInSpace + (self size / 2)]
]

{ #category : #initialization }
ICKnob >> setValue: aNumber [

	|newAngle|
	newAngle := self valueToAngle: aNumber.
	self angle: newAngle.
]

{ #category : #accessing }
ICKnob >> stepValue [

	^ stepValue
]

{ #category : #accessing }
ICKnob >> stepValue: aNumber [

	stepValue := aNumber
]

{ #category : #'as yet unclassified' }
ICKnob >> valueToAngle: aNumber [

	| normalized mapped |
	normalized := aNumber - self minValue
	              / (self maxValue - self minValue).
	mapped := normalized * (self maxAngle - self minAngle)
	          + self minAngle.
	^ mapped 
]
