Class {
	#name : #MfTimerElement,
	#superclass : #ToElement,
	#instVars : [
		'anim',
		'timerValue',
		'annulus',
		'angle',
		'currentAngle'
	],
	#classVars : [
		'value'
	],
	#category : #MooflodTimerWidget
}

{ #category : #accessing }
MfTimerElement >> anim [
	
	^ anim.
]

{ #category : #'as yet unclassified' }
MfTimerElement >> annulusGeometry [

	^ BlAnnulusSectorGeometry new
		  startAngle: 0;
		  endAngle: 360;
		  innerRadius: 0.865
]

{ #category : #'visual properties' }
MfTimerElement >> backgroundPaint [ 

	^ Color black.
]

{ #category : #accessing }
MfTimerElement >> currentAngle [

^currentAngle .
]

{ #category : #initialization }
MfTimerElement >> defaultGeometry [

	^ BlCircleGeometry new matchExtent: self extent 
]

{ #category : #initialization }
MfTimerElement >> initAnimation [

	anim := BlAnimation new
		        duration: 1 seconds;
		        loops: value.
	self addEventHandlerOn: BlMouseDownEvent do: [ :a |
		anim addEventHandler: (BlEventHandler
				 on: BlAnimationLoopDoneEvent
				 do: [ :e |
					 currentAngle := currentAngle - angle.
					 self updateAnnulusAngle: currentAngle .
					 self updateValue.
					 self background: Color random ]) ].

	self addAnimation: anim
]

{ #category : #initialization }
MfTimerElement >> initialize [

	super initialize.
	self initAnimation.
	self initializeAnnulus
]

{ #category : #initialization }
MfTimerElement >> initializeAnnulus [

	annulus := BlElement new background: Color lightOrange.
	annulus size: 300 @ 300.
	annulus geometry: self annulusGeometry.
	annulus constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	self addChild: annulus
]

{ #category : #initialization }
MfTimerElement >> initializeTimerValue [

	timerValue := BlTextElement new.
	timerValue text: value asString asRopedText.
	angle := 360 / value.
	currentAngle:= 360.
	timerValue text fontSize: 100.
	timerValue text attributes:
		{ (BlTextForegroundAttribute paint: Color lightOrange) }.
	timerValue constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	self addChild: timerValue
]

{ #category : #skin }
MfTimerElement >> installRawStyle [ 

	super installRawStyle .
]

{ #category : #'instance creation' }
MfTimerElement >> newRawSkin [ 

^ MfTimerElementSkin new.
]

{ #category : #action }
MfTimerElement >> openTimer: aTimer [

	| space |
	space := BlSpace new.
	aTimer defaultSkin: MfTimerElementSkin new.
	space root layout: BlFlowLayout horizontal.
	aTimer transformDo: [ :c | c translateBy: 200 @ 150 ].
	space root addChild: aTimer.
	space toTheme: MfTimerElementTheme new.
	space show.
	^ aTimer
]

{ #category : #initialization }
MfTimerElement >> setTimerValue: aValue [

	timerValue := MfInputValueElement new.
	timerValue text: aValue asString asRopedText.
	timerValue text fontSize: 100.
	timerValue text attributes:
		{ (BlTextForegroundAttribute paint: Color lightOrange ) }.
	timerValue constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	self addChild: timerValue
]

{ #category : #accessing }
MfTimerElement >> timerValue [

^timerValue
]

{ #category : #'as yet unclassified' }
MfTimerElement >> updateAnnulusAngle: newAngle [

	annulus geometry: (BlAnnulusSectorGeometry new
			 startAngle: 0;
			 endAngle: newAngle;
			 innerRadius: 0.865)
]

{ #category : #protocol }
MfTimerElement >> updateValue [

	value := value - 1.
	timerValue removeFromParent.
	self setTimerValue: value
]

{ #category : #evaluating }
MfTimerElement >> value [ 
		^value.
]

{ #category : #accessing }
MfTimerElement >> value: aValue [

	value := aValue.
	self initializeTimerValue .
]
