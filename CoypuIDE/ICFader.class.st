Class {
	#name : 'ICFader',
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
		'name'
	],
	#category : 'CoypuIDE-slider',
	#package : 'CoypuIDE',
	#tag : 'slider'
}

{ #category : 'accessing' }
ICFader class >> beHorizontal [

	^ self new beHorizontal 
]

{ #category : 'accessing' }
ICFader class >> beVertical [ 
	
	^ self new beVertical 
]

{ #category : 'accessing' }
ICFader class >> label: aString [ 

	|slider|
	slider := self new name: aString.
	slider initializeLabel.
	^ slider
]

{ #category : 'instance creation' }
ICFader class >> new [

	^ self readOnly initializeEvents
]

{ #category : 'instance creation' }
ICFader class >> readOnly [

	^ self basicNew initialize
]

{ #category : 'instance creation' }
ICFader class >> readOnlyLabel: aString [

	| slider |
	slider := self readOnly name: aString.
	slider initializeLabel.
	^ slider
]

{ #category : 'as yet unclassified' }
ICFader class >> simpleExampleHorizontal [
	"The values of the slider are also written in the transcript"

	<script>
	| slider textElt container |
	slider := self beHorizontal.
	textElt := BlTextElement new position: slider defaultSize.

	textElt text: slider value asRopedText.

	slider callBack: [ :value | textElt text: value asRopedText ].

	container := BlElement new clipChildren: false.

	container addChild: slider.
	container addChild: textElt.

	container openInSpace
]

{ #category : 'as yet unclassified' }
ICFader class >> simpleExampleVertical [
	"The values of the slider are also written in the transcript"

	<script>
	| slider textElt container |
	slider := self beVertical.
	textElt := BlTextElement new position: slider defaultSize.

	textElt text: slider value asRopedText.

	slider callBack: [ :value | textElt text: value asRopedText ].

	container := BlElement new clipChildren: false.

	container addChild: slider.
	container addChild: textElt.

	container openInSpace
]

{ #category : 'accessing' }
ICFader >> bar [
	^ bar
]

{ #category : 'accessing' }
ICFader >> bar: aBlElement [ 
	bar := aBlElement
]

{ #category : 'api - bounds' }
ICFader >> barDefaultColor [ 

	^ Color lightGray

]

{ #category : 'accessing' }
ICFader >> barLength [

	^ barLength
]

{ #category : 'accessing' }
ICFader >> barLength: aNumber [

	barLength := aNumber.
	self rebuild
]

{ #category : 'accessing' }
ICFader >> barThickness [ 

	^ barThickness 
]

{ #category : 'accessing' }
ICFader >> barThickness: aNumber [

	barThickness := aNumber.
	self rebuild
]

{ #category : 'api - values' }
ICFader >> basicSetValue: aNumber [

	value := aNumber.
	self callBack ifNotNil: [ :e | e value: value ]
]

{ #category : 'accessing' }
ICFader >> beHorizontal [

	self horizontal: true.
	self rebuild
]

{ #category : 'building' }
ICFader >> beSegmented [

	self stepValue
		ifNil: [ self error: 'Cannot segment a slider with a nil stepValue' ]
		ifNotNil: [ self segmented: true].
	self rebuild
]

{ #category : 'building' }
ICFader >> beSmooth [

	self segmented: false.
	self segmentedValues: nil.
	self rebuild
]

{ #category : 'accessing' }
ICFader >> beVertical [

	self horizontal: false.
	self buildVertical
]

{ #category : 'building' }
ICFader >> buildHorizontal [

	widgetSize y > widgetSize x ifTrue: [
		self widgetSize: widgetSize y @ widgetSize x ].
	self removeParts.
	self initializeParts
]

{ #category : 'building' }
ICFader >> buildVertical [

	widgetSize y > widgetSize x ifFalse: [
		self widgetSize: widgetSize y @ widgetSize x ].

	self removeParts.
	self initializeParts
]

{ #category : 'accessing' }
ICFader >> callBack [ 

	^ callBack 
]

{ #category : 'accessing' }
ICFader >> callBack: aBlock [

	callBack := aBlock 
]

{ #category : 'as yet unclassified' }
ICFader >> changeMaxValueLabelTo: aValue [

	maxLabel text: (aValue asRopedText attributes: {
				 (BlTextForegroundAttribute paint: Color white).
				 (BlFontSizeAttribute size: 12).
				 BlFontWeightAttribute bold }).
	maxValue := aValue
]

{ #category : 'as yet unclassified' }
ICFader >> changeMinValueLabelTo: aValue [

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
ICFader >> coloredBar [ 

	^ coloredBar 
]

{ #category : 'accessing' }
ICFader >> coloredBar: aBlElement [

	coloredBar := aBlElement 
]

{ #category : 'accessing' }
ICFader >> coloredBarDefaultColor [
	^ Color green alpha: 0.6
]

{ #category : 'api - slider' }
ICFader >> decrementValue: aValue [

	| tmp |
	tmp := value - aValue.
	self setValue: tmp
]

{ #category : 'api - bounds' }
ICFader >> defaultBar [

	| size |
	size := self
		        ifHorizontal: [
		        self defaultBarLength @ self defaultBarThickness ]
		        ifVertical: [
		        self defaultBarThickness @ self defaultBarLength ].

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		  background: self barDefaultColor;
		  size: size;
		constraintsDo: [ :c | c ignoreByLayout ];
		  yourself
]

{ #category : 'api - bounds' }
ICFader >> defaultBarLength [

	^ 100
]

{ #category : 'api - bounds' }
ICFader >> defaultBarThickness [

	^ 20
]

{ #category : 'api - bounds' }
ICFader >> defaultColor [

	^ Color veryDarkGray
]

{ #category : 'accessing' }
ICFader >> defaultColoredBar [

	| size |
	size := self
		        ifHorizontal: [ 0 @ self defaultBarThickness ]
		        ifVertical: [ self defaultBarThickness @ 0.1 ].

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		  background: self coloredBarDefaultColor;
		constraintsDo: [ :c | c ignoreByLayout ];
		  size: size;
		  yourself
]

{ #category : 'api - bounds' }
ICFader >> defaultHandle [

	| size elt |
	size := self
		        ifHorizontal: [ 5 @ barThickness ]
		        ifVertical: [ barThickness @ 5 ].

	elt := BlElement new
		       background: self handleDefaultColor;
		       geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		constraintsDo: [ :c | c ignoreByLayout ];
		       size: size;
		       transformDo: [ :t | "so the position is now the center"
			       t translateBy: size negated / 2 ];
		       yourself.

	^ elt
]

{ #category : 'api - bounds' }
ICFader >> defaultMarginLength [

	^ 5
]

{ #category : 'api - bounds' }
ICFader >> defaultMarginThickness [

	^ 5
]

{ #category : 'api - bounds' }
ICFader >> defaultSize [
	"self bar size maybe"

	^ self
		  ifHorizontal: [
			  self defaultBarLength + (2 * self defaultMarginLength)
			  @ (self defaultBarThickness + (2 * self defaultMarginThickness)) ]
		  ifVertical: [
			  self defaultBarThickness + (2 * self defaultMarginThickness)
			  @ (self defaultBarLength + (2 * self defaultMarginLength)) ]
]

{ #category : 'accessing' }
ICFader >> direction [
	"Returns true if horizontal else false"
	^ self ifHorizontal: [ true ]
			 ifVertical: [ false ].
]

{ #category : 'accessing' }
ICFader >> handle [
	^ handle
]

{ #category : 'accessing' }
ICFader >> handle: aBlElement [ 
	handle := aBlElement
]

{ #category : 'api - bounds' }
ICFader >> handleDefaultColor [

	^ Color green
]

{ #category : 'accessing' }
ICFader >> horizontal: aBoolean [

	isHorizontal := aBoolean 
]

{ #category : 'building' }
ICFader >> ifHorizontal: horizontalBlock ifVertical: verticalBlock [

	^ self isHorizontal
		ifTrue: horizontalBlock
		ifFalse: verticalBlock
]

{ #category : 'api - slider' }
ICFader >> incrementValue: aValue [

	| tmp |
	tmp := value + aValue.
	self setValue: tmp
]

{ #category : 'initialization' }
ICFader >> initialize [

	super initialize.
	isHorizontal := true.
	segmented := false.
	self initializeSizes.
	self widgetSize: self defaultSize.
	self background: self defaultColor.
	self layout: BlFrameLayout new.
	self initializeValues.
	self initializeParts.
	self initializeValueLabels
	"self initializeEvents"
]

{ #category : 'initialization' }
ICFader >> initializeEvents [ 

	self addEventHandlerOn: BlMouseDownEvent do: [ :event |
		self moveHandleTo: (self globalPointToLocal: event position)].
	self addEventHandlerOn: BlDragStartEvent do: [ :event | event consumed: true].
	self addEventHandlerOn: BlDragEvent do: [ :event | self moveHandleTo: (self globalPointToLocal: event position)]
]

{ #category : 'initialization' }
ICFader >> initializeLabel [

	label := BlTextElement new.
	label text: (self name asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color white) }).
	label text fontSize: 15.
	label text bold.
	label constraintsDo: [ :c |
		c padding: (BlInsets all: 5).
		c frame horizontal alignLeft.
		c frame vertical alignTop ].
	
	self addChild: label
]

{ #category : 'initialization' }
ICFader >> initializeParts [

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
ICFader >> initializeSizes [ 

	barLength := self defaultBarLength.
	barThickness := self defaultBarThickness.
	marginLength := self defaultMarginLength.
	marginThickness := self defaultMarginThickness.
]

{ #category : 'initialization' }
ICFader >> initializeValueLabels [

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
ICFader >> initializeValues [

	self minValue: 0.
	self maxValue: 50.
	value := self minValue 
]

{ #category : 'accessing' }
ICFader >> isHorizontal [ 

	^ isHorizontal 
]

{ #category : 'testing' }
ICFader >> isSegmented [ 

	^ segmented 
]

{ #category : 'accessing' }
ICFader >> label [

	^ label
]

{ #category : 'accessing' }
ICFader >> marginLength [

	^ marginLength
]

{ #category : 'accessing' }
ICFader >> marginLength: aNumber [

	marginLength := aNumber.
	self rebuild
]

{ #category : 'accessing' }
ICFader >> marginThickness [ 

	^ marginThickness 
]

{ #category : 'accessing' }
ICFader >> marginThickness: aNumber [

	marginThickness := aNumber.
	self rebuild
]

{ #category : 'accessing' }
ICFader >> maxLabel [

	^ maxLabel
]

{ #category : 'accessing' }
ICFader >> maxValue [

	^ maxValue
]

{ #category : 'accessing' }
ICFader >> maxValue: aNumber [

	maxValue := aNumber
]

{ #category : 'accessing' }
ICFader >> minLabel [ 

	^ minLabel 
]

{ #category : 'accessing' }
ICFader >> minValue [ 

	^ minValue 
]

{ #category : 'accessing' }
ICFader >> minValue: aNumber [

	minValue := aNumber 
]

{ #category : 'api - transformations' }
ICFader >> moveHandleTo: aPosition [

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
ICFader >> name [ 

	^ name
]

{ #category : 'accessing' }
ICFader >> name: aString [

	name := aString.
	self initializeLabel.
]

{ #category : 'api - values' }
ICFader >> nearestValue: aValue [

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
ICFader >> positionDefaultBar: aBar [

	self
		ifHorizontal: [
			aBar position:
				self defaultMarginLength @ self defaultMarginThickness ]
		ifVertical: [
			aBar position:
				self defaultMarginThickness @ self defaultMarginLength ]
]

{ #category : 'api - transformations' }
ICFader >> positionDefaultHandle [

	self
		ifHorizontal: [
		handle position: self defaultMarginLength @ (widgetSize y / 2) ]
		ifVertical: [
			handle position:
				widgetSize x / 2 @ (self defaultMarginLength + barLength) ]
]

{ #category : 'building' }
ICFader >> rebuild [

	self
		ifHorizontal: [ self buildHorizontal ]
		ifVertical: [ self buildVertical ]
]

{ #category : 'removing' }
ICFader >> removeParts [

	self removeChildren. 
	bar := nil.
	handle := nil
]

{ #category : 'accessing' }
ICFader >> segmented: aBoolean [ 

	segmented := aBoolean
]

{ #category : 'accessing' }
ICFader >> segmentedValues [

	segmentedValues ifNil: [	segmentedValues := (self minValue to: self maxValue by:
	                    self stepValue) asOrderedCollection].
	^ segmentedValues
]

{ #category : 'accessing' }
ICFader >> segmentedValues: aCollection [ 

	segmentedValues := aCollection 
]

{ #category : 'initialization' }
ICFader >> setToMax [

	"this method is created with a button that would set to max in the widget"
	self setValue: self maxValue.
]

{ #category : 'initialization' }
ICFader >> setToMin [ 

	"this method is created with a button that would set to max in the widget"
	self setValue: self minValue.
]

{ #category : 'accessing' }
ICFader >> setValue: aNumber [

	| newValue |
	newValue := aNumber.
	aNumber < self minValue ifTrue: [ newValue := minValue ].
	aNumber > self maxValue ifTrue: [ newValue := maxValue ].

	self moveHandleTo: (self valueToCoord: newValue)
]

{ #category : 'api - bounds' }
ICFader >> size: aValue [
	"just to keep the widgset size"

	super size: aValue.
	
	" for now do not support resize
	
	self isBuildSlider ifTrue: [ self rebuildSlider ]
	"
]

{ #category : 'accessing' }
ICFader >> stepValue [

	^ stepValue 
]

{ #category : 'accessing' }
ICFader >> stepValue: aNumber [

	stepValue := aNumber 
	
]

{ #category : 'api - transformations' }
ICFader >> updateColoredBarTo: aPosition [

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
ICFader >> value [ 

	^ value 
]

{ #category : 'api - transformations' }
ICFader >> valueAtCoord: aPoint [

	^ self
		  ifHorizontal: [ self valueAtX: aPoint ]
		  ifVertical: [ self valueAtY: aPoint ]
]

{ #category : 'api - transformations' }
ICFader >> valueAtX: aPoint [

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
ICFader >> valueAtY: aPoint [

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
ICFader >> valueLabel [

	^ valueLabel
]

{ #category : 'api - transformations' }
ICFader >> valueToCoord: aNumber [

	^ self
		  ifHorizontal: [ self valueToX: aNumber ]
		  ifVertical: [ self valueToY: aNumber ]
]

{ #category : 'api - transformations' }
ICFader >> valueToX: aNumber [

	| dist valueDiff coeff |
	valueDiff := aNumber - minValue.
	coeff := (valueDiff / (maxValue - minValue)) asFloat.
	dist := marginLength + (coeff * barLength).
	self forceLocalLayout.
	"This is needed so handle position != 0"
	^ dist @ handle position y
]

{ #category : 'api - transformations' }
ICFader >> valueToY: aNumber [

	| dist valueDiff coeff |
	valueDiff := aNumber - minValue.
	coeff := (valueDiff / (maxValue - minValue)) asFloat.
	dist := marginLength + barLength - (coeff * barLength).
	self forceLocalLayout.
	"This is needed so handle position != 0"
	^ handle position x @ dist
]

{ #category : 'accessing' }
ICFader >> widgetSize [ 

	^ widgetSize 
]

{ #category : 'accessing' }
ICFader >> widgetSize: aNumber [

	widgetSize := aNumber.
	self size: aNumber 
]
