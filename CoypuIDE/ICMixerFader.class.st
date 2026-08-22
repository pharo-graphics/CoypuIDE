"
Mix console fader, usually used for level staging
"
Class {
	#name : 'ICMixerFader',
	#superclass : 'ICFader',
	#instVars : [
		'ticks'
	],
	#category : 'CoypuIDE-slider',
	#package : 'CoypuIDE',
	#tag : 'slider'
}

{ #category : 'example' }
ICMixerFader class >> differentSizesExample [ 
	"Three sizes in each orientation, side by side."

	<script>
	| verticals horizontals column space |
	verticals := #( #( 90 49 ) #( 140 70 ) #( 200 98 ) ) collect: [ :pair |
		             (self label: pair second printString)
			             barLength: pair first
			             thickness: pair second;
			             yourself ].

	horizontals := #( #( 90 49 ) #( 140 70 ) #( 200 98 ) ) collect: [ :pair |
		               ((self label: pair second printString) beHorizontal;
			                yourself)
			               barLength: pair first
			               thickness: pair second;
			               yourself ].

	column := BlElement new
		          layout: BlLinearLayout vertical alignCenter;
		          constraintsDo: [ :c |
			          c horizontal matchParent.
			          c vertical matchParent ];
		          background: Color black;
		          addChild: (self rowOf: verticals);
		          addChild: (self rowOf: horizontals);
		          yourself.

	space := BlSpace new.
	space extent: 760 @ 720.
	space title: 'ICMixerFader - three sizes, both orientations'.
	space root
		background: Color black;
		addChild: column.
	space show

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

{ #category : 'api - bounds' }
ICMixerFader >> applySize [ 
	super applySize.
	self applyTicks
]

{ #category : 'api - bounds' }
ICMixerFader >> applyTicks [

	| step |
	ticks ifNil: [ ^ self ].
	step := barLength / (self defaultTickCount - 1).
	ticks withIndexDo: [ :each :i |
			| along |
			along := i - 1 * step.
			each extent: self tickSize.
			each position: (self
					 ifHorizontal: [
						 self barOrigin x + along
						 @ (self crossCenter - (self tickSize y / 2)) ]
					 ifVertical: [
						 self crossCenter - (self tickSize x / 2)
						 @ (self barOrigin y + along) ]) ]
]

{ #category : 'api - bounds' }
ICMixerFader >> barDefaultColor [

	^ Color black 
]

{ #category : 'api - values' }
ICMixerFader >> basicSetValue: aNumber [

	value := aNumber.
	self callBack ifNotNil: [ :e | e value: value ]
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

{ #category : 'defaults' }
ICMixerFader >> defaultTickColor [

^ Color veryLightGray
]

{ #category : 'defaults' }
ICMixerFader >> defaultTickCount [ 

	^ 5
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
ICMixerFader >> initalizeTicks [ 

ticks := (1 to: self defaultTickCount) collect: [ :i |
		         BlElement new
			         geometry: BlRectangleGeometry new;
			         background: self tickColor;
			         constraintsDo: [ :c | c ignoreByLayout ];
			         yourself ].
	self addChildren: ticks
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
ICMixerFader >> initializeParts [ 
	"Ticks go in first so bar, coloured bar and handle draw on top of them."

	self initializeTicks.
	super initializeParts
]

{ #category : 'initialization' }
ICMixerFader >> initializeSizes [ 

	barLength := self defaultBarLength.
	barThickness := self defaultBarThickness.
	marginLength := self defaultMarginLength.
	marginThickness := self defaultMarginThickness.
]

{ #category : 'initialization' }
ICMixerFader >> initializeTicks [

	ticks := (1 to: self defaultTickCount) collect: [ :i |
			         BlElement new
				         geometry: BlRectangleGeometry new;
				         background: self defaultTickColor;
				         constraintsDo: [ :c | c ignoreByLayout ];
				         yourself ].
	self addChildren: ticks
]

{ #category : 'initialization' }
ICMixerFader >> initializeValues [

	self minValue: 0.
	self maxValue: 100.
	value := self minValue 
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

{ #category : 'api - bounds' }
ICMixerFader >> tickSize [

	^ self
		  ifHorizontal: [ 3 @ (self barThickness * 4 / 7) ]
		  ifVertical: [ self barThickness * 4 / 7 @ 3 ]
]

{ #category : 'api - transformations' }
ICMixerFader >> updateColoredBarTo: aPosition [

	self
		ifHorizontal: [
				coloredBar position: bar position.
				coloredBar extent:
					(aPosition - coloredBar position) x @ barThickness ]
		ifVertical: [
				coloredBar position:
					aPosition x - (barThickness / 2) @ aPosition y.
				coloredBar extent:
					barThickness @ (bar position y + barLength - aPosition y) ]
]

{ #category : 'api - transformations' }
ICMixerFader >> valueAtCoord: aPoint [

	^ self
		  ifHorizontal: [ self valueAtX: aPoint ]
		  ifVertical: [ self valueAtY: aPoint ]
]
