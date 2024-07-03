Class {
	#name : 'ICLightKnob',
	#superclass : 'ICKnob',
	#category : 'CoypuIDE-knob',
	#package : 'CoypuIDE',
	#tag : 'knob'
}

{ #category : 'initialization' }
ICLightKnob >> backColor [
	^ (Color veryVeryLightGray )
]

{ #category : 'initialization' }
ICLightKnob >> diskColor [ 
	^ (Color magenta)
]

{ #category : 'initialization' }
ICLightKnob >> initializeDisk [
	
	self disk: (BlElement new
		          "background: (Color r:63 g:162 b:227 range:255);"
		   			background: self diskColor;
		           size: diameter + 40 asPoint;
						
					geometry: (BlAnnulusSectorGeometry new
			 					startAngle: -225;
			 					endAngle: -210;
			 					innerRadius: 0.83;
			 					outerRadius: 1.0);
					
					constraintsDo: [ :c |
						c frame horizontal alignCenter.
					c frame vertical alignCenter. ]).
	
	
	self addChild: self disk.
]

{ #category : 'initialization' }
ICLightKnob >> knobColor [
	^(Color white )
]

{ #category : 'initialization' }
ICLightKnob >> markerColor [
	^(Color veryVeryDarkGray )
]

{ #category : 'initialization' }
ICLightKnob >> outerRingColor [
	^(Color lightGray )
]

{ #category : 'initialization' }
ICLightKnob >> textColor [
	^Color veryVeryDarkGray.
]

{ #category : 'initialization' }
ICLightKnob >> valueColor [
	^Color black.
]
