Class {
	#name : 'ICDarkKnob4',
	#superclass : 'ICKnob',
	#instVars : [
		'disk2'
	],
	#category : 'CoypuIDE-knob',
	#package : 'CoypuIDE',
	#tag : 'knob'
}

{ #category : 'as yet unclassified' }
ICDarkKnob4 >> disk2 [

	^ disk2
]

{ #category : 'initialization' }
ICDarkKnob4 >> disk2: anElement [

	disk2:= anElement.
]

{ #category : 'initialization' }
ICDarkKnob4 >> disk2Color [

	^ Color magenta
]

{ #category : 'initialization' }
ICDarkKnob4 >> diskSize [ 

	^ self diameter + 35
]

{ #category : 'api - operations' }
ICDarkKnob4 >> doOperations [

	self knob transformDo: [ :t | t rotateBy: angle ].
	self knob zIndex: 100.
	self disk geometry endAngle: angle - 90.
	"self disk2 geometry endAngle: angle - 90."
	self disk2 geometry startAngle: angle - 90.
	self disk2 zIndex: 200.
	self currentValue: self angleToValue.
]

{ #category : 'initialization' }
ICDarkKnob4 >> initializeDisk2 [
	
	self disk2: (BlElement new
		          "background: (Color r:63 g:162 b:227 range:255);"
		   			background: self disk2Color ;
		           size: self diskSize + 20 asPoint;
						
					geometry: (BlAnnulusSectorGeometry new
			 					startAngle: -210;
			 					endAngle: 45;
			 					innerRadius: 0.88;
			 					outerRadius: 0.95);
					
					constraintsDo: [ :c |
						c frame horizontal alignCenter.
					c frame vertical alignCenter. ]).
	
	
	self addChild: self disk2.
]

{ #category : 'initialization' }
ICDarkKnob4 >> initializeDisks [ 

	self initializeDisk.
	self initializeDisk2.
]

{ #category : 'initialization' }
ICDarkKnob4 >> knobColor [
	^(Color r:45 g:51  b:67 range:255 )
]

{ #category : 'initialization' }
ICDarkKnob4 >> knobSize [ 
	^ self diameter+20
]

{ #category : 'initialization' }
ICDarkKnob4 >> markerColor [
	^(Color cyan)
]

{ #category : 'initialization' }
ICDarkKnob4 >> outerRingColor [
	^(Color veryVeryDarkGray )
]

{ #category : 'initialization' }
ICDarkKnob4 >> valueColor [
	^Color cyan.
]
