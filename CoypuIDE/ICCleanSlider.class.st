Class {
	#name : 'ICCleanSlider',
	#superclass : 'BlElement',
	#instVars : [
		'minValue',
		'maxValue',
		'stepValue',
		'sliderPixelMargin',
		'currentValue',
		'validatedValue',
		'validatedValueCallback',
		'sliderBar',
		'sliderBackground',
		'disabledRebuilding',
		'widgetSize',
		'maxPixelDistance',
		'enumeratedValues',
		'enumeratedColors',
		'initColor',
		'endColor',
		'barThickness',
		'isHorizontal',
		'eventHandler',
		'sliderHandle',
		'handlePushedPoint'
	],
	#category : 'CoypuIDE-Attic',
	#package : 'CoypuIDE',
	#tag : 'Attic'
}

{ #category : 'building' }
ICCleanSlider class >> backgroundDefaultColor [

	^ Color gray
]

{ #category : 'building' }
ICCleanSlider class >> barDefaultColor [

	^ Color blue 
]

{ #category : 'building' }
ICCleanSlider class >> defaultMaxPixelDistance [

	^ 25
]

{ #category : 'testing' }
ICCleanSlider class >> exampleSegmented [

	<script>
	| bl |
	bl := self new.
	bl minValue: 0.
	bl maxValue: 20.
	bl stepValue: 1.
	bl enumeratedValues: #( 0 5 10 15 20 ).
	bl sliderPixelMargin: 20.
	bl size: 500 @ 25.
	bl buildSlider.
	bl validatedValueCallback: [ :e | "self changedTimeValue: e" ].
	bl margin: (BlInsets top: 5).
	bl openInSpace
]

{ #category : 'testing' }
ICCleanSlider class >> exampleSegmentedWithColors [

	<script>
	| bl2 |
	bl2 := self new.
	bl2 enumeratedColors: {
			Color lightBlue.
			Color blue.
			Color orange.
			Color red }.
	bl2 position: 0 @ 20.
	bl2 minValue: 50.
	bl2 maxValue: 200.
	bl2 stepValue: 50.
	bl2 size: 550 @ 48.
	bl2 sliderPixelMargin: 35.
	bl2 buildSlider.
	bl2 validatedValueCallback: [ :e | "self changedOperationalActivityValue: e"
		 ].
	bl2 openInSpace.
]

{ #category : 'building' }
ICCleanSlider class >> interactionDefaultColor [

	^ Color pink alpha: 0.5
]

{ #category : 'building' }
ICCleanSlider class >> interactorDefaultColor [

	^ Color red 
]

{ #category : 'testing' }
ICCleanSlider class >> visualTestNotSegmented [

	<script>
	| bl space val |
	bl := self new.
	bl minValue: 10.
	bl maxValue: 50.
	bl stepValue: 1.
	bl buildSlider.
	space := bl openInNewSpace.
	space windowExtent: 1920 @ 1050.
	space setPosition: 0 @ 30.
	val := space -> bl.
	"	bl validatedValueCallback: [ :e | e inspect ]."
	^ val
]

{ #category : 'testing' }
ICCleanSlider class >> visualTestNotSegmentedInspectValue [

	<script>
	| bl space val |
	bl := self new.
	bl minValue: 10.
	bl maxValue: 50.
	bl stepValue: 1.
	bl buildSlider.
	space := bl openInNewSpace.
	space windowExtent: 1920 @ 1050.
	space setPosition: 0 @ 30.
	val := space -> bl.
	bl validatedValueCallback: [ :e | e inspect ].
	^ val
]

{ #category : 'testing' }
ICCleanSlider class >> visualTestSegmented [

	<script>
	| bl space val |
	bl := self new.
	bl minValue: 55.
	bl maxValue: 75.
	bl stepValue: 5.
	bl buildSlider.
	space := bl openInNewSpace.
	space windowExtent: 1920 @ 1050.
	space setPosition: 0 @ 30.
	val := space -> bl.
	^ val
]

{ #category : 'accessing' }
ICCleanSlider >> barThickness: anObject [

	barThickness := anObject
]

{ #category : 'main configuration' }
ICCleanSlider >> beHorizontal [

	self horizontal: true.
]

{ #category : 'main configuration' }
ICCleanSlider >> beVertical [

	self horizontal: false.
]

{ #category : 'private - building' }
ICCleanSlider >> buildDefaultHandle [

	| bl pt |
	pt := 20 @ 20.
	bl := BlElement new
		      geometry: BlCircleGeometry new;
		      background: self class interactorDefaultColor;
		      size: pt;
		      transformDo: [ :t | t translateBy: pt negated / 2 ].
	^ bl
]

{ #category : 'private - building' }
ICCleanSlider >> buildForeground [ 

	self id: #sliderInteractionForeground.
	self size: self widgetSize.
	self background: self class interactionDefaultColor.
]

{ #category : 'private - building' }
ICCleanSlider >> buildHorizontalBackground [

	| bgElt |
	bgElt := BlElement new.
	bgElt size:
		self widgetSize x - (2 * self sliderPixelMargin) @ barThickness.
	bgElt id: #sliderBackground.
	bgElt position: self sliderPixelMargin
		@ (self widgetSize y / 2 - (barThickness / 2)).
	bgElt background: self class backgroundDefaultColor.
	bgElt zIndex: 0.
	self addChild: bgElt.
	self sliderBackground: bgElt
]

{ #category : 'private - building' }
ICCleanSlider >> buildHorizontalBar [

	| bar |
	bar := BlElement new.
	bar size:
		(self valueToCoord: currentValue)
		- (self sliderPixelMargin) @ barThickness.
	bar id: #sliderBar.
	bar position: self sliderPixelMargin
		@ (self widgetSize y / 2 - (barThickness / 2)).
	bar background: self class barDefaultColor.
	bar zIndex: 2.
	self addChild: bar.
	self sliderBar: bar
]

{ #category : 'private - building' }
ICCleanSlider >> buildHorizontalHandle [ 

	| handle pt |
	handle := self buildDefaultHandle.
	handle id: #sliderHandle.
	pt := (self valueToCoord: currentValue)
	      @ (self widgetSize y / 2).
	handle position: pt.
	handle zIndex: 3.
	self addChild: handle.
	self sliderHandle: handle
]

{ #category : 'private - building' }
ICCleanSlider >> buildHorizontalSlider [

	self buildForeground.
	self buildHorizontalBackground.
	self buildHorizontalBar.
	self buildHorizontalHandle
]

{ #category : 'private - building' }
ICCleanSlider >> buildSlider [

	self removeAllShapes.
	self size: self widgetSize.
	self isHorizontal
		ifTrue: [ self buildHorizontalSlider ]
		ifFalse: [ self buildVerticalSlider ].
	self initializeEventHandlers
]

{ #category : 'private - building' }
ICCleanSlider >> buildVerticalBackground [

	
	| bgElt pt1 pt2 |
	bgElt := BlElement new.
	pt1 := barThickness
	       @ (self widgetSize y - (2 * self sliderPixelMargin)).
	bgElt size: pt1.
	bgElt id: #sliderBackground.
	pt2 := self widgetSize x / 2 - ( barThickness / 2)
	       @ self sliderPixelMargin.
	bgElt position: pt2.
	bgElt background: self class backgroundDefaultColor.
	bgElt zIndex: 0.
	self addChild: bgElt.
	self sliderBackground: bgElt.

]

{ #category : 'private - building' }
ICCleanSlider >> buildVerticalBar [

	| bar |
	bar := BlElement new.
	bar size: barThickness
		@ (self widgetSize y - (self valueToCoord: currentValue)
			 - self sliderPixelMargin).
	bar id: #sliderBar.
	bar position: self widgetSize x / 2 - (barThickness / 2)
		@ (self valueToCoord: currentValue).
	bar background: self class barDefaultColor.
	bar zIndex: 2.
	self addChild: bar.
	self sliderBar: bar.

	
]

{ #category : 'private - building' }
ICCleanSlider >> buildVerticalHandle [

	| handle pt |

	handle := self buildDefaultHandle.
	handle id: #sliderHandle.
	pt := self widgetSize x / 2 @ (self valueToCoord: currentValue).
	handle position: pt.
	handle zIndex: 3.
	self addChild: handle.
	self sliderHandle: handle
]

{ #category : 'private - building' }
ICCleanSlider >> buildVerticalSlider [

	self buildForeground.
	self buildVerticalBackground.
	self buildVerticalBar.
	self buildVerticalHandle
]

{ #category : 'changing state' }
ICCleanSlider >> changedCurrentValue: aValue [

^self changedCurrentValue: aValue withSlider: false
]

{ #category : 'changing state' }
ICCleanSlider >> changedCurrentValue: aValue withSlider: aBool [

	| v color |
	v := self valueToCoord: aValue.
	self isHorizontal
		ifTrue: [
			aBool ifTrue: [
				self sliderHandle ifNotNil: [ :sl |
					sl position: v @ sl constraints position y ] ].
			self sliderBar size:
				v - self sliderPixelMargin @ self sliderBar size y ]
		ifFalse: [
			aBool ifTrue: [
				self sliderHandle ifNotNil: [ :sl |
					sl position: sl constraints position x @ v ] ].
			self sliderBar size:
				barThickness
				@ (self widgetSize y - (self valueToCoord: currentValue)
					 - self sliderPixelMargin).
			self sliderBar position:
				self widgetSize x / 2 - (barThickness / 2)
				@ (self valueToCoord: currentValue) ].
	color := self colorForValue: aValue.
	self sliderHandle background: color.
	self sliderBar background: color
]

{ #category : 'changing state' }
ICCleanSlider >> changedHandlePosition: v [

	self isHorizontal 
		ifTrue: [
			self sliderHandle ifNotNil: [ :sl |
				sl position: v @ sl constraints position y ] ]
		ifFalse: [
			self sliderHandle ifNotNil: [ :sl |
				sl position: sl constraints position x @ v ] ]
]

{ #category : 'private' }
ICCleanSlider >> cleanSliderParts [

	sliderBackground := nil.
	sliderBar := nil.
	sliderHandle := nil
]

{ #category : 'private' }
ICCleanSlider >> colorForValue: aValue [

	| i |
	self enumeratedColors
		ifNil: [
			^  endColor
				  mixed: (self proportionOf: aValue)
				  with: self initColor ]
		ifNotNil: [ :list |
			i := self enumeratedValues indexOf: aValue.
			i = 0 ifTrue: [ ^ self initColor ].
			(i > list size) ifTrue: [ ^  endColor ].
			^list at: i ]
]

{ #category : 'private' }
ICCleanSlider >> currentValue [

	^ currentValue
]

{ #category : 'private' }
ICCleanSlider >> currentValue: aNumber [

	(aNumber between: minValue and: maxValue) ifFalse: [ ^ self ].
	currentValue := aNumber.
	self changedCurrentValue: aNumber
]

{ #category : 'api - slider' }
ICCleanSlider >> decrementValue [

	self decrementValue: self stepValue.
]

{ #category : 'api - slider' }
ICCleanSlider >> decrementValue: aValue [

	| tmp |
	tmp := validatedValue - aValue.
	tmp < self maxValue ifTrue: [ self validatedValue: tmp ]
]

{ #category : 'accessing' }
ICCleanSlider >> disabledRebuilding [

	^ disabledRebuilding
]

{ #category : 'accessing' }
ICCleanSlider >> disabledRebuilding: anObject [

	disabledRebuilding := anObject
]

{ #category : 'accessing' }
ICCleanSlider >> endColor: anObject [

	endColor := anObject
]

{ #category : 'accessing' }
ICCleanSlider >> enumeratedColors [

	^ enumeratedColors
]

{ #category : 'accessing' }
ICCleanSlider >> enumeratedColors: anObject [

	enumeratedColors := anObject
]

{ #category : 'api - values' }
ICCleanSlider >> enumeratedValues [
	"since the enumerated value are derived from min, max and step, we lazy initialize it."
	
	enumeratedValues ifNil: [
		enumeratedValues := (self minValue to: self maxValue by:
		                     self stepValue) asOrderedCollection ].
	^ enumeratedValues
]

{ #category : 'accessing' }
ICCleanSlider >> enumeratedValues: anObject [

	enumeratedValues := anObject
]

{ #category : 'accessing' }
ICCleanSlider >> handlePushedPoint [

	^ handlePushedPoint
]

{ #category : 'accessing' }
ICCleanSlider >> handlePushedPoint: anObject [

	handlePushedPoint := anObject
]

{ #category : 'accessing' }
ICCleanSlider >> horizontal: aBoolean [

	isHorizontal := aBoolean 
]

{ #category : 'api - slider' }
ICCleanSlider >> incrementValue [

	self incrementValue: self stepValue
]

{ #category : 'api - slider' }
ICCleanSlider >> incrementValue: aValue [

	| tmp |
	tmp := validatedValue + aValue.
	tmp < self maxValue ifTrue: [ self validatedValue: tmp ]
]

{ #category : 'accessing' }
ICCleanSlider >> initColor [

	^ initColor
]

{ #category : 'accessing' }
ICCleanSlider >> initColor: anObject [

	initColor := anObject
]

{ #category : 'initialization' }
ICCleanSlider >> initialize [

	super initialize.
	barThickness := 8.
	maxValue := 100.0.
	minValue := 0.0.
	self size: 300 @ 30.
	currentValue := 0.0.
	self beHorizontal.
	sliderPixelMargin := 5.
	disabledRebuilding := false.
	stepValue := 1.
	endColor := self class interactorDefaultColor.
	initColor := self class interactorDefaultColor.
	maxPixelDistance := self class defaultMaxPixelDistance
]

{ #category : 'initialization' }
ICCleanSlider >> initializeEventHandlers [

	eventHandler := ICCleanSliderHandler new.
	self addEventHandler: eventHandler
]

{ #category : 'private' }
ICCleanSlider >> is: aValue near: aValue2 [

	^(aValue - aValue2) abs < self maxPixelDistance
]

{ #category : 'accessing' }
ICCleanSlider >> isHorizontal [ 

	^ isHorizontal 
]

{ #category : 'private - building' }
ICCleanSlider >> isSliderBuilt [
	"if no interactor, no slider"

	^ self sliderHandle isNotNil
]

{ #category : 'accessing' }
ICCleanSlider >> maxPixelDistance [

	^ maxPixelDistance 
]

{ #category : 'accessing' }
ICCleanSlider >> maxPixelDistance: anObject [

	maxPixelDistance := anObject
]

{ #category : 'api - values' }
ICCleanSlider >> maxValue [

	^ maxValue
]

{ #category : 'api - values' }
ICCleanSlider >> maxValue: anObject [
	"when we change the maxValue, we are rebuilding the enumerated values and slider"

	maxValue := anObject.
	enumeratedValues := nil.
	self isSliderBuilt ifTrue: [ self rebuildSlider ]
]

{ #category : 'api - values' }
ICCleanSlider >> minValue [

	^ minValue
]

{ #category : 'api - values' }
ICCleanSlider >> minValue: anObject [

	minValue := anObject.
	enumeratedValues := nil.
	currentValue < minValue ifTrue: [ currentValue := minValue copy ].
	self isSliderBuilt ifTrue: [ self rebuildSlider ]
]

{ #category : 'api - values' }
ICCleanSlider >> nearestValue: aValue [

	| val minResult tmp tmp2 |
	self enumeratedValues ifNil: [ ^ aValue ].
	self enumeratedValues isEmpty ifTrue: [ ^ aValue ].
	val := self enumeratedValues first.
	minResult := (aValue - val) abs.
	2 to: enumeratedValues size do: [ :e |
		tmp := self enumeratedValues at: e.
		tmp2 := (aValue - tmp) abs.
		tmp2 < minResult ifTrue: [
			minResult := tmp2.
			val := tmp ] ].
	^ val
]

{ #category : 'api - transformations' }
ICCleanSlider >> pointToValue: point [

	^ self isHorizontal 
		  ifTrue: [ self pointToXValue: point ]
		  ifFalse: [ self pointToYValue: point ]
]

{ #category : 'api - transformations' }
ICCleanSlider >> pointToXValue: point [

	| facteur valeur |
	facteur := point x / self sliderBackground size x.
	valeur := self maxValue - self minValue * facteur.
	valeur := (valeur roundTo: (self stepValue ifNil: [ 1 ]))
	          + self minValue.
	valeur := self nearestValue: valeur.
	^ valeur
]

{ #category : 'api - transformations' }
ICCleanSlider >> pointToYValue: point [

	| facteur valeur |
	facteur := 1 - (point y / self sliderBackground size y).
	valeur := self maxValue - self minValue * facteur.
	valeur := (valeur roundTo: (self stepValue ifNil: [ 1 ]))
	          + self minValue.
	valeur := self nearestValue: valeur.
	^ valeur
]

{ #category : 'private' }
ICCleanSlider >> proportionOf: aValue [
	| i |
	i := self enumeratedValues indexOf: aValue.
	^ (i/self enumeratedValues size)
]

{ #category : 'private - building' }
ICCleanSlider >> rebuildSlider [

	self disabledRebuilding ifTrue: [ ^ self ].
	self buildSlider
]

{ #category : 'private' }
ICCleanSlider >> removeAllShapes [

	| list |
	list := self sliderParts.
	"BlCleanSlider>>sliderParts is only called here and returns the same thing as BlElement>>children"
	self removeEventHandler.
	self removeChildren: list.
	self cleanSliderParts
]

{ #category : 'private' }
ICCleanSlider >> removeEventHandler [

	eventHandler ifNil: [ ^ self ].
	self flag: #toClean. "we should not test this"
	
	self removeEventHandler: eventHandler.
	eventHandler := nil.
	
]

{ #category : 'api - slider' }
ICCleanSlider >> setMaxValue [

	self setValue: self maxValue.
]

{ #category : 'api - slider' }
ICCleanSlider >> setMinValue [

	self setValue: self minValue
]

{ #category : 'api - slider' }
ICCleanSlider >> setValue: aValue [

	(aValue < self maxValue and: [ aValue > self minValue ]) ifTrue: [
		self validatedValue: aValue ].
]

{ #category : 'api - bounds' }
ICCleanSlider >> size: aValue [

	super size: aValue.
	self widgetSize: aValue.
	self isSliderBuilt ifTrue: [ self rebuildSlider ]
]

{ #category : 'accessing' }
ICCleanSlider >> sliderBackground [

	^ sliderBackground
]

{ #category : 'accessing' }
ICCleanSlider >> sliderBackground: anObject [

	sliderBackground := anObject
]

{ #category : 'accessing' }
ICCleanSlider >> sliderBar [

	^ sliderBar
]

{ #category : 'accessing' }
ICCleanSlider >> sliderBar: anObject [

	sliderBar := anObject
]

{ #category : 'events - bar' }
ICCleanSlider >> sliderBarClicked: event [

	| tmp val |
	tmp := self sliderBackground globalPointToLocal: event position.
	val := self pointToValue: tmp.
	self validatedValue: val.
]

{ #category : 'accessing' }
ICCleanSlider >> sliderHandle [

	^ sliderHandle
]

{ #category : 'accessing' }
ICCleanSlider >> sliderHandle: anObject [

	sliderHandle := anObject
]

{ #category : 'events - interactor' }
ICCleanSlider >> sliderHandleMoved: event [

	| val tmp v |
	self handlePushedPoint ifNil: [ ^ self ].
	tmp := self sliderBackground globalPointToLocal: event position.
	val := self pointToValue: tmp.
	tmp := self globalPointToLocal: event position.
	self isHorizontal
		ifTrue: [
			v := tmp x.
			v := v min: (self valueToX: self maxValue).
			v := v max: (self valueToX: self minValue) ]
		ifFalse: [
			v := tmp y.
			v := v min: (self valueToY: self minValue).
			v := v max: (self valueToY: self maxValue) ].

	self changedHandlePosition: v.
	self currentValue: val
]

{ #category : 'events - interactor' }
ICCleanSlider >> sliderHandlePushed: event [

	| value pt1 pt2 |
	self sliderBar ifNil: [ ^ self ].
	value := self pointToValue:
		         (self sliderBackground globalPointToLocal: event position).
	pt1 := self valueToX: value.
	pt2 := self valueToX: currentValue.
	(self is: pt1 near: pt2) ifTrue: [
		self handlePushedPoint: event position copy ]
]

{ #category : 'events - interactor' }
ICCleanSlider >> sliderHandleReleased [

	self handlePushedPoint ifNil: [ ^ self ].
	self handlePushedPoint: nil.
	self validatedValue: currentValue
]

{ #category : 'private' }
ICCleanSlider >> sliderParts [

	| oc |
	oc := OrderedCollection new.
	self sliderBackground ifNotNil: [ :e | oc add: e ].
	self sliderBar ifNotNil: [ :e | oc add: e ].
	self sliderHandle ifNotNil: [ :e | oc add: e ].
	^ oc
]

{ #category : 'accessing' }
ICCleanSlider >> sliderPixelMargin [

	^ sliderPixelMargin 
]

{ #category : 'accessing' }
ICCleanSlider >> sliderPixelMargin: anObject [

	sliderPixelMargin := anObject.
	self isSliderBuilt ifTrue: [ 
		self rebuildSlider ]
]

{ #category : 'api - values' }
ICCleanSlider >> stepValue [

	^ stepValue
]

{ #category : 'api - values' }
ICCleanSlider >> stepValue: anObject [

	stepValue := anObject.
	enumeratedValues := nil.
]

{ #category : 'api - values' }
ICCleanSlider >> validatedValue [

	^ validatedValue
]

{ #category : 'api - values' }
ICCleanSlider >> validatedValue: aValue [

	currentValue := aValue.
	self changedCurrentValue: aValue withSlider: true. 
	validatedValue := aValue.
	self validatedValueCallback ifNotNil: [ :e | e value: validatedValue ]
]

{ #category : 'private' }
ICCleanSlider >> validatedValueCallback [

	^ validatedValueCallback
]

{ #category : 'api - values' }
ICCleanSlider >> validatedValueCallback: anObject [

	validatedValueCallback := anObject
]

{ #category : 'api - transformations' }
ICCleanSlider >> valueToCoord: aValue [

	^ self isHorizontal 
		  ifTrue: [ self valueToX: aValue ]
		  ifFalse: [ self valueToY: aValue ]
]

{ #category : 'api - transformations' }
ICCleanSlider >> valueToX: aValue [

	| current total coeff |
	current := aValue - self minValue.
	total := self maxValue - self minValue.
	coeff := current / total.
	^ self sliderPixelMargin
	  + (self sliderBackground constraints horizontal resizer size * coeff roundTo: 1)
]

{ #category : 'api - transformations' }
ICCleanSlider >> valueToY: aValue [

	| valeurCourante valeurTotale facteur |
	valeurCourante := aValue - self minValue.
	valeurTotale := self maxValue - self minValue.
	facteur := 1 - (valeurCourante / valeurTotale).
	^ self sliderPixelMargin
	  +
		  (self sliderBackground constraints vertical resizer size * facteur
			   roundTo: 1)
]

{ #category : 'accessing' }
ICCleanSlider >> widgetSize [

	^ widgetSize
]

{ #category : 'private' }
ICCleanSlider >> widgetSize: anObject [

	widgetSize := anObject
]
