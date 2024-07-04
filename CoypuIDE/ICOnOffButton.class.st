Class {
	#name : #ICOnOffButton,
	#superclass : #ICButton,
	#instVars : [
		'label'
	],
	#category : 'CoypuIDE-button'
}

{ #category : #'as yet unclassified' }
ICOnOffButton >> abel: aText [ 
	label:= aText.
]

{ #category : #evaluating }
ICOnOffButton >> configuredString: aString [ 
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color black) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:18) }

]

{ #category : #evaluating }
ICOnOffButton >> initializeButton [ 
	self button: (BlElement new
            geometry: BlCircleGeometry new;
				background: Color gray;
            size: widgetSize -25 asPoint;
            border: (BlBorder paint: (Color black ) width: 4);
			effect: (BlGaussianShadowEffect color: (Color black alpha:1.0)   offset: 4@ 0  width: 10);
				layout: BlFrameLayout new;
				
           	constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignCenter.
				]).
	self label: (BlTextElement new text: 
	(self configuredString: 'OFF');
	constraintsDo: [ :c|
		c frame horizontal alignCenter.
		c frame vertical alignCenter.
		 ]
	).

	button addChild: self label.
	
	self addChild: button. 
					
]

{ #category : #'as yet unclassified' }
ICOnOffButton >> label [ 
	^ label.
]

{ #category : #'as yet unclassified' }
ICOnOffButton >> label: aText [ 
	label:= aText.
]

{ #category : #evaluating }
ICOnOffButton >> toggle [ 
	self toggleValue.

	self value = 0
		ifTrue: [ 
			button background: (Color gray alpha: 1.0);
			         border: (BlBorder paint: (Color black ) width: 4);
			effect: (BlGaussianShadowEffect color: (Color black alpha:1.0)   offset: 4@ 0  width: 10).
			label text: (self configuredString: 'OFF').

	 	] 
		ifFalse: [
			button background: (Color white alpha:1.0);
					border: (BlBorder paint: (Color gray) width: 3);
			      effect: (BlGaussianShadowEffect color: (Color gray alpha:1.0)   offset: 0@ 0  width: 15).
			label text: (self configuredString: 'ON').

			
		].

]
