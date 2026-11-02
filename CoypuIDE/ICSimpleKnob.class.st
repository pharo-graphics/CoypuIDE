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

{ #category : 'accessing' }
ICSimpleKnob >> applyMarkerSize [

"Round thumb instead of the inherited capsule."

	| w |
	w := self diameter / 3.
	marker
		extent: w asPoint;
		geometry: BlCircleGeometry new;
		position: ((self knobSize - w) / 2) @ (self diameter * 5 / 12)
]

{ #category : 'accessing' }
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
	self currentValue: self angleToValue.

]

{ #category : 'initialization' }
ICSimpleKnob >> fontSz [
	^25
]

{ #category : 'initialization' }
ICSimpleKnob >> initializeDisk [
	
]

{ #category : 'initialization' }
ICSimpleKnob >> initializeGeometry [ [

	self extent: (diameter + 100) asPoint.
	self background: Color white.
	self clipChildren: false.
	self layout: BlFrameLayout new.
	self padding: (BlInsets all: 7).


	self knob: (BlElement new
			 geometry: BlCircleGeometry new;
			 extent: self knobSize + 25 asPoint;
			 clipChildren: false;
			 background: self knobColor;
			 border: (BlBorder paint: Color black width: 13);
			 constraintsDo: [ :c |
					 c frame horizontal alignCenter.
					 c frame vertical alignCenter ]).

	self addChild: self knob.


	marker := BlElement new
		          extent: 20 asPoint;
		          transformDo: [ :t | t translateBy: -2 @ 0 ];
		          geometry: BlCircleGeometry new;
		          background: self markerColor;
		          position: self knobSize / 2 @ 25.
	marker zIndex: 100.

	self knob addChild: marker
]
]

{ #category : 'initialization' }
ICSimpleKnob >> initializeOuterRing [ 
	
]

{ #category : 'accessing' }
ICSimpleKnob >> knobBorderWidth [

"13 at the default diameter of 60."

	^ self diameter * 13 / 60
]

{ #category : 'initialization' }
ICSimpleKnob >> knobColor [
	^(Color white)
]

{ #category : 'accessing' }
ICSimpleKnob >> knobSize [ 
"85 at the default diameter of 60."

	^ self diameter * 17 / 12
]

{ #category : 'initialization' }
ICSimpleKnob >> markerColor [
	^(Color veryVeryDarkGray )
]

{ #category : 'initialization' }
ICSimpleKnob >> textColor [
	^Color veryVeryDarkGray.
]

{ #category : 'initialization' }
ICSimpleKnob >> valueColor [
	^Color black.
]
