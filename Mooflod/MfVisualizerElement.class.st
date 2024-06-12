Class {
	#name : 'MfVisualizerElement',
	#superclass : 'ToElement',
	#instVars : [
		'nbTracks',
		'anim'
	],
	#classVars : [
		'level'
	],
	#category : 'Mooflod-VisualizerRepresentation',
	#package : 'Mooflod',
	#tag : 'VisualizerRepresentation'
}

{ #category : 'adding' }
MfVisualizerElement >> addElementsLevelFour: aChildren [ 

	
]

{ #category : 'adding' }
MfVisualizerElement >> addElementsLevelOne: aName [

	| square label name sect |
	sect := self children at: nbTracks.
	name := BlTextElement new.
	name text: (self textFrom: aName).
	name text fontSize: 18.
	square := MfPulsingSquare new.
	label := MfInstrumentLabelElement new.
	sect addChild: square.
	sect addChild: label.
	sect addChild: name.
	square transformDo: [ :q | q translateBy: 450 @ 15 ].
	name transformDo: [ :t | t translateBy: 130 @ 25 ]
]

{ #category : 'adding' }
MfVisualizerElement >> addElementsLevelThree: aChildren [ 

	
]

{ #category : 'adding' }
MfVisualizerElement >> addElementsLevelTwo: aName [

	| square label pattern sect name |
	sect := self children at: nbTracks.
	name := BlTextElement new.
	name text: (self textFrom: aName).
	name text fontSize: 18.
	pattern := MfPatternElement new
		           min: 4;
		           max: 16;
		           nbsteps: 12.
	square := MfPulsingSquare new.
	label := MfInstrumentLabelElement new.
	sect addChild: square.
	sect addChild: label.
	sect addChild: name.
	square transformDo: [ :q | q translateBy: 450 @ 15 ].
	sect addChild: pattern.
	pattern transformDo: [ :q | q translateBy: 40 @ 100 ].
	name transformDo: [ :t | t translateBy: 130 @ 25 ]
]

{ #category : 'adding' }
MfVisualizerElement >> addInstrument: aName [

	nbTracks < 4 ifFalse: [ ^ self ].
	nbTracks := nbTracks +1.
	self initLevelRepresentation: aName
]

{ #category : 'accessing' }
MfVisualizerElement >> anim [ 

^anim
]

{ #category : 'as yet unclassified' }
MfVisualizerElement >> cleanVisualizer [

	self childrenDo: [ :c | c childrenDo: [ :cc | cc removeFromParent ] ].
	nbTracks := 0
]

{ #category : 'as yet unclassified' }
MfVisualizerElement >> initAnimation: nbSteps [

	anim := BlAnimation new duration: (nbSteps / 9) seconds.
	anim addEventHandler: (BlEventHandler
			 on: BlAnimationLoopDoneEvent
			 do: [ :e | self cleanVisualizer ]).
	self addAnimation: anim
]

{ #category : 'as yet unclassified' }
MfVisualizerElement >> initLevelRepresentation: aName [

	level == 1 ifTrue: [ self addElementsLevelOne: aName ].
	level == 2 ifTrue: [ self addElementsLevelTwo: aName].
	level == 3 ifTrue: [ self addElementsLevelThree: aName ].
	level == 4 ifTrue: [ self addElementsLevelFour: aName ]
]

{ #category : 'as yet unclassified' }
MfVisualizerElement >> initSections [

	| y |
	y := 0.
	1 to: 4 do: [ :s |
		| sect |
		sect := MfVisualizerSectionElement new.

		sect transformDo: [ :t | t translateBy: 0 @ y ].
		y := y + 200.
		self addChild: sect ].

]

{ #category : 'initialization' }
MfVisualizerElement >> initialize [

	super initialize.
	self geometry: BlRectangleGeometry new.
	self size: 500 @ 800.
	self border: (BlBorder paint: Color lightGray width: 2).
self initSections.
	nbTracks := 0
]

{ #category : 'accessing' }
MfVisualizerElement >> level [ 
^level
]

{ #category : 'accessing' }
MfVisualizerElement >> level: aLevel [

	level := aLevel.
	
]

{ #category : 'accessing' }
MfVisualizerElement >> nbTracks [

^nbTracks 
]

{ #category : 'as yet unclassified' }
MfVisualizerElement >> openVisualizer: aVisualizer [

	| space |
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	aVisualizer transformDo: [ :c | c translateBy: 200 @ 50 ].
	space root addChild: aVisualizer.
	space toTheme: MfMooflodTheme new.
	space show.
	^ aVisualizer
]

{ #category : 'adding' }
MfVisualizerElement >> textFrom: aName [

	^ aName asRopedText attributes:
		  { (BlTextForegroundAttribute paint: Color white) }
]
