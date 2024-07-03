Class {
	#name : 'ICKnobWithSkew',
	#superclass : 'ICKnob',
	#instVars : [
		'skew'
	],
	#category : 'CoypuIDE-knob',
	#package : 'CoypuIDE',
	#tag : 'knob'
}

{ #category : 'examples' }
ICKnobWithSkew class >> example [ 

	| knob skew container |
	knob := ICKnobWithSkew label: 'Value' minValue: 100 maxValue: 300.

skew := ICKnob label: 'Skew' minValue: 0 maxValue: 2.

skew callBack: [ :skewFactor | knob skew: skewFactor ].
skew setValue: 1.

container := BlElement new background: Color darkGray; layout: BlLinearLayout horizontal; constraintsDo: [ :c | c vertical fitContent. c horizontal fitContent ].

container addChildren: { knob. skew }.

container openInSpace
]

{ #category : 'api - operations' }
ICKnobWithSkew >> angleToValue [

	| normalized mapped |
	normalized := self angle - self minAngle
	              / (self maxAngle - self minAngle).
	normalized = 0 ifFalse: [ normalized := normalized ** skew ].
	mapped := normalized * (self maxValue - self minValue)
	          + self minValue.

	^ mapped asFloat
]

{ #category : 'initialization' }
ICKnobWithSkew >> initialize [ 

	super initialize.
	skew := 1
]

{ #category : 'accessing' }
ICKnobWithSkew >> skew [ 

	^ skew
]

{ #category : 'accessing' }
ICKnobWithSkew >> skew: aFloat [ 

	skew := aFloat 
]
