Class {
	#name : #ICIndicatorButton,
	#superclass : #ICButton,
	#category : 'CoypuIDE-button'
}

{ #category : #evaluating }
ICIndicatorButton >> initializeButton [
	
	self button: (BlElement new
            geometry: BlCircleGeometry new;
				background: Color red;
            size: widgetSize -40 asPoint;
				effect: (BlGaussianShadowEffect color: (Color red alpha:1.0)   offset: 0@ 0  width: 25);
           	constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignCenter.
				]).
	self addChild: self button.
]

{ #category : #evaluating }
ICIndicatorButton >> toggle [
	self toggleValue.
	self value = 0 
		ifTrue: [ button background: (Color red alpha: 1.0);
								effect: (BlGaussianShadowEffect color: (Color red alpha:1.0)   offset: 0@ 0  width: 25).
	 ] 
		ifFalse: [ button background: (Color green alpha:
						1.0);
						effect: (BlGaussianShadowEffect color: (Color green alpha:1.0)   offset: 0@ 0  width: 25).
	].
]
