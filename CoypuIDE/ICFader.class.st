"
I am a linear fader: a bar with a draggable handle that sets a value between
#minValue and #maxValue. I work horizontally or vertically, smoothly or in steps.

## Creating one
```language=Pharo
	ICFader new.
	ICFader beVertical.
	ICFader label: 'Gain'.
	ICFader new barLength: 200 thickness: 30.
``` 

## Size

My geometry comes from four numbers: #barLength and #barThickness for the bar, #marginLength and #marginThickness for the space around it. Everything else, my own extent, the handle, the coloured bar, the font size - is derived from them by #applySize, which every size setter calls. Setting a size never rebuilds me, so labels and event handlers survive:
```language=Pharo
	fader barLength: 200.
	fader barLength: 200 thickness: 30.   """"one size pass instead of two""""
	fader resetSize.
```
Orientation is a size concern too: #beHorizontal and #beVertical just re-derive
the geometry, they do not destroy anything.

## Value
```language=Pharo
	fader minValue: 0; maxValue: 127; stepValue: 1.
	fader setValue: 64.
	fader setToMin.
	fader setToMax.
	fader callBack: [ :v | synth gain: v ].
```
#beSegmented restricts the value to multiples of #stepValue (or to
#segmentedValues), #beSmooth lifts the restriction. The callback is the user's:
I never install one, and the value label is updated independently of it.

## Internal representation and key implementation points

The handle is positioned in my local coordinates and travels along one axis
between #barOrigin and #barOrigin + #barLength, holding #crossCenter on the other
axis. #valueToCoord: and #valueAtCoord: are the inverse pair mapping value to
handle position, and both are computed from my size parameters rather than from
laid-out bounds - reading #bar position or #handle position would return 0@0
before a layout pass and give silently wrong results.

bar, coloredBar and handle are all #ignoreByLayout: I place them myself. The
labels are ordinary frame-layout children.

"
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

{ #category : 'defaults' }
ICFader class >> defaultFontSize [
	^ 15
]

{ #category : 'defaults' }
ICFader class >> defaultHandleThickness [
	^ 5

]

{ #category : 'examples' }
ICFader class >> differentSizesExample [ 

	<script>
	| verticals horizontals column space |
	horizontals := #( #( 100 12 ) #( 180 20 ) #( 260 28 ) ) collect: [ :pair |
		               (self label:
			                'H ' , pair first printString , 'x'
			                , pair second printString)
			               barLength: pair first
			               thickness: pair second;
			               yourself ].

	verticals := #( #( 100 12 ) #( 180 20 ) #( 260 28 ) ) collect: [ :pair |
		             ((self label:
			               'V ' , pair first printString , 'x'
			               , pair second printString) beVertical;
			              yourself)
			             barLength: pair first
			             thickness: pair second;
			             yourself ].

	column := BlElement new
		          layout: BlLinearLayout vertical alignCenter;
		          constraintsDo: [ :c |
			          c horizontal matchParent.
			          c vertical matchParent ];
		          background: Color veryVeryDarkGray;
		          addChild: (self rowOf: horizontals);
		          addChild: (self rowOf: verticals);
		          yourself.

	space := BlSpace new.
	space extent: 700 @ 620.
	space title: 'ICFader - three sizes, both orientations'.
	space root
		background: Color veryVeryDarkGray;
		addChild: column.
	space show

]

{ #category : 'accessing' }
ICFader class >> label: aString [
	^ self new
		  name: aString;
		  yourself
]

{ #category : 'instance creation' }
ICFader class >> new [
	^ self readOnly
		  initializeEvents;
		  yourself
]

{ #category : 'instance creation' }
ICFader class >> readOnly [

	^ self basicNew initialize
]

{ #category : 'accessing' }
ICFader class >> readOnlyLabel: aString [
	^ self readOnly
		  name: aString;
		  yourself
]

{ #category : 'examples' }
ICFader class >> rowOf: aCollection [

	^ BlElement new
		  layout: BlLinearLayout horizontal alignCenter;
		  constraintsDo: [ :c |
				  c horizontal matchParent.
				  c vertical fitContent ];
		  padding: (BlInsets all: 20);
		  addChildren: aCollection;
		  yourself
]

{ #category : 'examples' }
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

{ #category : 'examples' }
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

{ #category : 'size' }
ICFader >> applyLabelPlacement [ 

	self
		ifHorizontal: [ self placeLabelsHorizontally ]
		ifVertical: [ self placeLabelsVertically ].
	self placeValueLabel
]

{ #category : 'size' }
ICFader >> applyLabelSizes [
	{ minLabel. maxLabel. valueLabel. label } do: [ :each |
		each ifNotNil: [ each text fontSize: self fontSize ] ]
]

{ #category : 'size' }
ICFader >> applySize [

	self widgetSize: self widgetExtent.

	bar
		extent: self barSize;
		position: self barOrigin.
	coloredBar position: self barOrigin.

	handle extent: self handleSize.

	self applyLabelSizes.
	self applyLabelPlacement.
	self refreshValue
]

{ #category : 'size' }
ICFader >> bandHeight [ 
	"Height reserved for one row of label text."

	^ self fontSize * 3 / 2
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
	bar ifNotNil: [ self applySize ]
]

{ #category : 'accessing' }
ICFader >> barLength: aLength thickness: aThickness [
	"One size pass for both, instead of two."

	barLength := aLength.
	barThickness := aThickness.
	bar ifNotNil: [ self applySize ]
]

{ #category : 'size' }
ICFader >> barOrigin [

"Top-left of the bar, in my local coordinates."

	^ self
		  ifHorizontal: [
			  marginLength + self lengthPadding
			  @ (self bandHeight + marginThickness
				   + ((barThickness - self barSize y) / 2)) ]
		  ifVertical: [
			  (self widgetExtent x - self barSize x) / 2
			  @ ((2 * self bandHeight) + marginLength + self lengthPadding) ]
]

{ #category : 'size' }
ICFader >> barSize [
	^ self
		  ifHorizontal: [ barLength @ barThickness ]
		  ifVertical: [ barThickness @ barLength ]

]

{ #category : 'accessing' }
ICFader >> barThickness [ 

	^ barThickness 
]

{ #category : 'accessing' }
ICFader >> barThickness: aNumber [
	barThickness := aNumber.
	bar ifNotNil: [ self applySize ]

]

{ #category : 'api - values' }
ICFader >> basicSetValue: aNumber [ 

	value := aNumber.
	self updateValueLabel.
	self callBack ifNotNil: [ :e | e value: value ]
]

{ #category : 'building' }
ICFader >> beHorizontal [
	self horizontal: true.
	bar ifNotNil: [ self applySize ]

]

{ #category : 'building' }
ICFader >> beSegmented [
	self stepValue ifNil: [
		^ self error: 'Cannot segment a slider with a nil stepValue' ].
	self segmented: true.
	self refreshValue
]

{ #category : 'building' }
ICFader >> beSmooth [
	self segmented: false.
	self segmentedValues: nil.
	self refreshValue
]

{ #category : 'building' }
ICFader >> beVertical [
	self horizontal: false.
	bar ifNotNil: [ self applySize ]

]

{ #category : 'accessing' }
ICFader >> callBack [ 

	^ callBack 
]

{ #category : 'accessing' }
ICFader >> callBack: aBlock [

	callBack := aBlock 
]

{ #category : 'api - transformations' }
ICFader >> clampToBar: aPoint [
	^ self
		  ifHorizontal: [
			  ((aPoint x max: self barOrigin x) min: self barOrigin x + barLength)
			  @ self crossCenter ]
		  ifVertical: [
			  self crossCenter
			  @ ((aPoint y max: self barOrigin y) min: self barOrigin y + barLength) ]

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

{ #category : 'size' }
ICFader >> crossCenter [
"The coordinate the handle keeps on the axis it does not travel along."
^ self
		  ifHorizontal: [ self barOrigin y + (self barSize y / 2) ]
		  ifVertical: [ self barOrigin x + (self barSize x / 2) ]
]

{ #category : 'api - slider' }
ICFader >> decrementValue: aValue [

	| tmp |
	tmp := value - aValue.
	self setValue: tmp
]

{ #category : 'api - bounds' }
ICFader >> defaultBar [
	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		  background: self barDefaultColor;
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

{ #category : 'api - bounds' }
ICFader >> defaultColoredBar [
	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		  background: self coloredBarDefaultColor;
		  constraintsDo: [ :c | c ignoreByLayout ];
		  yourself
]

{ #category : 'api - bounds' }
ICFader >> defaultHandle [
	^ BlElement new
		  background: self handleDefaultColor;
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		  constraintsDo: [ :c | c ignoreByLayout ];
		  yourself
]

{ #category : 'accessing' }
ICFader >> defaultIsHorizontal [ 
^ true
]

{ #category : 'api - bounds' }
ICFader >> defaultMarginLength [

	^ 5
]

{ #category : 'api - bounds' }
ICFader >> defaultMarginThickness [

	^ 5
]

{ #category : 'size' }
ICFader >> defaultSize [
	"Kept for the examples; now reports my real size, not a constant."

	^ self widgetExtent
]

{ #category : 'accessing' }
ICFader >> direction [
	"Returns true if horizontal else false"
	^ self ifHorizontal: [ true ]
			 ifVertical: [ false ].
]

{ #category : 'size' }
ICFader >> fontSize [
	^ (barThickness * 3 / 4) max: 8
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

{ #category : 'size' }
ICFader >> handleSize [
	^ self
		  ifHorizontal: [ self handleThickness @ barThickness ]
		  ifVertical: [ barThickness @ self handleThickness ]
]

{ #category : 'size' }
ICFader >> handleThickness [
	^ self class  defaultHandleThickness

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
	isHorizontal := self defaultIsHorizontal.
	segmented := false.
	self initializeSizes.
	self background: self defaultColor.
	self layout: BlFrameLayout new.
	self initializeValues.
	self initializeParts.
	self initializeValueLabels.
	self applySize
]

{ #category : 'initialization' }
ICFader >> initializeEvents [
	self addEventHandlerOn: BlMouseDownEvent do: [ :event |
		self moveHandleTo: (self globalPointToLocal: event position) ].
	self addEventHandlerOn: BlDragStartEvent do: [ :event |
		event consumed: true ].
	self addEventHandlerOn: BlDragEvent do: [ :event |
		self moveHandleTo: (self globalPointToLocal: event position) ].
	^ self
]

{ #category : 'initialization' }
ICFader >> initializeLabel [
	label ifNotNil: [ self removeChild: label ].
	label := BlTextElement new
		         text: (self labelText: self name color: Color white);
		         yourself.
	self addChild: label
]

{ #category : 'initialization' }
ICFader >> initializeParts [
	self bar: self defaultBar.
	self addChild: self bar.

	self coloredBar: self defaultColoredBar.
	self addChild: self coloredBar.

	self handle: self defaultHandle.
	self addChild: self handle
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
		            text: (self labelText: self minValue color: Color white);
		            yourself.
	maxLabel := BlTextElement new
		            text: (self labelText: self maxValue color: Color white);
		            yourself.
	valueLabel := BlTextElement new
		              text: (self labelText: self value color: Color black);
		              yourself.

	self addChild: minLabel.
	self addChild: valueLabel.
	self addChild: maxLabel
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

{ #category : 'size' }
ICFader >> labelColumnWidth [
	"Minimum width a vertical fader needs for its labels to be readable."

	^ self fontSize * 6
]

{ #category : 'api - text' }
ICFader >> labelText: anObject color: aColor [
	^ anObject asRopedText attributes: {
		  (BlTextForegroundAttribute paint: aColor).
		  (BlFontSizeAttribute size: self fontSize).
		  BlFontWeightAttribute bold }
]

{ #category : 'size' }
ICFader >> laceLabelsHorizontally [ 

	label ifNotNil: [
		label constraintsDo: [ :c |
			c padding: (BlInsets
					 top: 0
					 left: marginLength
					 bottom: 0
					 right: 0).
			c frame horizontal alignLeft.
			c frame vertical alignTop ] ].

	minLabel constraintsDo: [ :c |
		c padding: (BlInsets
				 top: 0
				 left: marginLength
				 bottom: 0
				 right: 0).
		c frame horizontal alignLeft.
		c frame vertical alignBottom ].

	maxLabel constraintsDo: [ :c |
		c padding: (BlInsets
				 top: 0
				 left: 0
				 bottom: 0
				 right: marginLength).
		c frame horizontal alignRight.
		c frame vertical alignBottom ]

]

{ #category : 'size' }
ICFader >> laceLabelsVertically [
label ifNotNil: [
		label constraintsDo: [ :c |
			c padding: (BlInsets all: 0).
			c frame horizontal alignCenter.
			c frame vertical alignTop ] ].

	maxLabel constraintsDo: [ :c |
		c padding: (BlInsets
				 top: self bandHeight
				 left: 0
				 bottom: 0
				 right: 0).
		c frame horizontal alignCenter.
		c frame vertical alignTop ].

	minLabel constraintsDo: [ :c |
		c padding: (BlInsets all: 0).
		c frame horizontal alignCenter.
		c frame vertical alignBottom ]
]

{ #category : 'accessing' }
ICFader >> lengthPadding [ 
^ 0
]

{ #category : 'accessing' }
ICFader >> marginLength [

	^ marginLength
]

{ #category : 'accessing' }
ICFader >> marginLength: aNumber [
	marginLength := aNumber.
	bar ifNotNil: [ self applySize ]
]

{ #category : 'accessing' }
ICFader >> marginThickness [ 

	^ marginThickness 
]

{ #category : 'accessing' }
ICFader >> marginThickness: aNumber [
	marginThickness := aNumber.
	bar ifNotNil: [ self applySize ]
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
	minValue := aNumber.
	minLabel ifNotNil: [
		minLabel text: (self labelText: aNumber color: Color white) ]

]

{ #category : 'api - transformations' }
ICFader >> moveHandleTo: aPosition [ 

	| coord |
	coord := self isSegmented
		         ifTrue: [ self valueToCoord: (self valueAtCoord: aPosition) ]
		         ifFalse: [ aPosition ].
	coord := self clampToBar: coord.
	handle position: coord - (self handleSize / 2).
	self updateColoredBarTo: coord.
	self basicSetValue: (self valueAtCoord: coord)
]

{ #category : 'accessing' }
ICFader >> name [ 

	^ name
]

{ #category : 'accessing' }
ICFader >> name: aString [
	name := aString.
	label
		ifNil: [ self initializeLabel ]
		ifNotNil: [ label text: (self labelText: aString color: Color white) ]
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

{ #category : 'size' }
ICFader >> placeLabelsHorizontally [ 

	label ifNotNil: [
		label constraintsDo: [ :c |
			c padding: (BlInsets
					 top: 0
					 left: marginLength
					 bottom: 0
					 right: 0).
			c frame horizontal alignLeft.
			c frame vertical alignTop ] ].
]

{ #category : 'size' }
ICFader >> placeLabelsVertically [ 

	label ifNotNil: [
		label constraintsDo: [ :c |
			c padding: (BlInsets all: 0).
			c frame horizontal alignCenter.
			c frame vertical alignTop ] ].

	maxLabel constraintsDo: [ :c |
		c padding: (BlInsets
				 top: self bandHeight
				 left: 0
				 bottom: 0
				 right: 0).
		c frame horizontal alignCenter.
		c frame vertical alignTop ].

	minLabel constraintsDo: [ :c |
		c padding: (BlInsets all: 0).
		c frame horizontal alignCenter.
		c frame vertical alignBottom ].

	valueLabel constraintsDo: [ :c |
		c padding: (BlInsets all: 0).
		c frame horizontal alignCenter.
		c frame vertical alignCenter ]
]

{ #category : 'size' }
ICFader >> placeValueLabel [ 
	"Reparent the value label onto the handle, or back onto me, then centre it."

	valueLabel ifNil: [ ^ self ].

	self valueLabelFollowsHandle
		ifTrue: [
			(handle layout isKindOf: BlFrameLayout) ifFalse: [
				handle layout: BlFrameLayout new ].
			handle clipChildren: false.
			(handle hasChild: valueLabel) ifFalse: [
				valueLabel removeFromParent.
				handle addChild: valueLabel ] ]
		ifFalse: [
			(self hasChild: valueLabel) ifFalse: [
				valueLabel removeFromParent.
				self addChild: valueLabel ] ].

	valueLabel constraintsDo: [ :c |
		c accountByLayout.
		c padding: (BlInsets all: 0).
		c horizontal fitContent.
		c vertical fitContent.
		c frame horizontal alignCenter.
		c frame vertical alignCenter ]

]

{ #category : 'size' }
ICFader >> refreshValue [
	"Reposition handle and coloured bar for the current value."

	self setValue: (value ifNil: [ self minValue ])

]

{ #category : 'size' }
ICFader >> resetSize [
	self
		barLength: self defaultBarLength
		thickness: self defaultBarThickness
]

{ #category : 'size' }
ICFader >> rowOf: aCollection [ 
	"Helper for #differentSizesExample."

	^ BlElement new
		  layout: BlLinearLayout horizontal alignCenter;
		  constraintsDo: [ :c |
			  c horizontal matchParent.
			  c vertical fitContent ];
		  padding: (BlInsets all: 20);
		  addChildren: aCollection;
		  yourself
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
				coloredBar
					position: self barOrigin;
					extent: aPosition x - self barOrigin x @ self barSize y ]
		ifVertical: [
				coloredBar
					position: self barOrigin x @ aPosition y;
					extent:
						self barSize x @ (self barOrigin y + barLength - aPosition y) ]
]

{ #category : 'api - values' }
ICFader >> updateValueLabel [
	valueLabel ifNotNil: [
		valueLabel text: (self labelText: value rounded color: Color black) ]
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
	| dist |
	dist := (aPoint - self barOrigin) x.
	^ (self nearestValue:
		   minValue + ((maxValue - minValue) * dist / barLength)) asFloat
]

{ #category : 'api - transformations' }
ICFader >> valueAtY: aPoint [
	| dist |
	dist := self barOrigin y + barLength - aPoint y.
	^ (self nearestValue:
		   minValue + ((maxValue - minValue) * dist / barLength)) asFloat
]

{ #category : 'accessing' }
ICFader >> valueLabel [

	^ valueLabel
]

{ #category : 'size' }
ICFader >> valueLabelFollowsHandle [ 
	"Answer whether my value label rides on the handle instead of sitting still."

	^ false
]

{ #category : 'api - transformations' }
ICFader >> valueToCoord: aNumber [

	^ self
		  ifHorizontal: [ self valueToX: aNumber ]
		  ifVertical: [ self valueToY: aNumber ]
]

{ #category : 'api - transformations' }
ICFader >> valueToX: aNumber [
	| coeff |
	coeff := (aNumber - minValue / (maxValue - minValue)) asFloat.
	^ marginLength + (coeff * barLength) @ self crossCenter

]

{ #category : 'api - transformations' }
ICFader >> valueToY: aNumber [
	| coeff |
	coeff := (aNumber - minValue / (maxValue - minValue)) asFloat.
	^ self crossCenter
	  @ (marginLength + barLength - (coeff * barLength))
]

{ #category : 'size' }
ICFader >> widgetExtent [
	^ self
		  ifHorizontal: [
			  barLength + (2 * marginLength) + (2 * self lengthPadding)
			  @ (barThickness + (2 * marginThickness) + (2 * self bandHeight)) ]
		  ifVertical: [
			  (barThickness + (2 * marginThickness) max: self labelColumnWidth)
			  @ (barLength + (2 * marginLength) + (2 * self lengthPadding)
				   + (3 * self bandHeight)) ]
]

{ #category : 'accessing' }
ICFader >> widgetSize [ 

	^ widgetSize 
]

{ #category : 'accessing' }
ICFader >> widgetSize: aNumber [

	widgetSize := aNumber.
	self extent: aNumber
]
