"
A button with a label.
By default a click button, can become a toggle by sending the message isToggleable: true
"
Class {
	#name : 'ICLabelButton',
	#superclass : 'ICButton',
	#category : 'CoypuIDE-button',
	#package : 'CoypuIDE',
	#tag : 'button'
}

{ #category : 'examples' }
ICLabelButton class >> exampleThreeSizes [

	
	<script>
	| container |
	container := BlElement new
		             layout: (BlGridLayout new
				              columnCount: 3;
				              cellSpacing: 20;
				              yourself);
		             padding: (BlInsets all: 20);
		             background: Color veryVeryDarkGray;
		             constraintsDo: [ :c |
			             c horizontal fitContent.
			             c vertical fitContent ];
		             yourself.

	#( 40 80 160 ) do: [ :each |
		container addChild: (self new
				 inputText: 'MONO';
				 widgetSize: each;
				 yourself) ].

	container openInSpace

]

{ #category : 'instance creation' }
ICLabelButton class >> fromDictionary: aDictionary forDsp: aDsp [

	| paramLabel btn paramLabelAndType |
	paramLabel := (aDictionary at: #address) afterLastSlash .
	"we split the actual label from its type"
	paramLabelAndType := paramLabel splitOn: $~.
	btn := self label: (paramLabelAndType at: 1).
	btn callback: [ :x | aDsp setValue: x ofItem: aDictionary ].
	"if the button is a checkbox"

	paramLabelAndType size > 1 ifTrue: [ btn isToggleable: true ].

	^ btn
]

{ #category : 'accessing' }
ICLabelButton class >> label: aString [
	^ self new label: aString
]

{ #category : 'size' }
ICLabelButton >> applyButtonSize [
	"I hug my label, so my button takes padding and corner radius, not a size."

	button
		geometry: (BlRoundedRectangleGeometry cornerRadius: self cornerRadius);
		padding: (BlInsets all: self widgetPadding);
		border: (BlBorder paint: Color darkGray width: self borderWidth);
		effect: (BlGaussianShadowEffect
				 color: (Color gray alpha: 1.0)
				 offset: 0 @ 0
				 width: self shadowWidth).
	self applyLabelSize
]

{ #category : 'accessing' }
ICLabelButton >> buttonColor [ 
	"^ Color lightGreen ."
	"^Color cyan."
	^ Color yellow.

]

{ #category : 'defaults' }
ICLabelButton >> defaultFitsContent [

^ true
]

{ #category : 'defaults' }
ICLabelButton >> defaultOffColor [
	^ Color veryVeryDarkGray
]

{ #category : 'accessing' }
ICLabelButton >> glowColor [ 
	"^ Color green ."
	"^ Color lightBlue."
	^ Color yellow.

]

{ #category : 'initialization' }
ICLabelButton >> initializeButton [
	self button: (BlElement new
			 background: self offColor;
			 layout: BlFrameLayout new;
			 constraintsDo: [ :c |
				 c horizontal fitContent.
				 c vertical fitContent ];
			 yourself).
	self addChild: button
]

{ #category : 'initialization' }
ICLabelButton >> initializeWidget [
	self background: self backColor.
	self layout: BlGridLayout horizontal

]

{ #category : 'accessing' }
ICLabelButton >> label: aString [
	inputText := aString.
	self initializeLabel
]

{ #category : 'accessing' }
ICLabelButton >> labelColor [
	^ self currentValue = 0
		  ifTrue: [ Color white ]
		  ifFalse: [ Color black ]
]

{ #category : 'evaluating' }
ICLabelButton >> lightDown [
	button
		background: (self buttonColor alpha: 1.0);
		border: (BlBorder paint: (self glowColor alpha: 0.5) width: self glowBorderWidth);
		effect: (BlGaussianShadowEffect
				 color: (self glowColor alpha: 1.0)
				 offset: 0 @ 0
				 width: self glowWidth).
	self applyLabelSize

]

{ #category : 'evaluating' }
ICLabelButton >> lightUp [
	button
		background: (self offColor alpha: 1.0);
		border: (BlBorder paint: Color darkGray width: self borderWidth);
		effect: (BlGaussianShadowEffect
				 color: (Color white alpha: 0.0)
				 offset: 0 @ 0
				 width: self shadowWidth).
	self applyLabelSize

]

{ #category : 'accessing' }
ICLabelButton >> stateText [
	^ inputLabel ifNil: [
		  self currentValue = 0
			  ifTrue: [ 'OFF' ]
			  ifFalse: [ 'ON' ] ]

]

{ #category : 'evaluating' }
ICLabelButton >> toggle [
	self toggleValue.
	self currentValue = 0
		ifTrue: [ self lightUp ]
		ifFalse: [ self lightDown ]
]
