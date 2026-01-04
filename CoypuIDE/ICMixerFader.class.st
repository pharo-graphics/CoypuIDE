"
Mix console fader, usually used for level staging
"
Class {
	#name : 'ICMixerFader',
	#superclass : 'ICSlider',
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
ICMixerFader class >> beHorizontal [

	^ self new beHorizontal 
]

{ #category : 'accessing' }
ICMixerFader class >> beVertical [ 
	
	^ self new beVertical 
]

{ #category : 'example' }
ICMixerFader class >> example [
	"The values of the slider are also written in the transcript"

	<script>
	| slider  container |
	slider := self label:'Mixer'.
	container := BlElement new clipChildren: false.
	container addChild: slider.
	container openInSpace.
]

{ #category : 'accessing' }
ICMixerFader class >> label: aString [

	| slider |
	slider := self new name: aString.
	slider initializeLabelText.
	^ slider
]

{ #category : 'instance creation' }
ICMixerFader class >> new [

	^ self readOnly initializeEvents
]

{ #category : 'instance creation' }
ICMixerFader class >> readOnly [

	^ self basicNew initialize
]

{ #category : 'instance creation' }
ICMixerFader class >> readOnlyLabel: aString [

	| slider |
	slider := self readOnly name: aString.
	slider initializeLabel.
	^ slider
]

{ #category : 'accessing' }
ICMixerFader >> bar [
	^ bar
]

{ #category : 'accessing' }
ICMixerFader >> bar: aBlElement [ 
	bar := aBlElement
]

{ #category : 'api - bounds' }
ICMixerFader >> barDefaultColor [

	^ Color black 
]

{ #category : 'accessing' }
ICMixerFader >> barLength [

	^ barLength
]

{ #category : 'accessing' }
ICMixerFader >> barLength: aNumber [

	barLength := aNumber.
	self rebuild
]

{ #category : 'accessing' }
ICMixerFader >> barThickness [ 

	^ barThickness 
]

{ #category : 'accessing' }
ICMixerFader >> barThickness: aNumber [

	barThickness := aNumber.
	self rebuild
]

{ #category : 'api - values' }
ICMixerFader >> basicSetValue: aNumber [

	value := aNumber.
	self callBack ifNotNil: [ :e | e value: value ]
]

{ #category : 'accessing' }
ICMixerFader >> beHorizontal [

	self horizontal: true.
	self rebuild
]

{ #category : 'building' }
ICMixerFader >> beSegmented [

	self stepValue
		ifNil: [ self error: 'Cannot segment a slider with a nil stepValue' ]
		ifNotNil: [ self segmented: true].
	self rebuild
]

{ #category : 'building' }
ICMixerFader >> beSmooth [

	self segmented: false.
	self segmentedValues: nil.
	self rebuild
]

{ #category : 'accessing' }
ICMixerFader >> beVertical [

	self horizontal: false.
	self buildVertical
]

{ #category : 'building' }
ICMixerFader >> buildHorizontal [

	widgetSize y > widgetSize x ifTrue: [
		self widgetSize: widgetSize y @ widgetSize x ].
	self removeParts.
	self initializeParts
]

{ #category : 'building' }
ICMixerFader >> buildVertical [

	widgetSize y > widgetSize x ifFalse: [
		self widgetSize: widgetSize y @ widgetSize x ].

	self removeParts.
	self initializeParts
]

{ #category : 'accessing' }
ICMixerFader >> callBack [ 

	^ callBack 
]

{ #category : 'accessing' }
ICMixerFader >> callBack: aBlock [

	callBack := aBlock 
]

{ #category : 'accessing' }
ICMixerFader >> changeMaxValueLabelTo: aValue [

	maxLabel text: (aValue asRopedText attributes: {
				 (BlTextForegroundAttribute paint: Color white).
				 (BlFontSizeAttribute size: 12).
				 BlFontWeightAttribute bold }).
	maxValue := aValue
]

{ #category : 'accessing' }
ICMixerFader >> changeMinValueLabelTo: aValue [

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
ICMixerFader >> coloredBar [ 

	^ coloredBar 
]

{ #category : 'accessing' }
ICMixerFader >> coloredBar: aBlElement [

	coloredBar := aBlElement 
]

{ #category : 'accessing' }
ICMixerFader >> coloredBarDefaultColor [
	^ Color veryVeryLightGray.
]

{ #category : 'setting' }
ICMixerFader >> configuredStringDark: aString size: anInteger [
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color white) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:anInteger) }
]

{ #category : 'accessing' }
ICMixerFader >> currValueLabel [

	^ currValueLabel
]

{ #category : 'accessing' }
ICMixerFader >> currValueLabel: anObject [

	currValueLabel := anObject
]

{ #category : 'api - slider' }
ICMixerFader >> decrementValue: aValue [

	| tmp |
	tmp := value - aValue.
	self setValue: tmp
]

{ #category : 'api - bounds' }
ICMixerFader >> defaultBar [

	| size |
	size := self
		        ifHorizontal: [ self defaultBarLength @ self defaultBarThickness - 70 ]
		        ifVertical: [ self defaultBarThickness - 60 @ self defaultBarLength ].

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		  background: self barDefaultColor;
		  extent: size;
		  constraintsDo: [ :c |
				  c frame horizontal alignCenter.
				  c frame vertical alignCenter ];
		  "constraintsDo: [ :c | c ignoreByLayout ];"yourself
]

{ #category : 'api - bounds' }
ICMixerFader >> defaultBarLength [

	^ 120
]

{ #category : 'api - bounds' }
ICMixerFader >> defaultBarThickness [

	^ 70
]

{ #category : 'api - bounds' }
ICMixerFader >> defaultColor [

	^ Color veryDarkGray

]

{ #category : 'accessing' }
ICMixerFader >> defaultColoredBar [

	| size |
	size := self ifHorizontal: [ 0 @ self defaultBarThickness ] ifVertical: [ self defaultBarThickness @ 0.1 ].

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 0);
		  background: (self coloredBarDefaultColor alpha: 0.0);
		  constraintsDo: [ :c | c ignoreByLayout ];
		  extent: size;
		  yourself
]

{ #category : 'api - bounds' }
ICMixerFader >> defaultHandle [

	| e1 e2 size elt |
	size := self ifHorizontal: [ 5 @ barThickness ] ifVertical: [ 20 @ 40 ].

	elt := BlElement new
		       background: self handleDefaultColor;
		       geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		       effect: (BlGaussianShadowEffect color: (Color black alpha: 0.6) offset: 4 @ 4 width: 15);
		       border: (BlBorder paint: Color veryLightGray width: 2);
		       constraintsDo: [ :c | c ignoreByLayout ];
		       extent: size;
		       transformDo: [ :t | t translateBy: size negated / 2 ];
		       yourself. "e1:=BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		  background: self barDefaultColor;
		  size: 30@60;
		  constraintsDo: [ :c | c frame horizontal alignCenter. c frame vertical alignCenter. ];
		  yourself.
		
	^ e1."
	^ elt
]

{ #category : 'api - bounds' }
ICMixerFader >> defaultMarginLength [

	^ 2
]

{ #category : 'api - bounds' }
ICMixerFader >> defaultMarginThickness [

	^ 2
]

{ #category : 'api - bounds' }
ICMixerFader >> defaultSize [
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
ICMixerFader >> direction [
	"Returns true if horizontal else false"
	^ self ifHorizontal: [ true ]
			 ifVertical: [ false ].
]

{ #category : 'ui building' }
ICMixerFader >> fromDictionary: aDictionary forDsp: aDsp [

	| labelWithoutSuffix |
	labelWithoutSuffix := (aDictionary at: #shortname) allButLast: 6.
	^ ((self class label: labelWithoutSuffix)
		   minValue: (aDictionary at: #min);
		   maxValue: (aDictionary at: #max);
		   callBack: [ :i |
				   
				   aDsp setValue: i parameter: (aDictionary at: #shortname) ])
		  setValue: (aDictionary at: #init);
		  stepValue: (aDictionary at: #step)
]

{ #category : 'accessing' }
ICMixerFader >> handle [
	^ handle
]

{ #category : 'accessing' }
ICMixerFader >> handle: aBlElement [ 
	handle := aBlElement
]

{ #category : 'api - bounds' }
ICMixerFader >> handleDefaultColor [

	^ Color veryVeryLightGray 
]

{ #category : 'accessing' }
ICMixerFader >> horizontal: aBoolean [

	isHorizontal := aBoolean 
]

{ #category : 'building' }
ICMixerFader >> ifHorizontal: horizontalBlock ifVertical: verticalBlock [

	^ self isHorizontal
		ifTrue: horizontalBlock
		ifFalse: verticalBlock
]

{ #category : 'api - slider' }
ICMixerFader >> incrementValue: aValue [

	| tmp |
	tmp := value + aValue.
	self setValue: tmp
]

{ #category : 'initialization' }
ICMixerFader >> initialize [

	super initialize.
	isHorizontal := false.
	segmented := false.
	self initializeSizes.
	self name: ''.
	self widgetSize: self defaultSize .
	self background: self defaultColor.
	self layout: BlFrameLayout new.
	self initializeValues.
	self initializeParts.
	self initializeEvents
]

{ #category : 'initialization' }
ICMixerFader >> initializeEvents [

	self addEventHandlerOn: BlMouseDownEvent do: [ :event |
		self moveHandleTo: event localPosition.
		 ].
	self
		addEventHandlerOn: BlDragStartEvent
		do: [ :event | event consumed: true ].
	self
		addEventHandlerOn: BlDragEvent
		do: [ :event | self moveHandleTo: event localPosition ].
]

{ #category : 'initialization' }
ICMixerFader >> initializeLabel [

	| l1 |
	l1 := BlTextElement new.
	l1 text: (self configuredStringDark: self name size: 16).
	l1
		border: (BlBorder paint: Color red width: 2);
		padding: (BlInsets all: 5);
		constraintsDo: [ :c |
				c frame horizontal alignCenter.
				c frame vertical alignTop ];
		transformDo: [ :t | t translateBy: 0 @ 10 ].

	self addChild: l1
]

{ #category : 'initialization' }
ICMixerFader >> initializeLabelText [

	| l1 |
	l1 := BlTextElement new.
	l1 text: (self configuredStringDark: self name size: 12).
	l1
		border: (BlBorder paint: Color veryDarkGray width: 2);
		padding: (BlInsets all: 5);
		constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignTop ];
		transformDo: [ :t | t translateBy: 0 @ 10 ].

	self addChild: l1
]

{ #category : 'initialization' }
ICMixerFader >> initializeLabels [

	| l2 |
	l2 := BlTextElement new.
	l2 text: (self configuredStringDark: value size: 16). 
	l2
		border: (BlBorder paint: Color veryDarkGray width: 2);
		padding: (BlInsets all: 5);
		constraintsDo: [ :c |
				c frame horizontal alignCenter.
				c frame vertical alignBottom ];
		transformDo: [ :t | t translateBy: 0 @ -10 ].

	currValueLabel := l2.
	self addChildren: { currValueLabel }.


	self callBack: [ :v | "currValueLabel text: (v rounded asRopedText attributes: {
						 (BlTextForegroundAttribute paint: Color white).
						 (BlFontSizeAttribute size: 15).
						 BlFontWeightAttribute bold }) "
		 ]
]

{ #category : 'initialization' }
ICMixerFader >> initializeLines [

	| l1 l2 l3 l4 l5 l6 l7 |
	l1 := BlElement new
		      geometry: BlRectangleGeometry new;
		      extent: self barThickness - 30 @ 3;
		      background: Color veryLightGray;
		      constraintsDo: [ :c |
				      c frame horizontal alignCenter.
				      c frame vertical alignCenter ];
		      transformDo: [ :t | t translateBy: 0 @ 0 ].

	l2 := BlElement new
		      geometry: BlRectangleGeometry new;
		      extent: self barThickness - 30 @ 3;
		      background: Color veryLightGray;
		      constraintsDo: [ :c |
				      c frame horizontal alignCenter.
				      c frame vertical alignCenter ];
		      transformDo: [ :t | t translateBy: 0 @ -25 ].
	l3 := BlElement new
		      geometry: BlRectangleGeometry new;
		      extent: self barThickness - 30 @ 3;
		      background: Color veryLightGray;
		      constraintsDo: [ :c |
				      c frame horizontal alignCenter.
				      c frame vertical alignCenter ];
		      transformDo: [ :t | t translateBy: 0 @ 25 ].
	l4 := BlElement new
		      geometry: BlRectangleGeometry new;
		      extent: self barThickness - 30 @ 3;
		      background: Color veryLightGray;
		      constraintsDo: [ :c |
				      c frame horizontal alignCenter.
				      c frame vertical alignCenter ];
		      transformDo: [ :t | t translateBy: 0 @ -50 ].
	l5 := BlElement new
		      geometry: BlRectangleGeometry new;
		      extent: self barThickness - 30 @ 3;
		      background: Color veryLightGray;
		      constraintsDo: [ :c |
				      c frame horizontal alignCenter.
				      c frame vertical alignCenter ];
		      transformDo: [ :t | t translateBy: 0 @ 50 ].
	l6 := BlElement new
		      geometry: BlRectangleGeometry new;
		      extent: self barThickness - 30 @ 3;
		      background: Color veryLightGray;
		      constraintsDo: [ :c |
				      c frame horizontal alignCenter.
				      c frame vertical alignCenter ];
		      transformDo: [ :t | t translateBy: 0 @ -75 ].
	l7 := BlElement new
		      geometry: BlRectangleGeometry new;
		      extent: self barThickness - 30 @ 3;
		      background: Color veryLightGray;
		      constraintsDo: [ :c |
				      c frame horizontal alignCenter.
				      c frame vertical alignCenter ];
		      transformDo: [ :t | t translateBy: 0 @ 75 ].


	self addChildren: {
			l1.
			l2.
			l3.
			l4.
			l5 "l6" "l7 " }
]

{ #category : 'initialization' }
ICMixerFader >> initializeParts [

	self initializeLines.
	"self initializeLabelText." "	self initializeLabels."

	self bar: self defaultBar.
	self positionDefaultBar: self bar.
	self addChild: self bar.


	self coloredBar: self defaultColoredBar.
	self positionDefaultBar: self coloredBar.
	self addChild: self coloredBar.


	self handle: self defaultHandle.
	self positionDefaultHandle.
	self addChild: self handle "initialize segments if segmented" "self initializeButtons."
]

{ #category : 'initialization' }
ICMixerFader >> initializeSizes [ 

	barLength := self defaultBarLength.
	barThickness := self defaultBarThickness.
	marginLength := self defaultMarginLength.
	marginThickness := self defaultMarginThickness.
]

{ #category : 'initialization' }
ICMixerFader >> initializeValueLabels [

	minLabel := BlTextElement new
		            text: (self minValue asRopedText attributes: {
						             (BlTextForegroundAttribute paint: Color red).
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
				              c frame vertical alignCenter ]. "self addChild: minLabel."
	"self addChild: valueLabel." "self addChild: maxLabel."

	self callBack: [ :v |
			valueLabel text: (v rounded asRopedText attributes: {
						 (BlTextForegroundAttribute paint: Color black).
						 (BlFontSizeAttribute size: 15).
						 BlFontWeightAttribute bold }) ]
]

{ #category : 'initialization' }
ICMixerFader >> initializeValues [

	self minValue: 0.
	self maxValue: 100.
	value := self minValue 
]

{ #category : 'accessing' }
ICMixerFader >> isHorizontal [ 

	^ isHorizontal 
]

{ #category : 'testing' }
ICMixerFader >> isSegmented [ 

	^ segmented 
]

{ #category : 'accessing' }
ICMixerFader >> label [

	^ label
]

{ #category : 'accessing' }
ICMixerFader >> marginLength [

	^ marginLength
]

{ #category : 'accessing' }
ICMixerFader >> marginLength: aNumber [

	marginLength := aNumber.
	self rebuild
]

{ #category : 'accessing' }
ICMixerFader >> marginThickness [ 

	^ marginThickness 
]

{ #category : 'accessing' }
ICMixerFader >> marginThickness: aNumber [

	marginThickness := aNumber.
	self rebuild
]

{ #category : 'accessing' }
ICMixerFader >> maxLabel [

	^ maxLabel
]

{ #category : 'accessing' }
ICMixerFader >> maxValue [

	^ maxValue
]

{ #category : 'accessing' }
ICMixerFader >> maxValue: aNumber [

	maxValue := aNumber
]

{ #category : 'accessing' }
ICMixerFader >> minLabel [ 

	^ minLabel 
]

{ #category : 'accessing' }
ICMixerFader >> minValue [ 

	^ minValue 
]

{ #category : 'accessing' }
ICMixerFader >> minValue: aNumber [

	minValue := aNumber 
]

{ #category : 'api - transformations' }
ICMixerFader >> moveHandleTo: aPosition [

	| newPos |
	newPos := aPosition.
	"deal with segmentation"
	self isSegmented ifTrue: [
		"| value |"
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
ICMixerFader >> name [ 

	^ name
]

{ #category : 'accessing' }
ICMixerFader >> name: aString [

	name := aString.
	"self initializeLabels"
]

{ #category : 'api - values' }
ICMixerFader >> nearestValue: aValue [

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
ICMixerFader >> positionDefaultBar: aBar [

	self
		ifHorizontal: [
			aBar position:
				self defaultMarginLength @ self defaultMarginThickness ]
		ifVertical: [
			aBar position:
				self defaultMarginThickness @ self defaultMarginLength ]
]

{ #category : 'api - transformations' }
ICMixerFader >> positionDefaultHandle [

	self
		ifHorizontal: [
		handle position: self defaultMarginLength @ (widgetSize y / 2) ]
		ifVertical: [
			handle position:
				widgetSize x / 2 @ (self defaultMarginLength + barLength + 60)
		]
]

{ #category : 'building' }
ICMixerFader >> rebuild [

	self
		ifHorizontal: [ self buildHorizontal ]
		ifVertical: [ self buildVertical ]
]

{ #category : 'removing' }
ICMixerFader >> removeParts [

	self removeChildren. 
	bar := nil.
	handle := nil
]

{ #category : 'accessing' }
ICMixerFader >> segmented: aBoolean [ 

	segmented := aBoolean
]

{ #category : 'accessing' }
ICMixerFader >> segmentedValues [

	segmentedValues ifNil: [	segmentedValues := (self minValue to: self maxValue by:
	                    self stepValue) asOrderedCollection].
	^ segmentedValues
]

{ #category : 'accessing' }
ICMixerFader >> segmentedValues: aCollection [ 

	segmentedValues := aCollection 
]

{ #category : 'initialization' }
ICMixerFader >> setToMax [

	"this method is created with a button that would set to max in the widget"
	self setValue: self maxValue.
]

{ #category : 'initialization' }
ICMixerFader >> setToMin [ 

	"this method is created with a button that would set to max in the widget"
	self setValue: self minValue.
]

{ #category : 'accessing' }
ICMixerFader >> setValue: aNumber [

	| newValue |
	newValue := aNumber.
	aNumber < self minValue ifTrue: [ newValue := minValue ].
	aNumber > self maxValue ifTrue: [ newValue := maxValue ].

	self moveHandleTo: (self valueToCoord: newValue)
]

{ #category : 'api - bounds' }
ICMixerFader >> size: aValue [
	"just to keep the widgset size"

	super extent: aValue " for now do not support resize
	
	self isBuildSlider ifTrue: [ self rebuildSlider ]
	"
]

{ #category : 'accessing' }
ICMixerFader >> stepValue [

	^ stepValue 
]

{ #category : 'accessing' }
ICMixerFader >> stepValue: aNumber [

	stepValue := aNumber 
	
]

{ #category : 'api - transformations' }
ICMixerFader >> updateColoredBarTo: aPosition [

	self
		ifHorizontal: [
				coloredBar position: bar position.
				coloredBar size: (aPosition - coloredBar position) x @ barThickness ]
		ifVertical: [
				coloredBar position: aPosition x - (barThickness / 2) @ aPosition y.
				coloredBar extent: barThickness @ (bar position y + barLength - aPosition y) ]
]

{ #category : 'accessing' }
ICMixerFader >> value [ 

	^ value 
]

{ #category : 'api - transformations' }
ICMixerFader >> valueAtCoord: aPoint [

	^ self
		  ifHorizontal: [ self valueAtX: aPoint ]
		  ifVertical: [ self valueAtY: aPoint ]
]

{ #category : 'api - transformations' }
ICMixerFader >> valueAtX: aPoint [

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
ICMixerFader >> valueAtY: aPoint [

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
ICMixerFader >> valueLabel [

	^ valueLabel
]

{ #category : 'api - transformations' }
ICMixerFader >> valueToCoord: aNumber [

	^ self
		  ifHorizontal: [ self valueToX: aNumber ]
		  ifVertical: [ self valueToY: aNumber ]
]

{ #category : 'api - transformations' }
ICMixerFader >> valueToX: aNumber [

	| dist valueDiff coeff |
	valueDiff := aNumber - minValue.
	coeff := (valueDiff / (maxValue - minValue)) asFloat.
	dist := marginLength + (coeff * barLength).
	self forceLocalLayout.
	"This is needed so handle position != 0"
	^ dist @ handle position y
]

{ #category : 'api - transformations' }
ICMixerFader >> valueToY: aNumber [

	| dist valueDiff coeff |
	valueDiff := aNumber - minValue.
	coeff := (valueDiff / (maxValue - minValue)) asFloat.
	dist := marginLength + barLength - (coeff * barLength).
	self forceLocalLayout.
	"This is needed so handle position != 0"
	^ handle position x @ dist
]

{ #category : 'accessing' }
ICMixerFader >> widgetSize [ 

	^ widgetSize 
]

{ #category : 'accessing' }
ICMixerFader >> widgetSize: aNumber [

	widgetSize := aNumber.
	self size: aNumber 
]
