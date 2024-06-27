Class {
	#name : 'ICDarkKnob4',
	#superclass : 'ICKnob',
	#category : 'CoypuIDE-knob',
	#package : 'CoypuIDE',
	#tag : 'knob'
}

{ #category : 'initialization' }
ICDarkKnob4 >> diskSize [ 

	^ self diameter +55
]

{ #category : 'as yet unclassified' }
ICDarkKnob4 >> doOperations [

	self knob transformDo: [ :t | t rotateBy: angle ].
	self knob zIndex: 100.
	self disk geometry endAngle: angle - 90.
	"self disk zIndex: 200."
	self currentValue: self angleToValue.
]

{ #category : 'initialization' }
ICDarkKnob4 >> knobColor [
	^(Color r:45 g:51  b:67 range:255 )
]

{ #category : 'initialization' }
ICDarkKnob4 >> knobSize [ 
	^ self diameter+40
]

{ #category : 'initialization' }
ICDarkKnob4 >> markerColor [
	^(Color cyan)
]

{ #category : 'initialization' }
ICDarkKnob4 >> outerRingColor [
	^(Color magenta)
]

{ #category : 'initialization' }
ICDarkKnob4 >> valueColor [
	^Color cyan.
]
