"
I am an On/Off button to be used to toggle between states (On/Off , Start/Stop).

Use label: to change the the textLabel
"
Class {
	#name : 'ICOnOffButton',
	#superclass : 'ICButton',
	#instVars : [
		'label',
		'textLabel'
	],
	#category : 'CoypuIDE-button',
	#package : 'CoypuIDE',
	#tag : 'button'
}

{ #category : 'evaluating' }
ICOnOffButton >> configuredString: aString [ 
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color black) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:18) }

]

{ #category : 'evaluating' }
ICOnOffButton >> fromDictionary: aDictionary forDsp: aDsp [ 
]

{ #category : 'evaluating' }
ICOnOffButton >> initializeButton [

	self button: (BlElement new
			 geometry: BlCircleGeometry new;
			 background: Color gray;
			 size: widgetSize - 25 asPoint;
			 border: (BlBorder paint: Color black width: 4);
			 effect: (BlGaussianShadowEffect
					  color: (Color black alpha: 1.0)
					  offset: 4 @ 0
					  width: 10);
			 layout: BlFrameLayout new;
			 constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter ]).
	self textLabel: (BlTextElement new
			 text: (self configuredString: 'OFF');
			 constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter ]).

	button addChild: self textLabel.

	self addChild: button
]

{ #category : 'accessing' }
ICOnOffButton >> label [ 
	^ label.
]

{ #category : 'accessing' }
ICOnOffButton >> label: aText [

	label := aText.
	textLabel text: (self configuredString: label)
]

{ #category : 'accessing' }
ICOnOffButton >> textLabel [

^ textLabel 
]

{ #category : 'accessing' }
ICOnOffButton >> textLabel: aText [

	textLabel := aText
]

{ #category : 'evaluating' }
ICOnOffButton >> toggle [

	self toggleValue.

	self value = 0
		ifTrue: [
			button
				background: (Color gray alpha: 1.0);
				border: (BlBorder paint: Color black width: 4);
				effect: (BlGaussianShadowEffect
						 color: (Color black alpha: 1.0)
						 offset: 4 @ 0
						 width: 10).
			textLabel text: (self configuredString: 'OFF') ]
		ifFalse: [
			button
				background: (Color white alpha: 1.0);
				border: (BlBorder paint: Color gray width: 3);
				effect: (BlGaussianShadowEffect
						 color: (Color gray alpha: 1.0)
						 offset: 0 @ 0
						 width: 15).
			textLabel text: (self configuredString: 'ON') ]
]
