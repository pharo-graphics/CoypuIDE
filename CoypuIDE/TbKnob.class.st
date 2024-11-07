Class {
	#name : 'TbKnob',
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
		'centerPosition',
		'minLabel',
		'maxLabel',
		'currentLabel'
	],
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'examples' }
TbKnob class >> AllExamples [

	<script>

	|container k1 k2 k3 k4 k5 k6 k7 k8|
	container:= BlElement new
		
		geometry: BlRectangleGeometry new;
		layout: (BlGridLayout new
		columnCount: 6;
		cellSpacing: 10
		);
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent.
			];
		background: (Color r: 233 g:224  b:208  range:255).
		"background: (Color r: 249 g:239  b:224  range:255)."
		"background: Color white."
	
	k1 := TbKnob label:'TUNING'.
	k2 := TbKnob label:'CUTOFF FREQ'.
	k3 := TbKnob label:'RESONANCE'.
	k4 := TbKnob label:'ENV MOD'.
	k5 := TbKnob label:'DECAY'.
	k6 := TbKnob label:'ACCENT'.
		k7 := TbKnob1 label:'BIGGER KNOB1'.
			k8 := TbKnob2 label:'BIGGER KNOB2'.
	
	
	
	container addChildren: { k1. k2. k3. k4. k5. k6. k7. k8
	}. 
	container openInSpace.

	"knob callBack: [ :v | v inspect ]"
]

{ #category : 'examples' }
TbKnob class >> basicExample [

	<script>

	|container knob |
	container:= BlElement new
		
		geometry: BlRectangleGeometry new;
		layout: (BlGridLayout new
		columnCount: 2;
		cellSpacing: 50
		);
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent.
			];
		background: (Color r: 233 g:224  b:208  range:255).
		"background: (Color r: 249 g:239  b:224  range:255)."
		"background: Color white."
	
	knob := self label:'RESONANCE'.
	container addChildren: { knob }. 
	container openInSpace.

	"knob callBack: [ :v | v inspect ]"
]

{ #category : 'instance creation' }
TbKnob class >> fromDictionary: aDictionary [
]

{ #category : 'instance creation' }
TbKnob class >> fromDictionary: aDictionary forDsp: aDsp [

	^ (self 
			        label: (aDictionary at: #label)
			        minValue: (aDictionary at: #min)
			        maxValue: (aDictionary at: #max)
			        callBack: [ :i |
			        aDsp setValue: i parameter: (aDictionary at: #label) ])  setValue: (aDictionary at: #init)
]

{ #category : 'initialization' }
TbKnob class >> label: aString [
	|e|
	e:= self new inputText: aString.
	e initializeLabel.
	^ e.
	
]

{ #category : 'initialization' }
TbKnob class >> label: aString minValue: min maxValue: max [
	|e|
	e:= self new inputText: aString.
	e minValue: min.
	e maxValue: max.
	e setToMin.
	e initializeLabel.
	^ e.
	
]

{ #category : 'initialization' }
TbKnob class >> label: aString minValue: min maxValue: max callBack: aBlock [

	| e |
	e := self label: aString minValue: min maxValue: max.
	e callBack: aBlock.
	^ e
]

{ #category : 'initialization' }
TbKnob class >> openForAllParameters: aDsp [

	| container allParams allKnobs |
	allParams := aDsp allParameters.
	allKnobs := OrderedCollection new.
	allParams do: [ :k |
		allKnobs add: (self
				 label: k  minValue: (aDsp getParamMin: (aDsp getParamIndex: k)) maxValue: (aDsp getParamMax: (aDsp getParamIndex: k))
				 callBack: [ :i | aDsp setValue: i parameter: k ]) ].
	container := BlElement new
		             geometry: BlRectangleGeometry new;
		             layout: (BlGridLayout new
				              columnCount: 4;
				              cellSpacing: 0);
		             constraintsDo: [ :c |
			             c horizontal matchParent.
			             c vertical matchParent ];
		             background: Color darkGray.


	container addChildren: allKnobs.
	container openInNewSpace
]

{ #category : 'accessing' }
TbKnob >> angle [ 

	^ angle 
]

{ #category : 'accessing' }
TbKnob >> angle: aNumber [

	| tmp |
	tmp := aNumber.
	aNumber >= 180 ifTrue: [ tmp := aNumber - 360 ].
	angle := tmp.
	tmp < -135 ifTrue: [ angle := -135 ].
	tmp > 135 ifTrue: [ angle := 135 ].

	self doOperations.

]

{ #category : 'api - operations' }
TbKnob >> angleToValue [

	| normalized mapped |
	normalized := self angle - self minAngle
	              / (self maxAngle - self minAngle).
	mapped := normalized * (self maxValue - self minValue)
	          + self minValue.
	^ mapped asFloat
]

{ #category : 'initialization' }
TbKnob >> backColor [
	^ (Color veryVeryDarkGray)
]

{ #category : 'accessing' }
TbKnob >> callBack [ 

	^ callBack 
]

{ #category : 'accessing' }
TbKnob >> callBack: aBlock [

	callBack := aBlock 
]

{ #category : 'accessing' }
TbKnob >> centerPosition [

	^ centerPosition 
]

{ #category : 'accessing' }
TbKnob >> centerPosition: aPosition [

	centerPosition := aPosition
]

{ #category : 'accessing' }
TbKnob >> clickAt: aPoint [

	| vector newAngle |
	vector := aPoint - centerPosition.
	newAngle := (0 @ -1 angleWith: vector) radiansToDegrees.
	self angle: newAngle.
	
]

{ #category : 'initialization' }
TbKnob >> color1 [
	^ (Color r: 249 g:239  b:224  range:255).
]

{ #category : 'initialization' }
TbKnob >> color2 [
	"^ (Color r: 233 g:208  b:168  range:255)."
	^ (Color r: 215 g:173  b:106  range:255).
]

{ #category : 'initialization' }
TbKnob >> color3 [
	"^ (Color r: 233 g:208  b:168  range:255)."
	^ (Color r: 174 g:138  b:80  range:255).
]

{ #category : 'initialization' }
TbKnob >> color4 [
	"^ (Color r: 233 g:208  b:168  range:255)."
	^ (Color r: 99 g:78  b:44  range:255).
]

{ #category : 'initialization' }
TbKnob >> color5 [
	"^ (Color r:189 g:240  b:240  range:255)."
	"^ (Color orange alpha:0.7)"
	^ (Color r:196 g:179  b:126  range:255).
]

{ #category : 'accessing' }
TbKnob >> currentLabel [ 

	^ currentLabel 
]

{ #category : 'accessing' }
TbKnob >> currentValue [

	^ currentValue
]

{ #category : 'accessing' }
TbKnob >> currentValue: aNumber [

	currentValue := aNumber.
	self callBack ifNotNil: [ :c | c value: currentValue ].
	"self currentLabel text: (aNumber rounded asRopedText attributes:
			 { (BlTextForegroundAttribute paint: self valueColor) })"
]

{ #category : 'accessing' }
TbKnob >> diameter [

	^ diameter
]

{ #category : 'accessing' }
TbKnob >> diameter: aNumber [

	diameter := aNumber
]

{ #category : 'accessing' }
TbKnob >> disk [

	^ disk
]

{ #category : 'accessing' }
TbKnob >> disk: anElement [

	disk := anElement 
]

{ #category : 'initialization' }
TbKnob >> diskColor [ 
	^ (Color cyan)
]

{ #category : 'initialization' }
TbKnob >> diskSize [

	^ self diameter + 40
]

{ #category : 'api - operations' }
TbKnob >> doOperations [

	self knob transformDo: [ :t | t rotateBy: angle ].
	self knob zIndex: 100.
	"self disk geometry endAngle: angle - 90."
	self currentValue: self angleToValue.

]

{ #category : 'initialization' }
TbKnob >> initialize [

	super initialize.
	self initializeDefaultValues.
	self initializeGeometry.
	self initializeEvents.

	"Here to define the centerPosition once layouted"
	self setValue: self minValue.
	self position: 0 @ 0
]

{ #category : 'accessing' }
TbKnob >> initializeDefaultValues [

	minValue := 0.
	maxValue := 100.
	stepValue := nil.
	diameter :=80.
	minAngle := -135.
	maxAngle := 135
]

{ #category : 'initialization' }
TbKnob >> initializeEvents [

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
TbKnob >> initializeGeometry [
	
	|e1 e2  st marker k kb k1 |

	self size: 140 @ 150.
	self background: (self backColor alpha:0.0).
   "self border: (BlBorder paint: (Color gray) width: 2)."
	self clipChildren: false.
	self layout: BlFrameLayout new.
	self padding:(BlInsets all: 7).
	
	e1:= BlElement new
	size: 86 asPoint;
	geometry: (BlCircleGeometry new);
	"transformDo: [ :t | t translateBy: 30@30 ];"
	background: Color veryDarkGray;
	transformDo:[:t | 
		t translateBy: -1.2@ -1.2];
	constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter];
			transformDo:[:t | t translateBy:-1.2@ 7.8];
		effect: (BlGaussianShadowEffect color: (self shadowColor)   offset: 8@25  width: 50).
	
	e2:= BlElement new
	size: 80 asPoint;
	geometry: (BlCircleGeometry new);
	"transformDo: [ :t | t translateBy: 30@30 ];"
	background: (BlRadialGradientPaint new
	stops: { 0 -> self color2. 1 -> self color1 };
	center: 15@15;
	radius: 150;
	yourself);
	constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter];
		transformDo:[:t | t translateBy:0@ 9].
	
	
		self addChildren:{ e1. e2}.
	
	
	st:= -280.
	1 to: 11 do: [:i |
	|dash curr|
	curr:= (i * 30).
	curr:= curr + st.
	curr:= curr + 10. 
	dash:= 
	 BlElement new
		           background: Color veryVeryDarkGray ;
		           size: diameter+ 30 asPoint;
	geometry: (BlAnnulusSectorGeometry new
			 startAngle: curr;
			 endAngle: curr + 2.5;
			 innerRadius: 0.85;
			 outerRadius: 1.0);	

	constraintsDo: [ :c |
	c frame horizontal alignCenter.
	c frame vertical alignCenter ];
	transformDo:[:t | t translateBy:0@ 9].	
	self addChild:dash.].
		

	


	k:= BlElement new
			 geometry: BlCircleGeometry new;
			 size: self knobSize+5 asPoint;
			 clipChildren: true;
			 background: (self color1 alpha:1);
			 constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter];
			layout: BlFrameLayout new.
		
	
	kb:= BlElement new
			 geometry: BlCircleGeometry new;
			 size: self knobSize+5 asPoint;
			 clipChildren: false;
			 background: (self color4 alpha:1.0);
			 constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter];
			transformDo:[:t | t translateBy:0@ 12];
			effect: (BlGaussianShadowEffect color: (Color brown alpha:0.7)   offset: 0@6  width: 10).
	
		self addChild:kb.
	


	
	marker := BlElement new
		          size: 15 @ 6;
		          transformDo: [ :t | t translateBy: -2 @ 0 ];
					
		          geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		          background: self color4;
		          "position: self knobSize / 2 @ 5."
					transformDo:[:t | t rotateBy:90.
						t translateBy: 0@ 5];
					 constraintsDo: [ :c |
				 	c frame horizontal alignCenter.
					 c frame vertical alignTop].
					
			marker zIndex: 100.
		k1 := BlElement new
		          size: 15 @ 80;
		          transformDo: [ :t | t translateBy: -2 @ 0 ];
					
		          geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		          background: self color5 ;
		          "position: self knobSize / 2 @ 5."
					transformDo:[:t | t rotateBy:90.
						t translateBy: 0@ 0];
					 constraintsDo: [ :c |
				 	c frame horizontal alignCenter.
					 c frame vertical alignBottom].
					
			marker zIndex: 100.
			
	k addChildren: {k1. marker}.
	
		
	self knob: k.
	self addChild: self knob.
]

{ #category : 'initialization' }
TbKnob >> initializeLabel [

	inputLabel := BlTextElement new.
	inputLabel text: (self inputText asRopedText attributes:
			 { (BlTextForegroundAttribute paint: self backColor) }).
	inputLabel text fontSize:self labelSize.
	inputLabel text bold.
	inputLabel constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignTop ].
	"inputLabel transformDo: [ :t | t translateBĀ: 0 @ 10 ]."
	self addChild: inputLabel
]

{ #category : 'accessing' }
TbKnob >> inputText [
	^ inputText.

]

{ #category : 'accessing' }
TbKnob >> inputText: aString [
	inputText := aString.

]

{ #category : 'accessing' }
TbKnob >> knob [ 

	^ knob 
]

{ #category : 'accessing' }
TbKnob >> knob: anElement [

	knob := anElement 
]

{ #category : 'initialization' }
TbKnob >> knobColor [
	^(Color white)
]

{ #category : 'initialization' }
TbKnob >> knobSize [

	^ self diameter-35
]

{ #category : 'initialization' }
TbKnob >> labelSize [
	^ 18.
]

{ #category : 'initialization' }
TbKnob >> markerColor [
	^(Color gray)
]

{ #category : 'accessing' }
TbKnob >> maxAngle [

	^ maxAngle
]

{ #category : 'accessing' }
TbKnob >> maxAngle: aNumber [

	maxAngle := aNumber 
]

{ #category : 'accessing' }
TbKnob >> maxLabel [ 

	^ maxLabel 
]

{ #category : 'accessing' }
TbKnob >> maxValue [

	^ maxValue
]

{ #category : 'accessing' }
TbKnob >> maxValue: aNumber [

	maxValue := aNumber.
	maxLabel text: ((maxValue asFloat round:3 )asRopedText attributes: { (BlTextForegroundAttribute
paint: self textColor) })
]

{ #category : 'accessing' }
TbKnob >> minAngle [ 

	^ minAngle 
]

{ #category : 'accessing' }
TbKnob >> minAngle: aNumber [

	minAngle := aNumber
]

{ #category : 'accessing' }
TbKnob >> minLabel [ 

	^ minLabel 
]

{ #category : 'accessing' }
TbKnob >> minValue [

	^ minValue 
]

{ #category : 'accessing' }
TbKnob >> minValue: aNumber [

	minValue := aNumber.
	minLabel text: ((minValue asFloat round:3 ) asRopedText attributes: { (BlTextForegroundAttribute
paint: self textColor) })
]

{ #category : 'ui building' }
TbKnob >> openForParam: aString dsp: aDsp [

	| index space spaceExtent |
	spaceExtent := self diameter * 2.
	space := BlSpace new extent: spaceExtent @ spaceExtent.
	index := aDsp getParamIndex: aString.
	space root background: Color black.
	space root addChild: self.
	"the parameter must exist!!"
	index = -1
		ifTrue: [
			^ Error new signal:
				  'Parameter named ' , aString , ' does not exist!!' ]
		ifFalse: [
			self
				minValue: (aDsp getParamMin: index);
				maxValue: (aDsp getParamMax: index);
				inputText: aString;
				callBack: [ :i | aDsp setValue: i parameter: aString ].
			space show ]
]

{ #category : 'initialization' }
TbKnob >> outerRingColor [
	^(Color darkGray )
]

{ #category : 'initialization' }
TbKnob >> outerRingSize [

	^self diameter + 40
]

{ #category : 'api - bounds' }
TbKnob >> position: aPoint [

	super position: aPoint.
	self whenLayoutedDoOnce: [
	self centerPosition: self positionInSpace + (self size / 2)]
]

{ #category : 'initialization' }
TbKnob >> setToMax [

	self setValue: self maxValue.
]

{ #category : 'initialization' }
TbKnob >> setToMin [ 

	self setValue: self minValue.
]

{ #category : 'initialization' }
TbKnob >> setValue: aNumber [

	|newAngle|
	newAngle := self valueToAngle: aNumber.
	self angle: newAngle.
]

{ #category : 'initialization' }
TbKnob >> shadowColor [
	"^ (Color r: 233 g:208  b:168  range:255)."
	"^ (Color r: 103 g:80  b:42  range:255)."
	"^ (Color orange)."
	^ (Color r: 215 g:160  b:70  range:255).
]

{ #category : 'accessing' }
TbKnob >> stepValue [

	^ stepValue
]

{ #category : 'accessing' }
TbKnob >> stepValue: aNumber [

	stepValue := aNumber
]

{ #category : 'initialization' }
TbKnob >> textColor [
	^Color white.
]

{ #category : 'initialization' }
TbKnob >> valueColor [
	^Color white.
]

{ #category : 'api - operations' }
TbKnob >> valueToAngle: aNumber [

	| normalized mapped |
	normalized := aNumber - self minValue
	              / (self maxValue - self minValue).
	mapped := normalized * (self maxAngle - self minAngle)
	          + self minAngle.
	^ mapped 
]
