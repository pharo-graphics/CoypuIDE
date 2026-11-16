"
White knob with simpler black thumb. The knob outer ring is a full circle. White background
"
Class {
	#name : 'ICSimpleKnob',
	#superclass : 'ICKnob',
	#category : 'CoypuIDE-slider',
	#package : 'CoypuIDE',
	#tag : 'slider'
}

{ #category : 'size' }
ICSimpleKnob >> applyMarkerSize [
	"Round thumb instead of the inherited capsule."

	| w |
	w := self diameter / 3.
	marker
		extent: w asPoint;
		geometry: BlCircleGeometry new;
		position: ((self knobSize - w) / 2) @ (self diameter * 5 / 12)
]

{ #category : 'size' }
ICSimpleKnob >> applySize [

	super applySize.
	knob border: (BlBorder paint: Color black width: self knobBorderWidth)
]

{ #category : 'accessing' }
ICSimpleKnob >> backColor [

	^ Color white
]

{ #category : 'api - operations' }
ICSimpleKnob >> doOperations [

	self knob transformDo: [ :t | t rotateBy: angle ].
	self knob zIndex: 100.
	self currentValue: self angleToValue
]

{ #category : 'accessing' }
ICSimpleKnob >> fontSz [
	"25 at the default diameter of 60"

	^ self diameter * 5 / 12
]

{ #category : 'initialization' }
ICSimpleKnob >> initializeDisk [
	"No value arc on this knob"
]

{ #category : 'initialization' }
ICSimpleKnob >> initializeOuterRing [
	"No outer ring on this knob"
]

{ #category : 'accessing' }
ICSimpleKnob >> knobBorderWidth [
	"13 at the default diameter of 60"

	^ self diameter * 13 / 60
]

{ #category : 'accessing' }
ICSimpleKnob >> knobColor [

	^ Color white
]

{ #category : 'accessing' }
ICSimpleKnob >> knobSize [
	"85 at the default diameter of 60, as before the refactor"

	^ self diameter * 17 / 12
]

{ #category : 'accessing' }
ICSimpleKnob >> markerColor [

	^ Color veryVeryDarkGray
]

{ #category : 'accessing' }
ICSimpleKnob >> textColor [

	^ Color veryVeryDarkGray
]

{ #category : 'accessing' }
ICSimpleKnob >> valueColor [

	^ Color black
]
