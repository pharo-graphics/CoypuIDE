Class {
	#name : 'ICMixerSlider',
	#superclass : 'BlElement',
	#instVars : [
		'widgetSize',
		'handle',
		'bar',
		'coloredBar',
		'isHorizontal',
		'minValue',
		'maxValue',
		'stepValue',
		'barThickness',
		'barLength',
		'marginThickness',
		'marginLength',
		'segmented',
		'segmentedValues',
		'callBack',
		'overlayer',
		'value',
		'minLabel',
		'maxLabel',
		'label',
		'valueLabel',
		'currValueLabel',
		'name'
	],
	#category : 'CoypuIDE-slider',
	#package : 'CoypuIDE',
	#tag : 'slider'
}

{ #category : 'accessing' }
ICMixerSlider class >> beHorizontal [

	^ self new beHorizontal 
]

{ #category : 'accessing' }
ICMixerSlider class >> beVertical [ 
	
	^ self new beVertical 
]

{ #category : 'example' }
ICMixerSlider class >> example [
	"The values of the slider are also written in the transcript"

	<script>
	| slider  container |
	slider := self label:'Mixer'.
	container := BlElement new clipChildren: false.
	container addChild: slider.
	container openInSpace.
]

{ #category : 'accessing' }
ICMixerSlider class >> label: aString [ 

	|slider|
	slider := self new name: aString.
	slider initializeLabelText.
	^ slider
]

{ #category : 'instance creation' }
ICMixerSlider class >> new [

	^ self readOnly initializeEvents
]

{ #category : 'instance creation' }
ICMixerSlider class >> readOnly [

	^ self basicNew initialize
]

{ #category : 'instance creation' }
ICMixerSlider class >> readOnlyLabel: aString [

	| slider |
	slider := self readOnly name: aString.
	slider initializeLabel.
	^ slider
]

{ #category : 'accessing' }
ICMixerSlider >> bar [
	^ bar
]

{ #category : 'accessing' }
ICMixerSlider >> bar: aBlElement [ 
	bar := aBlElement
]

{ #category : 'api - bounds' }
ICMixerSlider >> barDefaultColor [ 

	^ Color veryVeryDarkGray.

]

{ #category : 'accessing' }
ICMixerSlider >> barLength [

	^ barLength
]

{ #category : 'accessing' }
ICMixerSlider >> barLength: aNumber [

	barLength := aNumber.
	self rebuild
]

{ #category : 'accessing' }
ICMixerSlider >> barThickness [ 

	^ barThickness 
]

{ #category : 'accessing' }
ICMixerSlider >> barThickness: aNumber [

	barThickness := aNumber.
	self rebuild
]

{ #category : 'api - values' }
ICMixerSlider >> basicSetValue: aNumber [

	value := aNumber.
	self callBack ifNotNil: [ :e | e value: value ]
]

{ #category : 'accessing' }
ICMixerSlider >> beHorizontal [

	self horizontal: true.
	self rebuild
]

{ #category : 'building' }
ICMixerSlider >> beSegmented [

	self stepValue
		ifNil: [ self error: 'Cannot segment a slider with a nil stepValue' ]
		ifNotNil: [ self segmented: true].
	self rebuild
]

{ #category : 'building' }
ICMixerSlider >> beSmooth [

	self segmented: false.
	self segmentedValues: nil.
	self rebuild
]

{ #category : 'accessing' }
ICMixerSlider >> beVertical [

	self horizontal: false.
	self buildVertical
]

{ #category : 'building' }
ICMixerSlider >> buildHorizontal [

	widgetSize y > widgetSize x ifTrue: [
		self widgetSize: widgetSize y @ widgetSize x ].
	self removeParts.
	self initializeParts
]

{ #category : 'building' }
ICMixerSlider >> buildVertical [

	widgetSize y > widgetSize x ifFalse: [
		self widgetSize: widgetSize y @ widgetSize x ].

	self removeParts.
	self initializeParts
]

{ #category : 'accessing' }
ICMixerSlider >> callBack [ 

	^ callBack 
]

{ #category : 'accessing' }
ICMixerSlider >> callBack: aBlock [

	callBack := aBlock 
]

{ #category : 'as yet unclassified' }
ICMixerSlider >> changeMaxValueLabelTo: aValue [

	maxLabel text: (aValue asRopedText attributes: {
				 (BlTextForegroundAttribute paint: Color white).
				 (BlFontSizeAttribute size: 12).
				 BlFontWeightAttribute bold }).
	maxValue := aValue
]

{ #category : 'as yet unclassified' }
ICMixerSlider >> changeMinValueLabelTo: aValue [

	minLabel text: (aValue asRopedText attributes: {
				 (BlTextForegroundAttribute paint: Color white).
				 (BlFontSizeAttribute size: 12).
				 BlFontWeightAttribute bold }).
	valueLabel text: (aValue asRopedText attributes: {
				 (BlTextForegroundAttribute paint: Color black).
				 (BlFontSizeAttribute size: 12).
				 BlFontWeightAttribute bold }).

	minValue := aValue.
	value := aValue
]

{ #category : 'accessing' }
ICMixerSlider >> coloredBar [ 

	^ coloredBar 
]

{ #category : 'accessing' }
ICMixerSlider >> coloredBar: aBlElement [

	coloredBar := aBlElement 
]

{ #category : 'accessing' }
ICMixerSlider >> coloredBarDefaultColor [
	^ Color veryVeryLightGray.
]

{ #category : 'setting' }
ICMixerSlider >> configuredStringDark: aString size: anInteger [
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color white) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:anInteger) }
]

{ #category : 'accessing' }
ICMixerSlider >> currValueLabel [

	^ currValueLabel
]

{ #category : 'accessing' }
ICMixerSlider >> currValueLabel: anObject [

	currValueLabel := anObject
]

{ #category : 'api - slider' }
ICMixerSlider >> decrementValue: aValue [

	| tmp |
	tmp := value - aValue.
	self setValue: tmp
]

{ #category : 'api - bounds' }
ICMixerSlider >> defaultBar [

	| size |
	size := self
		        ifHorizontal: [
		        self defaultBarLength @ self defaultBarThickness-70 ]
		        ifVertical: [
		        self defaultBarThickness-70 @ (self defaultBarLength) ].

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		  background: self barDefaultColor;
		  size: size;
		  constraintsDo: [ :c | c frame horizontal alignCenter. c frame vertical alignCenter. ];
			"constraintsDo: [ :c | c ignoreByLayout ];"
		  yourself
]

{ #category : 'api - bounds' }
ICMixerSlider >> defaultBarLength [

	^ 200
]

{ #category : 'api - bounds' }
ICMixerSlider >> defaultBarThickness [

	^ 80
]

{ #category : 'api - bounds' }
ICMixerSlider >> defaultColor [

	^ Color veryDarkGray

]

{ #category : 'accessing' }
ICMixerSlider >> defaultColoredBar [

	| size |
	size := self
		        ifHorizontal: [ 0 @ self defaultBarThickness ]
		        ifVertical: [ self defaultBarThickness @ 0.1 ].

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 0);
		  background: (self coloredBarDefaultColor alpha:0.0);
		constraintsDo: [ :c | c ignoreByLayout ];
		  size: size;
		  yourself
]

{ #category : 'api - bounds' }
ICMixerSlider >> defaultHandle [

	| e1 e2 size elt  |
	size := self
		        ifHorizontal: [ 5 @ barThickness ]
		        ifVertical: [ 25 @ 40 ].

	elt := BlElement new
		       background: self handleDefaultColor;
		       geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		effect: (BlGaussianShadowEffect color: (Color black alpha:0.6)   offset: 4@4  width: 15);
		border: (BlBorder paint: Color veryLightGray width: 2);
		constraintsDo: [ :c | c ignoreByLayout ];
		       size: size;
		       transformDo: [ :t | 
			
			       t translateBy: size negated / 2 ];
		       yourself.
	"e1:=BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		  background: self barDefaultColor;
		  size: 30@60;
		  constraintsDo: [ :c | c frame horizontal alignCenter. c frame vertical alignCenter. ];
		  yourself.
		
	^ e1."
	^elt.
]

{ #category : 'api - bounds' }
ICMixerSlider >> defaultMarginLength [

	^ 5
]

{ #category : 'api - bounds' }
ICMixerSlider >> defaultMarginThickness [

	^ 5
]

{ #category : 'api - bounds' }
ICMixerSlider >> defaultSize [
	"self bar size maybe"

	^ self
		  ifHorizontal: [
			  self defaultBarLength+120 + (2 * self defaultMarginLength)
			  @ (self defaultBarThickness + (2 * self defaultMarginThickness)) ]
		  ifVertical: [
			  self defaultBarThickness + (2 * self defaultMarginThickness)
			  @ (self defaultBarLength+120 + (2 * self defaultMarginLength)) ]
]

{ #category : 'accessing' }
ICMixerSlider >> direction [
	"Returns true if horizontal else false"
	^ self ifHorizontal: [ true ]
			 ifVertical: [ false ].
]

{ #category : 'accessing' }
ICMixerSlider >> handle [
	^ handle
]

{ #category : 'accessing' }
ICMixerSlider >> handle: aBlElement [ 
	handle := aBlElement
]

{ #category : 'api - bounds' }
ICMixerSlider >> handleDefaultColor [

	^ Color veryVeryLightGray 
]

{ #category : 'accessing' }
ICMixerSlider >> horizontal: aBoolean [

	isHorizontal := aBoolean 
]

{ #category : 'building' }
ICMixerSlider >> ifHorizontal: horizontalBlock ifVertical: verticalBlock [

	^ self isHorizontal
		ifTrue: horizontalBlock
		ifFalse: verticalBlock
]

{ #category : 'api - slider' }
ICMixerSlider >> incrementValue: aValue [

	| tmp |
	tmp := value + aValue.
	self setValue: tmp
]

{ #category : 'initialization' }
ICMixerSlider >> initialize [

	super initialize.
	isHorizontal := false.
	segmented := false.
	self initializeSizes.
	self name:''.
	self widgetSize: self defaultSize.
	self background: self defaultColor.
	self layout: BlFrameLayout new.
	self initializeValues.
	self initializeParts.
	self initializeEvents.
]

{ #category : 'initialization' }
ICMixerSlider >> initializeEvents [ 

	self addEventHandlerOn: BlMouseDownEvent do: [ :event | self moveHandleTo: event position].
	self addEventHandlerOn: BlDragStartEvent do: [ :event | event consumed: true].
	self addEventHandlerOn: BlDragEvent do: [ :event | self moveHandleTo: event position]
]

{ #category : 'initialization' }
ICMixerSlider >> initializeLabel [
	|l1|
	l1 := BlTextElement new.
	l1 text: (self configuredStringDark: self name size: 16).
	l1 border: (BlBorder paint: (Color veryDarkGray) width: 2);
	 	padding: (BlInsets all:5);
		constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignTop.
		];
	transformDo: [ :t | 
		t translateBy: 0@10.
		].
	
	self addChild: l1.
]

{ #category : 'initialization' }
ICMixerSlider >> initializeLabelText [
	|l1|
	l1 := BlTextElement new.
	l1 text: (self configuredStringDark: self name size: 16).
	l1 border: (BlBorder paint: (Color veryDarkGray) width: 2);
	 	padding: (BlInsets all:5);
		constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignTop.
		];
	transformDo: [ :t | 
		t translateBy: 0@10.
		].
	
	self addChild: l1.
]

{ #category : 'initialization' }
ICMixerSlider >> initializeLabels [
	| l2|

	
	l2 := BlTextElement new.
	l2 text: (self configuredStringDark: value size: 16).
	l2 border: (BlBorder paint: (Color veryDarkGray) width: 2);
	 	padding: (BlInsets all:5);
		constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignBottom.
		];
	transformDo: [ :t | 
		t translateBy: 0@ -10.
		].
	
		
	 currValueLabel := l2.
    self addChildren: { currValueLabel}.

	
	 self callBack: [ :v |
		currValueLabel text: (v rounded asRopedText attributes: {
					 (BlTextForegroundAttribute paint: Color white).
					 (BlFontSizeAttribute size: 15).
					 BlFontWeightAttribute bold }) ].
]

{ #category : 'initialization' }
ICMixerSlider >> initializeLines [
	|l1 l2 l3 l4 l5 l6 l7|
	
	l1:= BlElement new
		geometry: BlRectangleGeometry new;
		size:  self barThickness-30 @ 3;
		background: Color veryLightGray;
		constraintsDo: [ :c|
			c frame horizontal alignCenter.
			c frame vertical alignCenter.
		];
		transformDo:[:t|
			t translateBy:0@0.
			].
	
	l2:= BlElement new
		geometry: BlRectangleGeometry new;
		size:  self barThickness-30 @ 3;
		background: Color veryLightGray;
		constraintsDo: [ :c|
			c frame horizontal alignCenter.
			c frame vertical alignCenter.
		];
		transformDo:[:t|
			t translateBy:0@ -25.
			].
	l3:= BlElement new
		geometry: BlRectangleGeometry new;
		size:  self barThickness-30 @ 3;
		background: Color veryLightGray;
		constraintsDo: [ :c|
			c frame horizontal alignCenter.
			c frame vertical alignCenter.
		];
		transformDo:[:t|
			t translateBy:0@25.
			].
	l4:= BlElement new
		geometry: BlRectangleGeometry new;
		size:  self barThickness-30 @ 3;
		background: Color veryLightGray;
		constraintsDo: [ :c|
			c frame horizontal alignCenter.
			c frame vertical alignCenter.
		];
		transformDo:[:t|
			t translateBy:0@ -50.
			].
	l5:= BlElement new
		geometry: BlRectangleGeometry new;
		size:  self barThickness-30 @ 3;
		background: Color veryLightGray;
		constraintsDo: [ :c|
			c frame horizontal alignCenter.
			c frame vertical alignCenter.
		];
		transformDo:[:t|
			t translateBy:0 @50.
			].
	l6:= BlElement new
		geometry: BlRectangleGeometry new;
		size:  self barThickness-30 @ 3;
		background: Color veryLightGray;
		constraintsDo: [ :c|
			c frame horizontal alignCenter.
			c frame vertical alignCenter.
		];
		transformDo:[:t|
			t translateBy:0 @ -75.
			].
	l7:= BlElement new
		geometry: BlRectangleGeometry new;
		size:  self barThickness-30 @ 3;
		background: Color veryLightGray;
		constraintsDo: [ :c|
			c frame horizontal alignCenter.
			c frame vertical alignCenter.
		];
		transformDo:[:t|
			t translateBy:0 @ 75.
			].
	
	
	self addChildren: { l1. l2. l3. l4. l5. l6. l7}.
		 
]

{ #category : 'initialization' }
ICMixerSlider >> initializeParts [
	
	self initializeLines.
	self initializeLabelText.
	self initializeLabels.
	
	self bar: self defaultBar.
	self positionDefaultBar: self bar.
	self addChild: self bar.


	self coloredBar: self defaultColoredBar.
	self positionDefaultBar: self coloredBar.
	self addChild: self coloredBar.


	self handle: self defaultHandle.
	self positionDefaultHandle.
	self addChild: self handle

	"initialize segments if segmented"

	"self initializeButtons."
]

{ #category : 'initialization' }
ICMixerSlider >> initializeSizes [ 

	barLength := self defaultBarLength.
	barThickness := self defaultBarThickness.
	marginLength := self defaultMarginLength.
	marginThickness := self defaultMarginThickness.
]

{ #category : 'initialization' }
ICMixerSlider >> initializeValueLabels [

	minLabel := BlTextElement new
		            text: (self minValue asRopedText attributes: {
						             (BlTextForegroundAttribute paint: Color white).
						             (BlFontSizeAttribute size: 15).
						             BlFontWeightAttribute bold });
		            constraintsDo: [ :c |
			            c padding: (BlInsets horizontal: 15).
			            c frame horizontal alignLeft.
			            c frame vertical alignCenter ].

	maxLabel := BlTextElement new
		            text: (self maxValue asRopedText attributes: {
						             (BlTextForegroundAttribute paint: Color white).
						             (BlFontSizeAttribute size: 15).
						             BlFontWeightAttribute bold });
		            constraintsDo: [ :c |
			            c padding: (BlInsets horizontal: 15).
			            c frame horizontal alignRight.
			            c frame vertical alignCenter ].

	valueLabel := BlTextElement new
		              text: (self value asRopedText attributes: {
						               (BlTextForegroundAttribute paint: Color black).
						               (BlFontSizeAttribute size: 15).
						               BlFontWeightAttribute bold });
		              constraintsDo: [ :c |
			              c frame horizontal alignCenter.
			              c frame vertical alignCenter ].

	self addChild: minLabel.
	self addChild: valueLabel.
	self addChild: maxLabel.

	self callBack: [ :v |
		valueLabel text: (v rounded asRopedText attributes: {
					 (BlTextForegroundAttribute paint: Color black).
					 (BlFontSizeAttribute size: 15).
					 BlFontWeightAttribute bold }) ]
]

{ #category : 'initialization' }
ICMixerSlider >> initializeValues [

	self minValue: 0.
	self maxValue: 100.
	value := self minValue 
]

{ #category : 'accessing' }
ICMixerSlider >> isHorizontal [ 

	^ isHorizontal 
]

{ #category : 'testing' }
ICMixerSlider >> isSegmented [ 

	^ segmented 
]

{ #category : 'accessing' }
ICMixerSlider >> label [

	^ label
]

{ #category : 'accessing' }
ICMixerSlider >> marginLength [

	^ marginLength
]

{ #category : 'accessing' }
ICMixerSlider >> marginLength: aNumber [

	marginLength := aNumber.
	self rebuild
]

{ #category : 'accessing' }
ICMixerSlider >> marginThickness [ 

	^ marginThickness 
]

{ #category : 'accessing' }
ICMixerSlider >> marginThickness: aNumber [

	marginThickness := aNumber.
	self rebuild
]

{ #category : 'accessing' }
ICMixerSlider >> maxLabel [

	^ maxLabel
]

{ #category : 'accessing' }
ICMixerSlider >> maxValue [

	^ maxValue
]

{ #category : 'accessing' }
ICMixerSlider >> maxValue: aNumber [

	maxValue := aNumber
]

{ #category : 'accessing' }
ICMixerSlider >> minLabel [ 

	^ minLabel 
]

{ #category : 'accessing' }
ICMixerSlider >> minValue [ 

	^ minValue 
]

{ #category : 'accessing' }
ICMixerSlider >> minValue: aNumber [

	minValue := aNumber 
]

{ #category : 'api - transformations' }
ICMixerSlider >> moveHandleTo: aPosition [

	| newPos |
	newPos := aPosition.
	"deal with segmentation"
	self isSegmented ifTrue: [
		| value |
		value := self valueAtCoord: aPosition.
		newPos := self valueToCoord: value ].
	self
		ifHorizontal: [
			| newPosX |
			newPosX := newPos x.
			newPos x < bar position x ifTrue: [ newPosX := bar position x ].
			newPos x > (bar position x + barLength) ifTrue: [
				newPosX := bar position x + barLength ].
			newPos := newPosX @ handle position y.
			handle position: newPos ]
		ifVertical: [
			| newPosY |
			newPosY := newPos y.
			newPos y < bar position y ifTrue: [ newPosY := bar position y ].
			newPos y > (bar position y + barLength) ifTrue: [
				newPosY := bar position y + barLength ].
			newPos := handle position x @ newPosY.
			handle position: newPos ].
	self updateColoredBarTo: newPos.
	self basicSetValue: (self valueAtCoord: newPos)
]

{ #category : 'accessing' }
ICMixerSlider >> name [ 

	^ name
]

{ #category : 'accessing' }
ICMixerSlider >> name: aString [ 

	name := aString 
]

{ #category : 'api - values' }
ICMixerSlider >> nearestValue: aValue [

	| val minResult tmp tmp2 values |
	self isSegmented ifFalse: [ ^ aValue].
	values := self segmentedValues.
	val := values first.
	minResult := (aValue - val) abs.
	2 to: values size do: [ :e |
		tmp := values at: e.
		tmp2 := (aValue - tmp) abs.
		tmp2 < minResult ifTrue: [
			minResult := tmp2.
			val := tmp ] ].
	^ val
]

{ #category : 'api - transformations' }
ICMixerSlider >> positionDefaultBar: aBar [

	self
		ifHorizontal: [
			aBar position:
				self defaultMarginLength @ self defaultMarginThickness ]
		ifVertical: [
			aBar position:
				self defaultMarginThickness @ self defaultMarginLength ]
]

{ #category : 'api - transformations' }
ICMixerSlider >> positionDefaultHandle [

	self
		ifHorizontal: [
		handle position: self defaultMarginLength @ (widgetSize y / 2) ]
		ifVertical: [
			handle position:
				widgetSize x / 2 @ (self defaultMarginLength + barLength + 60)
		]
]

{ #category : 'building' }
ICMixerSlider >> rebuild [

	self
		ifHorizontal: [ self buildHorizontal ]
		ifVertical: [ self buildVertical ]
]

{ #category : 'removing' }
ICMixerSlider >> removeParts [

	self removeChildren. 
	bar := nil.
	handle := nil
]

{ #category : 'accessing' }
ICMixerSlider >> segmented: aBoolean [ 

	segmented := aBoolean
]

{ #category : 'accessing' }
ICMixerSlider >> segmentedValues [

	segmentedValues ifNil: [	segmentedValues := (self minValue to: self maxValue by:
	                    self stepValue) asOrderedCollection].
	^ segmentedValues
]

{ #category : 'accessing' }
ICMixerSlider >> segmentedValues: aCollection [ 

	segmentedValues := aCollection 
]

{ #category : 'initialization' }
ICMixerSlider >> setToMax [

	"this method is created with a button that would set to max in the widget"
	self setValue: self maxValue.
]

{ #category : 'initialization' }
ICMixerSlider >> setToMin [ 

	"this method is created with a button that would set to max in the widget"
	self setValue: self minValue.
]

{ #category : 'accessing' }
ICMixerSlider >> setValue: aNumber [

	| newValue |
	newValue := aNumber.
	aNumber < self minValue ifTrue: [ newValue := minValue ].
	aNumber > self maxValue ifTrue: [ newValue := maxValue ].

	self moveHandleTo: (self valueToCoord: newValue)
]

{ #category : 'api - bounds' }
ICMixerSlider >> size: aValue [
	"just to keep the widgset size"

	super size: aValue.
	
	" for now do not support resize
	
	self isBuildSlider ifTrue: [ self rebuildSlider ]
	"
]

{ #category : 'accessing' }
ICMixerSlider >> stepValue [

	^ stepValue 
]

{ #category : 'accessing' }
ICMixerSlider >> stepValue: aNumber [

	stepValue := aNumber 
	
]

{ #category : 'api - transformations' }
ICMixerSlider >> updateColoredBarTo: aPosition [

	self
		ifHorizontal: [
			coloredBar position: bar position.
			coloredBar size: (aPosition - coloredBar position) x @ barThickness ]
		ifVertical: [
			coloredBar position: aPosition x - (barThickness / 2) @ aPosition y.
			coloredBar size:
				barThickness @ (bar position y + barLength - aPosition y) ]
]

{ #category : 'accessing' }
ICMixerSlider >> value [ 

	^ value 
]

{ #category : 'api - transformations' }
ICMixerSlider >> valueAtCoord: aPoint [

	^ self
		  ifHorizontal: [ self valueAtX: aPoint ]
		  ifVertical: [ self valueAtY: aPoint ]
]

{ #category : 'api - transformations' }
ICMixerSlider >> valueAtX: aPoint [

	| dist valueDiff value coeff |
	dist := (aPoint - bar position) x.
	dist = 0
		ifTrue: [ value := minValue ]
		ifFalse: [
			valueDiff := maxValue - minValue.
			coeff := barLength / dist.
			value := minValue + (valueDiff / coeff) ].
	value := self nearestValue: value.
	
	^ value asFloat
]

{ #category : 'api - transformations' }
ICMixerSlider >> valueAtY: aPoint [

	| dist valueDiff value coeff |
	dist := bar position y + barLength - aPoint y.
	dist = 0
		ifTrue: [ value := minValue ]
		ifFalse: [
			valueDiff := maxValue - minValue.
			coeff := barLength / dist.
			value := minValue + (valueDiff / coeff) ].
	value := self nearestValue: value.
	^ value asFloat
]

{ #category : 'accessing' }
ICMixerSlider >> valueLabel [

	^ valueLabel
]

{ #category : 'api - transformations' }
ICMixerSlider >> valueToCoord: aNumber [

	^ self
		  ifHorizontal: [ self valueToX: aNumber ]
		  ifVertical: [ self valueToY: aNumber ]
]

{ #category : 'api - transformations' }
ICMixerSlider >> valueToX: aNumber [

	| dist valueDiff coeff |
	valueDiff := aNumber - minValue.
	coeff := (valueDiff / (maxValue - minValue)) asFloat.
	dist := marginLength + (coeff * barLength).
	self forceLocalLayout.
	"This is needed so handle position != 0"
	^ dist @ handle position y
]

{ #category : 'api - transformations' }
ICMixerSlider >> valueToY: aNumber [

	| dist valueDiff coeff |
	valueDiff := aNumber - minValue.
	coeff := (valueDiff / (maxValue - minValue)) asFloat.
	dist := marginLength + barLength - (coeff * barLength).
	self forceLocalLayout.
	"This is needed so handle position != 0"
	^ handle position x @ dist
]

{ #category : 'accessing' }
ICMixerSlider >> widgetSize [ 

	^ widgetSize 
]

{ #category : 'accessing' }
ICMixerSlider >> widgetSize: aNumber [

	widgetSize := aNumber.
	self size: aNumber 
]
