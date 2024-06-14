Class {
	#name : 'MfPerformanceNbStepsElement',
	#superclass : 'ToElement',
	#instVars : [
		'label',
		'nbSteps',
		'text',
		'anim',
		'animRunning'
	],
	#category : 'Mooflod-MfPerformanceNbSteps',
	#package : 'Mooflod',
	#tag : 'MfPerformanceNbSteps'
}

{ #category : 'as yet unclassified' }
MfPerformanceNbStepsElement class >> exampleNbSteps [

	<script>
	| s space |
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.  
	space toTheme: MfMooflodTheme new.
	s := self new.
	s addSteps: 189.
	s transformDo: [ :c | c translateBy: 200 @ 150 ].
	space root addChild: s.
	space show.
	^ s
]

{ #category : 'adding' }
MfPerformanceNbStepsElement >> addSteps: aNbOfSteps [

	nbSteps := aNbOfSteps.
	self initializeStepsLabel
]

{ #category : 'accessing' }
MfPerformanceNbStepsElement >> anim [ 

^anim
]

{ #category : 'accessing' }
MfPerformanceNbStepsElement >> animRunning [

^animRunning 
]

{ #category : 'accessing' }
MfPerformanceNbStepsElement >> animRunning: aBoolean [

animRunning:= aBoolean 
]

{ #category : 'initialization' }
MfPerformanceNbStepsElement >> initialize [

	super initialize.
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 18).
	self size: 350 @ 160.

	self background: Color black.
	self addSteps: 0.
	animRunning := false
]

{ #category : 'as yet unclassified' }
MfPerformanceNbStepsElement >> initializeAnimation: aBpm [
	animRunning:= true.
	anim := BlAnimation new duration: (60 / 4 / aBpm) seconds.
	anim beInfinite.
	anim addEventHandler: (BlEventHandler
			 on: BlAnimationLoopDoneEvent
			 do: [ :e |
				 animRunning ifTrue: [
					 nbSteps < 30000 ifTrue: [
						 nbSteps := nbSteps + 1.
						 self setStepsLabel: nbSteps ] ] ]).
	self addAnimation: anim
]

{ #category : 'initialization' }
MfPerformanceNbStepsElement >> initializeStepsLabel [

	text := BlTextElement new.
	text text:
		('Performance elapsed number of steps' asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color green) }).
	text text fontSize: 19.
	text constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignTop ].



	label := BlTextElement new.
	label text: (nbSteps asString asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color green) }).
	label text fontSize: 22.
	label constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	self addChild: label.
	self addChild: text.
	self initializeAnimation: 139.
]

{ #category : 'accessing' }
MfPerformanceNbStepsElement >> label [ 

^label
]

{ #category : 'accessing' }
MfPerformanceNbStepsElement >> nbSteps [

^nbSteps
]

{ #category : 'initialization' }
MfPerformanceNbStepsElement >> setStepsLabel: aNbOfSteps [

	label text: (nbSteps asString asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color green) }).
	label text fontSize: 22.

]

{ #category : 'accessing' }
MfPerformanceNbStepsElement >> text [
^text
]
