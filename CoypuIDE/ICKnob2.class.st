Class {
	#name : 'ICKnob2',
	#superclass : 'BlElement',
	#instVars : [
		'minValue',
		'maxValue',
		'currentValue',
		'callBack',
		'stepValue',
		'knob',
		'disk',
		'diameter',
		'angle',
		'minAngle',
		'maxAngle',
		'centerPosition'
	],
	#category : 'CoypuIDE-knob',
	#package : 'CoypuIDE',
	#tag : 'knob'
}

{ #category : 'examples' }
ICKnob2 class >> basicExample [

	<script>
	| knob |
	knob := self new position: 100 @ 100.

	knob openInSpace.

	"knob callBack: [ :v | v inspect ]"
]

{ #category : 'accessing' }
ICKnob2 >> angle [ 

	^ angle 
]

{ #category : 'accessing' }
ICKnob2 >> angle: aNumber [

	| tmp |
	tmp := aNumber.
	aNumber >= 180 ifTrue: [ tmp := aNumber - 360 ].
	angle := tmp.
	tmp < -135 ifTrue: [ angle := -135 ].
	tmp > 135 ifTrue: [ angle := 135 ].

	self knob transformDo: [ :t | t rotateBy: angle ].
	self disk geometry endAngle: angle - 90.

	self currentValue: self angleToValue.
]

{ #category : 'as yet unclassified' }
ICKnob2 >> angleToValue [

	| normalized mapped |
	normalized := self angle - self minAngle
	              / (self maxAngle - self minAngle).
	mapped := normalized * (self maxValue - self minValue)
	          + self minValue.
	^ mapped asFloat
]

{ #category : 'accessing' }
ICKnob2 >> callBack [ 

	^ callBack 
]

{ #category : 'accessing' }
ICKnob2 >> callBack: aBlock [

	callBack := aBlock 
]

{ #category : 'accessing' }
ICKnob2 >> centerPosition [

	^ centerPosition 
]

{ #category : 'accessing' }
ICKnob2 >> centerPosition: aPosition [

	centerPosition := aPosition
]

{ #category : 'accessing' }
ICKnob2 >> clickAt: aPoint [

	| vector newAngle |
	vector := aPoint - centerPosition.
	newAngle := (0 @ -1 angleWith: vector) radiansToDegrees.
	self angle: newAngle.
	
]

{ #category : 'accessing' }
ICKnob2 >> currentValue [

	^ currentValue
]

{ #category : 'accessing' }
ICKnob2 >> currentValue: aNumber [

	currentValue := aNumber.
	self callBack ifNotNil: [ :c | c value: currentValue  ]
]

{ #category : 'accessing' }
ICKnob2 >> diameter [

	^ diameter
]

{ #category : 'accessing' }
ICKnob2 >> diameter: aNumber [

	diameter := aNumber
]

{ #category : 'accessing' }
ICKnob2 >> disk [

	^ disk
]

{ #category : 'accessing' }
ICKnob2 >> disk: anElement [

	disk := anElement 
]

{ #category : 'initialization' }
ICKnob2 >> initialize [

	super initialize.
	self initializeDefaultValues.
	self initializeGeometry.
	self initializeEvents.
	self initializeOuterRing.
	self initializeTexts.
	self initializeDisk.
	"Here to define the centerPosition once layouted"
	self setValue: self minValue.
	self position: 0 @ 0
]

{ #category : 'accessing' }
ICKnob2 >> initializeDefaultValues [

	minValue := 0.
	maxValue := 100.
	stepValue := nil.
	diameter := 100.
	minAngle := -135.
	maxAngle := 135.
]

{ #category : 'initialization' }
ICKnob2 >> initializeDisk [
	
	self disk: (BlElement new
		          "background: (Color r:63 g:162 b:227 range:255);"
		   			background: Color cyan;
		           size: diameter + 50 asPoint;
						
					geometry: (BlAnnulusSectorGeometry new
			 					startAngle: -225;
			 					endAngle: -210;
			 					innerRadius: 0.8;
			 					outerRadius: 1);
					
					constraintsDo: [ :c |
						c frame horizontal alignCenter.
					c frame vertical alignCenter. ]).
	
	
	self addChild: self disk.
]

{ #category : 'initialization' }
ICKnob2 >> initializeEvents [

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

{ #category : 'initialization' }
ICKnob2 >> initializeGeometry [

	| marker |
	self size: (diameter + 100) asPoint.
	self background: Color veryVeryDarkGray.
	self clipChildren: false.
	self layout: BlFrameLayout new.
	self padding:(BlInsets all: 10).
	self knob: (BlElement new
			 geometry: BlCircleGeometry new;
			 size: diameter asPoint;
			 clipChildren: false;
			
			 background: Color veryDarkGray ;
			 constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter ]).
	self addChild: self knob.

	
	marker := BlElement new
		          size: 10 @ 20;
		          transformDo: [ :t | t translateBy: -2 @ 0 ];
		          geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
		          background: Color white;
		          position: diameter / 2 @ 5.
	self knob addChild: marker
]

{ #category : 'initialization' }
ICKnob2 >> initializeOuterRing [

	"| annulus startSegment firstQuarterSegment middleSegment thirdQuarterSegment endSegment |
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
	annulus addChild: endSegment."
	
	|outerRing|
	outerRing := (BlElement new
		           background: (Color darkGray );
		           size: diameter + 50 asPoint;
					"effect: (BlGaussianShadowEffect color: Color white offset: 0@ -10  width: 10);"
					geometry: (BlAnnulusSectorGeometry new
			 					startAngle: 135;
			 					endAngle: 45;
			 					innerRadius: 0.8;
			 					outerRadius: 1);
					constraintsDo: [ :c |
						c frame horizontal alignCenter.
					c frame vertical alignCenter. ]).
	self addChild: outerRing.
]

{ #category : 'initialization' }
ICKnob2 >> initializeTexts [

	| minLabel maxLabel currentLabel|
	minLabel := BlTextElement new text: (self minValue asRopedText attributes: { (BlTextForegroundAttribute
paint: Color white) });
					transformDo: [ :t | t translateBy: 20 @ -20];
					constraintsDo: [ :c |c frame horizontal alignLeft. c frame vertical alignBottom.].
				
	maxLabel := BlTextElement new text: (self maxValue asRopedText attributes: { (BlTextForegroundAttribute
paint: Color white) });
					transformDo: [ :t | t translateBy: -20 @ -20];
					constraintsDo: [ :c |c frame horizontal alignRight. c frame vertical alignBottom.].

currentLabel := BlTextElement new text: (self currentValue asRopedText  attributes:{(BlTextForegroundAttribute
paint: Color white) });
					transformDo: [ :t | t translateBy: 0 @ -10];
					constraintsDo: [ :c |c frame horizontal alignCenter. c frame vertical alignBottom.].


	"labels := BlElement new clipChildren: false."

	"labels addChild: minLabel.
	labels addChild: maxLabel."
	"labels addChild: currentLabel."

	"self addChild: labels."
	self addChild: minLabel.
	self addChild: currentLabel.
	self addChild: maxLabel.

	self callBack: [ :v |
		currentLabel text: (v rounded asRopedText attributes:{(BlTextForegroundAttribute
paint: Color white) })].

	"currentLabel position: 70 @ 130."
	"minLabel position: 20 @ 125.
	maxLabel position: 120 @ 125"
]

{ #category : 'accessing' }
ICKnob2 >> knob [ 

	^ knob 
]

{ #category : 'accessing' }
ICKnob2 >> knob: anElement [

	knob := anElement 
]

{ #category : 'as yet unclassified' }
ICKnob2 >> lightBlue [
	(Color r:73 g:174 b:240 range:255)
]

{ #category : 'accessing' }
ICKnob2 >> maxAngle [

	^ maxAngle
]

{ #category : 'accessing' }
ICKnob2 >> maxAngle: aNumber [

	maxAngle := aNumber 
]

{ #category : 'accessing' }
ICKnob2 >> maxValue [

	^ maxValue
]

{ #category : 'accessing' }
ICKnob2 >> maxValue: aNumber [

	maxValue := aNumber
]

{ #category : 'accessing' }
ICKnob2 >> minAngle [ 

	^ minAngle 
]

{ #category : 'accessing' }
ICKnob2 >> minAngle: aNumber [

	minAngle := aNumber
]

{ #category : 'accessing' }
ICKnob2 >> minValue [

	^ minValue 
]

{ #category : 'accessing' }
ICKnob2 >> minValue: aNumber [

	minValue := aNumber
]

{ #category : 'api - bounds' }
ICKnob2 >> position: aPoint [

	super position: aPoint.
	self whenLayoutedDoOnce: [
	self centerPosition: self positionInSpace + (self size / 2)]
]

{ #category : 'initialization' }
ICKnob2 >> setValue: aNumber [

	|newAngle|
	newAngle := self valueToAngle: aNumber.
	self angle: newAngle.
]

{ #category : 'accessing' }
ICKnob2 >> stepValue [

	^ stepValue
]

{ #category : 'accessing' }
ICKnob2 >> stepValue: aNumber [

	stepValue := aNumber
]

{ #category : 'as yet unclassified' }
ICKnob2 >> valueToAngle: aNumber [

	| normalized mapped |
	normalized := aNumber - self minValue
	              / (self maxValue - self minValue).
	mapped := normalized * (self maxAngle - self minAngle)
	          + self minAngle.
	^ mapped 
]
