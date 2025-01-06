"
A button with a label.
By default a click button, can become a toggle by sending the message isToggleable: true
"
Class {
	#name : 'ICLabelButton',
	#superclass : 'ICButton',
	#instVars : [
		'inputText',
		'inputLabel'
	],
	#category : 'CoypuIDE-button',
	#package : 'CoypuIDE',
	#tag : 'button'
}

{ #category : 'instance creation' }
ICLabelButton class >> fromDictionary: aDictionary forDsp: aDsp [

	| paramLabel btn paramLabelAndType |
	paramLabel := aDictionary at: #label.
	"we split the actual label from its type"
	paramLabelAndType := paramLabel splitOn: $~.
	btn := self label: (paramLabelAndType at: 1).
	btn callback: [ :x | aDsp setValue: x parameter: paramLabel ].
	"if the button is a checkbox"
	
	paramLabelAndType size > 1 ifTrue: [ btn isToggleable: true ].

	^ btn
]

{ #category : 'as yet unclassified' }
ICLabelButton class >> label: aString [ 
	|e|
	e:= self new inputText: aString.
	e initializeLabel.
	^ e.
]

{ #category : 'evaluating' }
ICLabelButton >> backColor [ 
	^Color veryVeryDarkGray.
]

{ #category : 'evaluating' }
ICLabelButton >> buttonColor [ 
	"^ Color lightGreen ."
	"^Color cyan."
	^ Color yellow.

]

{ #category : 'evaluating' }
ICLabelButton >> configuredString: aString [ 
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color black) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:16) }

]

{ #category : 'evaluating' }
ICLabelButton >> configuredStringDark: aString [ 
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color white) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:16) }
]

{ #category : 'evaluating' }
ICLabelButton >> glowColor [ 
	"^ Color green ."
	"^ Color lightBlue."
	^ Color yellow.

]

{ #category : 'evaluating' }
ICLabelButton >> initializeButton [

	self layout: BlGridLayout horizontal.
	self constraintsDo: [ :c | c horizontal fitContent ].
	self button: (BlElement new
			 geometry: (BlRoundedRectangleGeometry cornerRadius: 8);
			 background: self offColor ;
			 "size: widgetSize - 25 asPoint;"border:
				 (BlBorder paint: Color darkGray width: 4);
			 layout: BlFrameLayout new;
			 padding: (BlInsets all: 10);
			 constraintsDo: [ :c |
				 c horizontal fitContent.
				 c vertical fitContent ];
			 effect: (BlGaussianShadowEffect
					  color: (Color gray alpha: 1.0)
					  offset: 0 @ 0
					  width: 4)).

	self addChild: button
]

{ #category : 'evaluating' }
ICLabelButton >> initializeLabel [

	inputLabel := BlTextElement new.
	inputLabel text: (self configuredStringDark: inputText).
	inputLabel constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	"inputLabel zIndex: 200."
	self button addChild: inputLabel
]

{ #category : 'evaluating' }
ICLabelButton >> initializeWidgetSize [ 
	widgetSize:= 200@200.
]

{ #category : 'evaluating' }
ICLabelButton >> inputText [ 
	^ inputText.
]

{ #category : 'evaluating' }
ICLabelButton >> inputText: aString [ 
	inputText := aString.
]

{ #category : 'as yet unclassified' }
ICLabelButton >> lightDown [
	button
		background: (self buttonColor alpha: 1.0);
		border: (BlBorder paint: (self glowColor alpha: 0.5) width: 3);
		effect: (BlGaussianShadowEffect
				 color: (self glowColor alpha: 1.0)
				 offset: 0 @ 0
				 width: 20).
	inputLabel text: (self configuredString: inputText)
	
]

{ #category : 'as yet unclassified' }
ICLabelButton >> lightUp [

button
		background: (self offColor alpha: 1.0);
		border: (BlBorder paint: Color darkGray width: 4);
		effect: (BlGaussianShadowEffect
				 color: (Color white alpha: 0.0)
				 offset: 0 @ 0
				 width: 10).
	inputLabel text: (self configuredStringDark: inputText)
]

{ #category : 'evaluating' }
ICLabelButton >> offColor [ 
	^ Color veryVeryDarkGray.
]

{ #category : 'evaluating' }
ICLabelButton >> toggle [ 
	self toggleValue.

	self value = 0
		ifTrue: [ 
			button background: (self offColor alpha: 1.0);
			border: (BlBorder paint: (Color darkGray ) width: 4);
			effect: (BlGaussianShadowEffect color: (Color white alpha:0.0)   offset: 0@ 0  width: 10).
			inputLabel text: (self configuredStringDark: inputText ).
	 	] 
		ifFalse: [
			button background: (self buttonColor alpha:1.0);
			border: (BlBorder paint: (self glowColor alpha:0.5) width: 3);
			effect: (BlGaussianShadowEffect color: (self glowColor alpha:1.0)   offset: 0@ 0  width: 20).
			inputLabel text: (self configuredString: inputText ).
		].
]
