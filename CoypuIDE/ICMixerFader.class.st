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
	verticals := #( #( 'Volume' 90 49 ) #( 'Send A' 140 70 )
	                #( 'Master' 200 98 ) ) collect: [ :each |
		             (self label: each first)
			             barLength: (each at: 2)
			             thickness: (each at: 3);
			             yourself ].

	horizontals := #( #( 'Pan' 90 49 ) #( 'Reverb' 140 70 )
	                  #( 'Cutoff' 200 98 ) ) collect: [ :each |
		               ((self label: each first) beHorizontal;
			                yourself)
			               barLength: (each at: 2)
			               thickness: (each at: 3);
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

{ #category : 'size' }
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

{ #category : 'defaults' }
ICMixerFader >> barSize [ 

^ self
		  ifHorizontal: [ barLength @ self slotThickness ]
		  ifVertical: [ self slotThickness @ barLength ]
]

{ #category : 'accessing' }
ICMixerFader >> coloredBarDefaultColor [
	^ Color veryVeryLightGray.
]

{ #category : 'api - bounds' }
ICMixerFader >> defaultBar [ 

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		  background: self barDefaultColor;
		  constraintsDo: [ :c | c ignoreByLayout ];
		  yourself
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

	^ BlElement new
		  background: self handleDefaultColor;
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		  effect: (BlGaussianShadowEffect
				   color: (Color black alpha: 0.6)
				   offset: 4 @ 4
				   width: 15);
		  border: (BlBorder paint: Color veryLightGray width: 2);
		  constraintsDo: [ :c | c ignoreByLayout ];
		  yourself
]

{ #category : 'defaults' }
ICMixerFader >> defaultIsHorizontal [ 
 ^ false 
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

{ #category : 'size' }
ICMixerFader >> fontSize [ 
	"barThickness is my full width, not a bar thickness - scale down accordingly."

	^ self barThickness / 5
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

{ #category : 'size' }
ICMixerFader >> handleSize [ 

^ self
		  ifHorizontal: [ self handleThickness @ self handleWidth ]
		  ifVertical: [ self handleWidth @ self handleThickness]
]

{ #category : 'size' }
ICMixerFader >> handleThickness [ 

	^ self barThickness * 6 / 7
]

{ #category : 'size' }
ICMixerFader >> handleWidth [ 

	^ self barThickness * 3 / 7
]

{ #category : 'initialization' }
ICMixerFader >> initializeParts [ 
	"Ticks go in first so bar, coloured bar and handle draw on top of them."

	self initializeTicks.
	super initializeParts
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

{ #category : 'defaults' }
ICMixerFader >> lengthPadding [ 

^ self handleThickness / 2
]

{ #category : 'defaults' }
ICMixerFader >> slotThickness [ 
^ self barThickness / 7 
]

{ #category : 'size' }
ICMixerFader >> tickSize [ 
	"Ticks span a little wider than the cap, so they read as a scale behind it."

	| span |
	span := self handleWidth * 5 / 4.
	^ self
		  ifHorizontal: [ 3 @ span ]
		  ifVertical: [ span @ 3 ]
]

{ #category : 'api - bounds' }
ICMixerFader >> ticks [
^ ticks
]

{ #category : 'accessing' }
ICMixerFader >> valueLabelFollowsHandle [ 

	^ true
]
