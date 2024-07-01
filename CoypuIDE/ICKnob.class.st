Class {
	#name : 'ICKnob',
	#superclass : 'BlElement',
	#instVars : [
		'inputText',
		'inputLabel',
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
ICKnob class >> allKnobExamples [

	<script>
	| container e1 e2 e3 e4 e5 e6 e7|
	container:= BlElement new
		
		geometry: BlRectangleGeometry new;
		layout: (BlGridLayout new
		columnCount: 4;
		cellSpacing: 0
		);
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent.
			];
		background: Color darkGray.


e1:= ICKnob label: 'Label1'.


e2:= ICLightKnob label: 'Label 2'.
e3:= ICDarkKnob2 label: 'LABEL 3'. 
e4:= ICDarkKnob3 label: 'LABEL 4'. 
e5:= ICDarkKnob4 label:'LABEL 5'. 
e6:= ICDarkKnob5 label:'LABEL 6'.
e7:= ICDialKnob label: 'LABEL 7'.


container addChildren: { e1. e2 . e3 . e4 .  e5 . e6. e7}.
container openInNewSpace.
]

{ #category : 'examples' }
ICKnob class >> basicExample [

	<script>
	| knob |
	knob := self new position: 100 @ 100.

	knob openInSpace.

	"knob callBack: [ :v | v inspect ]"
]

{ #category : 'initialization' }
ICKnob class >> label: aString [
	|e|
	e:= self new inputText: aString.
	e initializeLabel.
	^ e.
	
]

{ #category : 'accessing' }
ICKnob >> angle [ 

	^ angle 
]

{ #category : 'accessing' }
ICKnob >> angle: aNumber [

	| tmp |
	tmp := aNumber.
	aNumber >= 180 ifTrue: [ tmp := aNumber - 360 ].
	angle := tmp.
	tmp < -135 ifTrue: [ angle := -135 ].
	tmp > 135 ifTrue: [ angle := 135 ].

	self doOperations.

]

{ #category : 'api - operations' }
ICKnob >> angleToValue [

	| normalized mapped |
	normalized := self angle - self minAngle
	              / (self maxAngle - self minAngle).
	mapped := normalized * (self maxValue - self minValue)
	          + self minValue.
	^ mapped asFloat
]

{ #category : 'initialization' }
ICKnob >> backColor [
	^ (Color veryVeryDarkGray)
]

{ #category : 'accessing' }
ICKnob >> callBack [ 

	^ callBack 
]

{ #category : 'accessing' }
ICKnob >> callBack: aBlock [

	callBack := aBlock 
]

{ #category : 'accessing' }
ICKnob >> centerPosition [

	^ centerPosition 
]

{ #category : 'accessing' }
ICKnob >> centerPosition: aPosition [

	centerPosition := aPosition
]

{ #category : 'accessing' }
ICKnob >> clickAt: aPoint [

	| vector newAngle |
	vector := aPoint - centerPosition.
	newAngle := (0 @ -1 angleWith: vector) radiansToDegrees.
	self angle: newAngle.
	
]

{ #category : 'accessing' }
ICKnob >> currentValue [

	^ currentValue
]

{ #category : 'accessing' }
ICKnob >> currentValue: aNumber [

	currentValue := aNumber.
	self callBack ifNotNil: [ :c | c value: currentValue  ]
]

{ #category : 'accessing' }
ICKnob >> diameter [

	^ diameter
]

{ #category : 'accessing' }
ICKnob >> diameter: aNumber [

	diameter := aNumber
]

{ #category : 'accessing' }
ICKnob >> disk [

	^ disk
]

{ #category : 'accessing' }
ICKnob >> disk: anElement [

	disk := anElement 
]

{ #category : 'initialization' }
ICKnob >> diskColor [ 
	^ (Color cyan)
]

{ #category : 'initialization' }
ICKnob >> diskSize [

	^ self diameter + 40
]

{ #category : 'api - operations' }
ICKnob >> doOperations [

	self knob transformDo: [ :t | t rotateBy: angle ].
	self knob zIndex: 100.
	self disk geometry endAngle: angle - 90.
	self currentValue: self angleToValue.

]

{ #category : 'initialization' }
ICKnob >> initialize [

	super initialize.
	self initializeDefaultValues.
	self initializeGeometry.
	self initializeEvents.
	self initializeOuterRing.
	self initializeTexts.
	self initializeDisks.
	"self initializeLabel."

	"Here to define the centerPosition once layouted"
	self setValue: self minValue.
	self position: 0 @ 0
]

{ #category : 'accessing' }
ICKnob >> initializeDefaultValues [
	minValue := 0.
	maxValue := 100.
	stepValue := nil.
	diameter := 100.
	minAngle := -135.
	maxAngle := 135.
]

{ #category : 'initialization' }
ICKnob >> initializeDisk [
	
	self disk: (BlElement new
		          "background: (Color r:63 g:162 b:227 range:255);"
		   			background: self diskColor;
		           size: self diskSize asPoint;
						
					geometry: (BlAnnulusSectorGeometry new
			 					startAngle: -225;
			 					endAngle: -210;
			 					innerRadius: 0.83;
			 					outerRadius: 1);
					
					constraintsDo: [ :c |
						c frame horizontal alignCenter.
					c frame vertical alignCenter. ]).
	
	
	self addChild: self disk.
]

{ #category : 'initialization' }
ICKnob >> initializeDisks [

	self initializeDisk.
]

{ #category : 'initialization' }
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

{ #category : 'initialization' }
ICKnob >> initializeGeometry [
	
	| marker backdrop|
	"self size: (diameter + 100) @ (diameter + 150)."
	self size: (diameter + 100) asPoint.
	self background: self backColor.
	self clipChildren: false.
	self layout: BlFrameLayout new.
	self padding:(BlInsets all: 7).
	
	"backdrop:=(BlElement new
			 geometry: BlCircleGeometry new;
			 size: diameter-2 asPoint;
			 clipChildren: false;
			effect: (BlGaussianShadowEffect color: Color white offset: 0@ 0  width: 80);
			 background: Color darkGray ;
			 constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter ]).
			
	self addChild: backdrop."
	
	"effect: (BlGaussianShadowEffect color: Color black offset: 0@ 0  width: 60);"
	
	self knob: (BlElement new
			 geometry: BlCircleGeometry new;
			 size: self knobSize asPoint;
			 clipChildren: false;
			"effect: (BlGaussianShadowEffect color: Color black offset: 0@ 0  width: 60);"
			 background: self knobColor ;
			 constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter]).
		"knob zIndex: 100."
	
	self addChild: self knob.

	
	marker := BlElement new
		          size: 10 @ 20;
		          transformDo: [ :t | t translateBy: -2 @ 0 ];
					
		          geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
		          background: self markerColor;
		          position: self knobSize / 2 @ 5.
			marker zIndex: 100.
	self knob addChild: marker
]

{ #category : 'initialization' }
ICKnob >> initializeLabel [
	inputLabel := BlTextElement new.
	inputLabel text: (self inputText asRopedText attributes: { (BlTextForegroundAttribute
paint: self textColor ) }).
	inputLabel text fontSize: 15.
	inputLabel text bold.
	inputLabel constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignTop.
		].
	"inputLabel transformDo: [ :t | t translateBĀ: 0 @ 10 ]."
	self addChild: inputLabel.
]

{ #category : 'initialization' }
ICKnob >> initializeOuterRing [
	
	|outerRing|
	outerRing := (BlElement new
		           background: self outerRingColor;
		           size: self outerRingSize asPoint;
					"effect: (BlGaussianShadowEffect color: Color white offset: 0@ -10  width: 10);"
					geometry: (BlAnnulusSectorGeometry new
			 					startAngle: 135;
			 					endAngle: 45;
			 					innerRadius: 0.83;
			 					outerRadius: 1);
					constraintsDo: [ :c |
						c frame horizontal alignCenter.
					c frame vertical alignCenter. ]).
	self addChild: outerRing.
]

{ #category : 'initialization' }
ICKnob >> initializeTexts [

	| minLabel maxLabel currentLabel|
	minLabel := BlTextElement new text: (self minValue asRopedText attributes: { (BlTextForegroundAttribute
paint: self textColor) });
					transformDo: [ :t | t translateBy: 20 @ -20];
					constraintsDo: [ :c |c frame horizontal alignLeft. c frame vertical alignBottom.].
				
	maxLabel := BlTextElement new text: (self maxValue asRopedText attributes: { (BlTextForegroundAttribute
paint: self textColor) });
					transformDo: [ :t | t translateBy: -20 @ -20];
					constraintsDo: [ :c |c frame horizontal alignRight. c frame vertical alignBottom.].

currentLabel := BlTextElement new text: (self currentValue asRopedText  attributes:{(BlTextForegroundAttribute
paint: self valueColor) });
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
	"self label: inputLabel."
	self callBack: [ :v |
		currentLabel text: (v rounded asRopedText attributes:{(BlTextForegroundAttribute
paint: self valueColor) })].

	"currentLabel position: 70 @ 130."
	"minLabel position: 20 @ 125.
	maxLabel position: 120 @ 125"
]

{ #category : 'accessing' }
ICKnob >> inputText [
	^ inputText.

]

{ #category : 'accessing' }
ICKnob >> inputText: aString [
	inputText := aString.

]

{ #category : 'accessing' }
ICKnob >> knob [ 

	^ knob 
]

{ #category : 'accessing' }
ICKnob >> knob: anElement [

	knob := anElement 
]

{ #category : 'initialization' }
ICKnob >> knobColor [
	^(Color veryDarkGray)
]

{ #category : 'initialization' }
ICKnob >> knobSize [

	^ self diameter
]

{ #category : 'initialization' }
ICKnob >> markerColor [
	^(Color white)
]

{ #category : 'accessing' }
ICKnob >> maxAngle [

	^ maxAngle
]

{ #category : 'accessing' }
ICKnob >> maxAngle: aNumber [

	maxAngle := aNumber 
]

{ #category : 'accessing' }
ICKnob >> maxValue [

	^ maxValue
]

{ #category : 'accessing' }
ICKnob >> maxValue: aNumber [

	maxValue := aNumber
]

{ #category : 'accessing' }
ICKnob >> minAngle [ 

	^ minAngle 
]

{ #category : 'accessing' }
ICKnob >> minAngle: aNumber [

	minAngle := aNumber
]

{ #category : 'accessing' }
ICKnob >> minValue [

	^ minValue 
]

{ #category : 'accessing' }
ICKnob >> minValue: aNumber [

	minValue := aNumber
]

{ #category : 'initialization' }
ICKnob >> outerRingColor [
	^(Color darkGray )
]

{ #category : 'initialization' }
ICKnob >> outerRingSize [

	^self diameter + 40
]

{ #category : 'api - bounds' }
ICKnob >> position: aPoint [

	super position: aPoint.
	self whenLayoutedDoOnce: [
	self centerPosition: self positionInSpace + (self size / 2)]
]

{ #category : 'initialization' }
ICKnob >> setValue: aNumber [

	|newAngle|
	newAngle := self valueToAngle: aNumber.
	self angle: newAngle.
]

{ #category : 'accessing' }
ICKnob >> stepValue [

	^ stepValue
]

{ #category : 'accessing' }
ICKnob >> stepValue: aNumber [

	stepValue := aNumber
]

{ #category : 'initialization' }
ICKnob >> textColor [
	^Color white.
]

{ #category : 'initialization' }
ICKnob >> valueColor [
	^Color white.
]

{ #category : 'api - operations' }
ICKnob >> valueToAngle: aNumber [

	| normalized mapped |
	normalized := aNumber - self minValue
	              / (self maxValue - self minValue).
	mapped := normalized * (self maxAngle - self minAngle)
	          + self minAngle.
	^ mapped 
]
