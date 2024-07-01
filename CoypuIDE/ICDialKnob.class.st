Class {
	#name : 'ICDialKnob',
	#superclass : 'ICKnob',
	#instVars : [
		'dial'
	],
	#category : 'CoypuIDE-knob',
	#package : 'CoypuIDE',
	#tag : 'knob'
}

{ #category : 'accessing' }
ICDialKnob >> dial [
	^ dial. 
]

{ #category : 'accessing' }
ICDialKnob >> dial: anElement [

	dial := anElement 
]

{ #category : 'initialization' }
ICDialKnob >> diskSize [ 

	^ self diameter +30
]

{ #category : 'initialization' }
ICDialKnob >> initializeDial [
	|st|
	self dial: (BlElement new
		          "background: (Color r:63 g:162 b:227 range:255);"
		   			background: (Color white alpha:0.0);
		          
					layout: BlFrameLayout new;
					"geometry: (BlAnnulusSectorGeometry new
			 					startAngle: -225;
			 					endAngle: -210;
			 					innerRadius: 0.9;
			 					outerRadius: 1);"
					
					constraintsDo: [ :c |
						c horizontal matchParent.
					c vertical matchParent. ]).
	st:= -242.
	1 to: 27 do: 
 	 [:i |
	|dash curr|

	curr:= (i * 10).
	curr:= curr + st.
	curr:= curr + 10. 
	dash:= 
	 BlElement new
		           background: self backColor ;
		           size: diameter+50 asPoint;
	geometry: (BlAnnulusSectorGeometry new
			 startAngle: curr;
			 endAngle: curr + 8;
			 innerRadius: 0.7;
			 outerRadius: 1.0);	

	constraintsDo: [ :c |
	c frame horizontal alignCenter.
	c frame vertical alignCenter ].

	dial addChild: dash.
	 ].
	
	
	self addChild: self dial.
]

{ #category : 'initialization' }
ICDialKnob >> initializeDisks [

	self initializeDisk.
	self initializeDial.
]

{ #category : 'initialization' }
ICDialKnob >> knobColor [
	^(Color r:45 g:51  b:67 range:255 )
	"^(Color r:220 g:220  b:240 range:255 )"
	
]

{ #category : 'initialization' }
ICDialKnob >> knobSize [ 
	^ self diameter-20
]

{ #category : 'initialization' }
ICDialKnob >> markerColor [
	^(Color cyan)
]

{ #category : 'initialization' }
ICDialKnob >> outerRingColor [
	^(Color gray)
]

{ #category : 'initialization' }
ICDialKnob >> outerRingSize [ 
	^ self diameter + 30
]

{ #category : 'initialization' }
ICDialKnob >> valueColor [
	^Color cyan.
]
