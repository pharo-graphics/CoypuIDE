"
Black and magenta knob with cyan thumb
"
Class {
	#name : 'ICDarkKnob3',
	#superclass : 'ICKnob',
	#category : 'CoypuIDE-slider',
	#package : 'CoypuIDE',
	#tag : 'slider'
}

{ #category : 'initialization' }
ICDarkKnob3 >> diskSize [ 

	^ self diameter +30
]

{ #category : 'initialization' }
ICDarkKnob3 >> knobColor [
	^(Color r:45 g:51  b:67 range:255 )
]

{ #category : 'initialization' }
ICDarkKnob3 >> knobSize [ 
	^ self diameter + 20
]

{ #category : 'initialization' }
ICDarkKnob3 >> markerColor [
	^(Color cyan)
]

{ #category : 'initialization' }
ICDarkKnob3 >> outerRingColor [
	^(Color magenta)
]

{ #category : 'initialization' }
ICDarkKnob3 >> outerRingSize [ 
	^ self diameter + 30
]

{ #category : 'initialization' }
ICDarkKnob3 >> valueColor [
	^Color cyan.
]
