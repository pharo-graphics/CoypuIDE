Class {
	#name : 'ICSlider',
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
		'value'
	],
	#category : 'CoypuIDE-slider',
	#package : 'CoypuIDE',
	#tag : 'slider'
}

{ #category : 'accessing' }
ICSlider class >> beHorizontal [

	^ self new beHorizontal 
]

{ #category : 'accessing' }
ICSlider class >> beVertical [ 
	
	^ self new beVertical 
]

{ #category : 'instance creation' }
ICSlider class >> new [

	^ self readOnly initializeEvents
]

{ #category : 'instance creation' }
ICSlider class >> readOnly [

	^ self basicNew initialize
]

{ #category : 'example' }
ICSlider class >> simpleExampleHorizontal [
	"The values of the slider are also written in the transcript"

	<script>
	| slider textElt container |
	slider := self beHorizontal.
	textElt := BlTextElement new position: slider defaultSize.

	textElt text: slider currentValue asRopedText.

	slider callBack: [ :value | textElt text: value asRopedText ].

	container := BlElement new clipChildren: false.

	container addChild: slider.
	container addChild: textElt.

	container openInSpace
]

{ #category : 'example' }
ICSlider class >> simpleExampleVertical [
	"The values of the slider are also written in the transcript"

	<script>
	| slider textElt container |
	slider := self beVertical.
	textElt := BlTextElement new position: slider defaultSize.

	textElt text: slider currentValue asRopedText.

	slider callBack: [ :value | textElt text: value asRopedText ].

	container := BlElement new clipChildren: false.

	container addChild: slider.
	container addChild: textElt.

	container openInSpace
]

{ #category : 'accessing' }
ICSlider >> bar [
	^ bar
]

{ #category : 'accessing' }
ICSlider >> bar: aBlElement [ 
	bar := aBlElement
]

{ #category : 'api - bounds' }
ICSlider >> barDefaultColor [ 

	^ Color lightGray

]

{ #category : 'accessing' }
ICSlider >> barLength [

	^ barLength
]

{ #category : 'accessing' }
ICSlider >> barLength: aNumber [

	barLength := aNumber.
	self rebuild
]

{ #category : 'accessing' }
ICSlider >> barThickness [ 

	^ barThickness 
]

{ #category : 'accessing' }
ICSlider >> barThickness: aNumber [

	barThickness := aNumber.
	self rebuild
]

{ #category : 'api - values' }
ICSlider >> basicSetValue: aNumber [

	value := aNumber.
	self callBack ifNotNil: [ :e | e value: value ]
]

{ #category : 'accessing' }
ICSlider >> beHorizontal [

	self horizontal: true.
	self rebuild
]

{ #category : 'building' }
ICSlider >> beSegmented [

	self stepValue
		ifNil: [ self error: 'Cannot segment a slider with a nil stepValue' ]
		ifNotNil: [ self segmented: true].
	self rebuild
]

{ #category : 'building' }
ICSlider >> beSmooth [

	self segmented: false.
	self segmentedValues: nil.
	self rebuild
]

{ #category : 'accessing' }
ICSlider >> beVertical [

	self horizontal: false.
	self buildVertical
]

{ #category : 'building' }
ICSlider >> buildHorizontal [

	widgetSize y > widgetSize x ifTrue: [
		self widgetSize: widgetSize y @ widgetSize x ].
	self removeParts.
	self initializeParts
]

{ #category : 'building' }
ICSlider >> buildVertical [

	widgetSize y > widgetSize x ifFalse: [
		self widgetSize: widgetSize y @ widgetSize x ].

	self removeParts.
	self initializeParts
]

{ #category : 'accessing' }
ICSlider >> callBack [ 

	^ callBack 
]

{ #category : 'accessing' }
ICSlider >> callBack: aBlock [

	callBack := aBlock 
]

{ #category : 'accessing' }
ICSlider >> coloredBar [ 

	^ coloredBar 
]

{ #category : 'accessing' }
ICSlider >> coloredBar: aBlElement [

	coloredBar := aBlElement 
]

{ #category : 'accessing' }
ICSlider >> coloredBarDefaultColor [
	^ Color green alpha: 0.6
]

{ #category : 'api - slider' }
ICSlider >> decrementValue: aValue [

	| tmp |
	tmp := value - aValue.
	self setValue: tmp
]

{ #category : 'api - bounds' }
ICSlider >> defaultBar [

	| size |
	size := self 
		        ifHorizontal: [ self defaultBarLength @ self defaultBarThickness ]
		        ifVertical: [ self defaultBarThickness @ self defaultBarLength ].

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		  background: self barDefaultColor;
		  size: size;
		  yourself
]

{ #category : 'api - bounds' }
ICSlider >> defaultBarLength [

	^ 240
]

{ #category : 'api - bounds' }
ICSlider >> defaultBarThickness [

	^ 80
]

{ #category : 'api - bounds' }
ICSlider >> defaultColor [

	^ Color veryDarkGray

]

{ #category : 'accessing' }
ICSlider >> defaultColoredBar [
	
	| size |
	size := self
		        ifHorizontal: [ 0 @ self defaultBarThickness ]
		        ifVertical: [ self defaultBarThickness @ 0.1 ].

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		  background: self coloredBarDefaultColor;
			size: size;
		  yourself
]

{ #category : 'api - bounds' }
ICSlider >> defaultHandle [

	| size elt |
	size := self
		        ifHorizontal: [ 5 @ barThickness ]
		        ifVertical: [ barThickness @ 5 ].

	elt := BlElement new
		       background: self handleDefaultColor;
		       geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		       size: size;
		       transformDo: [ :t | "so the position is now the center"
			       t translateBy: size negated / 2 ];
		       yourself.

	^ elt
]

{ #category : 'api - bounds' }
ICSlider >> defaultMarginLength [

	^ 50
]

{ #category : 'api - bounds' }
ICSlider >> defaultMarginThickness [

	^ 20
]

{ #category : 'api - bounds' }
ICSlider >> defaultSize [
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
ICSlider >> direction [
	"Returns true if horizontal else false"
	^ self ifHorizontal: [ true ]
			 ifVertical: [ false ].
]

{ #category : 'accessing' }
ICSlider >> handle [
	^ handle
]

{ #category : 'accessing' }
ICSlider >> handle: aBlElement [ 
	handle := aBlElement
]

{ #category : 'api - bounds' }
ICSlider >> handleDefaultColor [

	^ Color green
]

{ #category : 'accessing' }
ICSlider >> horizontal: aBoolean [

	isHorizontal := aBoolean 
]

{ #category : 'building' }
ICSlider >> ifHorizontal: horizontalBlock ifVertical: verticalBlock [

	^ self isHorizontal
		ifTrue: horizontalBlock
		ifFalse: verticalBlock
]

{ #category : 'api - slider' }
ICSlider >> incrementValue: aValue [

	| tmp |
	tmp := value + aValue.
	self setValue: tmp
]

{ #category : 'initialization' }
ICSlider >> initialize [

	super initialize.
	isHorizontal := true.
	segmented := false.
	self initializeSizes.
	self widgetSize: self defaultSize.
	self background: self defaultColor.
	self initializeValues.
	self initializeParts.
	"self initializeEvents"
]

{ #category : 'initialization' }
ICSlider >> initializeButtons [
	"Here I manually place the buttons but we could use layouts instead of magic numbers"

	"These might be useless after all because clicking outside the slider already sets to min or max"
	| buttonSize minButton maxButton |
	buttonSize := 30.
	minButton := BlElement new
		             geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
		             background: Color gray;
		             size: buttonSize asPoint.

	maxButton := BlElement new
		             geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
		             background: Color gray;
		             size: buttonSize asPoint.

	minButton addEventHandlerOn: BlClickEvent do: [ self setToMin ].
	maxButton addEventHandlerOn: BlClickEvent do: [ self setToMax ].

	self
		ifHorizontal: [
			minButton position: marginLength / 2 - (buttonSize / 2)
				@ (self defaultSize y / 2 - (buttonSize / 2)).
			maxButton position:
				self defaultSize x - (buttonSize + marginLength / 2)
				@ (self defaultSize y / 2 - (buttonSize / 2)) ]
		ifVertical: [
			minButton position: self defaultSize x / 2 - (buttonSize / 2)
				@ (self defaultSize y - (buttonSize + marginLength / 2)).
			maxButton position: self defaultSize x / 2 - (buttonSize / 2)
				@ (marginLength / 2 - (buttonSize / 2)) ].


	self addChild: minButton.
	self addChild: maxButton
]

{ #category : 'initialization' }
ICSlider >> initializeEvents [ 

	self addEventHandlerOn: BlMouseDownEvent do: [ :event | self moveHandleTo: event position].
	self addEventHandlerOn: BlDragStartEvent do: [ :event | event consumed: true].
	self addEventHandlerOn: BlDragEvent do: [ :event | self moveHandleTo: event position]
]

{ #category : 'initialization' }
ICSlider >> initializeParts [

	self bar: self defaultBar.
	self positionDefaultBar: self bar.
	self addChild: self bar.
	

	self coloredBar: self defaultColoredBar.
	self positionDefaultBar: self coloredBar.
	self addChild: self coloredBar.
	
	
	self handle: self defaultHandle.
	self positionDefaultHandle.
	self addChild: self handle.

	"initialize segments if segmented"
	
	"self initializeButtons."
]

{ #category : 'initialization' }
ICSlider >> initializeSizes [ 

	barLength := self defaultBarLength.
	barThickness := self defaultBarThickness.
	marginLength := self defaultMarginLength.
	marginThickness := self defaultMarginThickness.
]

{ #category : 'initialization' }
ICSlider >> initializeValues [

	self minValue: 0.
	self maxValue: 50.
	value := self minValue 
]

{ #category : 'accessing' }
ICSlider >> isHorizontal [ 

	^ isHorizontal 
]

{ #category : 'testing' }
ICSlider >> isSegmented [ 

	^ segmented 
]

{ #category : 'accessing' }
ICSlider >> marginLength [

	^ marginLength
]

{ #category : 'accessing' }
ICSlider >> marginLength: aNumber [

	marginLength := aNumber.
	self rebuild
]

{ #category : 'accessing' }
ICSlider >> marginThickness [ 

	^ marginThickness 
]

{ #category : 'accessing' }
ICSlider >> marginThickness: aNumber [

	marginThickness := aNumber.
	self rebuild
]

{ #category : 'accessing' }
ICSlider >> maxValue [

	^ maxValue
]

{ #category : 'accessing' }
ICSlider >> maxValue: aNumber [

	maxValue := aNumber
]

{ #category : 'accessing' }
ICSlider >> minValue [ 

	^ minValue 
]

{ #category : 'accessing' }
ICSlider >> minValue: aNumber [

	minValue := aNumber 
]

{ #category : 'api - transformations' }
ICSlider >> moveHandleTo: aPosition [

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

{ #category : 'api - values' }
ICSlider >> nearestValue: aValue [

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
ICSlider >> positionDefaultBar: aBar [

	self
		ifHorizontal: [
			aBar position:
				self defaultMarginLength @ self defaultMarginThickness ]
		ifVertical: [
			aBar position:
				self defaultMarginThickness @ self defaultMarginLength ]
]

{ #category : 'api - transformations' }
ICSlider >> positionDefaultHandle [

	self
		ifHorizontal: [
		handle position: self defaultMarginLength @ (widgetSize y / 2) ]
		ifVertical: [
			handle position:
				widgetSize x / 2 @ (self defaultMarginLength + barLength) ]
]

{ #category : 'building' }
ICSlider >> rebuild [

	self
		ifHorizontal: [ self buildHorizontal ]
		ifVertical: [ self buildVertical ]
]

{ #category : 'removing' }
ICSlider >> removeParts [

	self removeChildren. 
	bar := nil.
	handle := nil
]

{ #category : 'accessing' }
ICSlider >> segmented: aBoolean [ 

	segmented := aBoolean
]

{ #category : 'accessing' }
ICSlider >> segmentedValues [

	segmentedValues ifNil: [	segmentedValues := (self minValue to: self maxValue by:
	                    self stepValue) asOrderedCollection].
	^ segmentedValues
]

{ #category : 'accessing' }
ICSlider >> segmentedValues: aCollection [ 

	segmentedValues := aCollection 
]

{ #category : 'initialization' }
ICSlider >> setToMax [

	"this method is created with a button that would set to max in the widget"
	self setValue: self maxValue.
]

{ #category : 'initialization' }
ICSlider >> setToMin [ 

	"this method is created with a button that would set to max in the widget"
	self setValue: self minValue.
]

{ #category : 'accessing' }
ICSlider >> setValue: aNumber [

	| newValue |
	newValue := aNumber.
	aNumber < self minValue ifTrue: [ newValue := minValue ].
	aNumber > self maxValue ifTrue: [ newValue := maxValue ].

	self moveHandleTo: (self valueToCoord: newValue)
]

{ #category : 'api - bounds' }
ICSlider >> size: aValue [
	"just to keep the widgset size"

	super size: aValue.
	
	" for now do not support resize
	
	self isBuildSlider ifTrue: [ self rebuildSlider ]
	"
]

{ #category : 'accessing' }
ICSlider >> stepValue [

	^ stepValue 
]

{ #category : 'accessing' }
ICSlider >> stepValue: aNumber [

	stepValue := aNumber 
	
]

{ #category : 'api - transformations' }
ICSlider >> updateColoredBarTo: aPosition [

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
ICSlider >> value [ 

	^ value 
]

{ #category : 'api - transformations' }
ICSlider >> valueAtCoord: aPoint [

	^ self
		  ifHorizontal: [ self valueAtX: aPoint ]
		  ifVertical: [ self valueAtY: aPoint ]
]

{ #category : 'api - transformations' }
ICSlider >> valueAtX: aPoint [

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
ICSlider >> valueAtY: aPoint [

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

{ #category : 'api - transformations' }
ICSlider >> valueToCoord: aNumber [

	^ self
		  ifHorizontal: [ self valueToX: aNumber ]
		  ifVertical: [ self valueToY: aNumber ]
]

{ #category : 'api - transformations' }
ICSlider >> valueToX: aNumber [

	| dist valueDiff coeff |
	valueDiff := aNumber - minValue.
	coeff := (valueDiff / (maxValue - minValue)) asFloat.
	dist := marginLength + (coeff * barLength).
	self forceLocalLayout.
	"This is needed so handle position != 0"
	^ dist @ handle position y
]

{ #category : 'api - transformations' }
ICSlider >> valueToY: aNumber [

	| dist valueDiff coeff |
	valueDiff := aNumber - minValue.
	coeff := (valueDiff / (maxValue - minValue)) asFloat.
	dist := marginLength + barLength - (coeff * barLength).
	self forceLocalLayout.
	"This is needed so handle position != 0"
	^ handle position x @ dist
]

{ #category : 'accessing' }
ICSlider >> widgetSize [ 

	^ widgetSize 
]

{ #category : 'accessing' }
ICSlider >> widgetSize: aNumber [

	widgetSize := aNumber.
	self size: aNumber 
]
