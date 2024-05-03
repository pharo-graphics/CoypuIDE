Class {
	#name : #MfPatternElement,
	#superclass : #ToElement,
	#instVars : [
		'nbOfSteps'
	],
	#classVars : [
		'max',
		'min',
		'nbsteps'
	],
	#category : #MooflodPatternWidget
}

{ #category : #adding }
MfPatternElement >> addInstrumentToStep [
	"Change the value of the drum attribute for the bar clicked, and update his color for visualization undestanding"

	self childrenDo: [ :child |
		child addEventHandlerOn: BlMouseDownEvent do: [ :evt |
			child instrument not
				ifTrue: [
					child background: Color black.
					child assignInstrument  ]
				ifFalse: [
					child background: Color white.
					child removeInstrument  ] ] ]
]

{ #category : #adding }
MfPatternElement >> addStepsToThePattern: nbSteps [
	"Add all bars element in the pattern to display them"

	| step changingX |
	nbOfSteps := 0.
	changingX := 2.5.
	(nbSteps between: min and: max) ifTrue: [
		nbOfSteps := nbSteps.
		1 to: nbSteps do: [ :i |
			step := MfStepElement new.
			step transformDo: [ :t | t translateBy: changingX @ 0 ].
			changingX := changingX + 35.
			self addChild: step ] ].
	self size: 35 * nbSteps @ 60.
	self addInstrumentToStep
]

{ #category : #'visual properties' }
MfPatternElement >> backgroundPaint [ 
	"Define the background for the pattern"
	^ Color red
]

{ #category : #initialization }
MfPatternElement >> initialize [

	super initialize.
	self size: self patternExtent.
	self geometry: BlRectangleGeometry new.
	self layout: BlFrameLayout new.
	self defaultSkin: MfPatternElementSkin new.

]

{ #category : #skin }
MfPatternElement >> installRawStyle [

	super installRawStyle.
]

{ #category : #accessing }
MfPatternElement >> max [ 
	
	^max.
]

{ #category : #accessing }
MfPatternElement >> max: aMax [

	max:= aMax.
]

{ #category : #accessing }
MfPatternElement >> min [ 

	^min.
]

{ #category : #accessing }
MfPatternElement >> min: aMin [

	min:= aMin.
]

{ #category : #accessing }
MfPatternElement >> nbOfSteps [

	^ nbOfSteps
]

{ #category : #accessing }
MfPatternElement >> nbsteps [

	^ nbsteps
]

{ #category : #accessing }
MfPatternElement >> nbsteps: someNbSteps [

	nbsteps := someNbSteps.
	self addStepsToThePattern: nbsteps
]

{ #category : #initialization }
MfPatternElement >> newRawSkin [ 

^ MfPatternElementSkin new.
]

{ #category : #action }
MfPatternElement >> openPattern: aPattern [

	| space |
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	aPattern transformDo: [ :c | c translateBy: 180 @ 200 ].
	space root addChild: aPattern.
	space toTheme: MfPatternElementTheme new.
	space applyAllSkinInstallers .
	space show.
	^ aPattern
]

{ #category : #'visual properties' }
MfPatternElement >> patternExtent [

	^ 36@60
]
