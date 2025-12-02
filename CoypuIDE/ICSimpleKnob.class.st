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
ICSimpleKnob >> initializeGeometry [
	
	| marker |
	self size: (diameter + 100) asPoint.
	self background: Color white.
	self clipChildren: false.
	self layout: BlFrameLayout new.
	self padding:(BlInsets all: 7).

	
	self knob: (BlElement new
			 geometry: BlCircleGeometry new;
			 size: self knobSize+25 asPoint;
			 clipChildren: false;
			 background: self knobColor ;
			 border: (BlBorder paint: Color black width: 13);
			 constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter]).
	
	self addChild: self knob.

	
	marker := BlElement new
		          size: 20 asPoint;
		          transformDo: [ :t | t translateBy: -2 @ 0 ];
					
		          geometry: (BlCircleGeometry new);
		          background: self markerColor;
		          position: self knobSize / 2 @ 25.
			marker zIndex: 100.
			
	self knob addChild: marker
]

{ #category : 'initialization' }
ICSimpleKnob >> initializeOuterRing [ 
	
]

{ #category : 'initialization' }
ICSimpleKnob >> knobColor [
	^(Color white)
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
