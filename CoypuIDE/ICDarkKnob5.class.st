Class {
	#name : 'ICDarkKnob5',
	#superclass : 'ICKnob',
	#instVars : [
		'disk2'
	],
	#category : 'CoypuIDE-knob',
	#package : 'CoypuIDE',
	#tag : 'knob'
}

{ #category : 'as yet unclassified' }
ICDarkKnob5 >> disk2 [

	^ disk2
]

{ #category : 'initialization' }
ICDarkKnob5 >> disk2: anElement [

	disk2:= anElement.
]

{ #category : 'initialization' }
ICDarkKnob5 >> disk2Color [

	^ Color magenta
]

{ #category : 'initialization' }
ICDarkKnob5 >> diskSize [ 

	^ self diameter +40
]

{ #category : 'as yet unclassified' }
ICDarkKnob5 >> doOperations [

	self knob transformDo: [ :t | t rotateBy: angle ].
	self knob zIndex: 100.
	self disk geometry endAngle: angle - 90.
	"self disk2 geometry endAngle: angle - 90."
	self disk2 geometry startAngle: angle - 90.
	self disk2 zIndex: 200.
	self currentValue: self angleToValue.
]

{ #category : 'initialization' }
ICDarkKnob5 >> initializeDisk2 [
	
	self disk2: (BlElement new
		          "background: (Color r:63 g:162 b:227 range:255);"
		   			background: self disk2Color ;
		           size: self diskSize -60 asPoint;
						
					geometry: (BlAnnulusSectorGeometry new
			 					startAngle: -210;
			 					endAngle: 45;
			 					innerRadius: 0.73;
			 					outerRadius: 0.9);
					
					constraintsDo: [ :c |
						c frame horizontal alignCenter.
					c frame vertical alignCenter. ]).
	
	
	self addChild: self disk2.
]

{ #category : 'initialization' }
ICDarkKnob5 >> initializeDisks [ 

	self initializeDisk.
	self initializeDisk2.
]

{ #category : 'initialization' }
ICDarkKnob5 >> knobColor [
	^(Color r:45 g:51  b:67 range:255 )
]

{ #category : 'initialization' }
ICDarkKnob5 >> knobSize [ 
	^ self diameter+20
]

{ #category : 'initialization' }
ICDarkKnob5 >> markerColor [
	^(Color cyan)
]

{ #category : 'initialization' }
ICDarkKnob5 >> outerRingColor [
	^(Color veryVeryDarkGray )
]

{ #category : 'initialization' }
ICDarkKnob5 >> valueColor [
	^Color cyan.
]
