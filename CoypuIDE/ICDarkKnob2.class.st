Class {
	#name : 'ICDarkKnob2',
	#superclass : 'ICKnob',
	#category : 'CoypuIDE-knob',
	#package : 'CoypuIDE',
	#tag : 'knob'
}

{ #category : 'initialization' }
ICDarkKnob2 >> diskSize [ 

	^ self diameter + 30
]

{ #category : 'initialization' }
ICDarkKnob2 >> knobColor [
	^(Color r:45 g:51  b:67 range:255 )
]

{ #category : 'initialization' }
ICDarkKnob2 >> knobSize [ 
	^ self diameter+ 20
]

{ #category : 'initialization' }
ICDarkKnob2 >> markerColor [
	^(Color cyan)
]

{ #category : 'initialization' }
ICDarkKnob2 >> outerRingColor [
	^(Color veryDarkGray )
]

{ #category : 'initialization' }
ICDarkKnob2 >> outerRingSize [ 
	^ self diameter + 30
]

{ #category : 'initialization' }
ICDarkKnob2 >> valueColor [
	^Color cyan.
]
