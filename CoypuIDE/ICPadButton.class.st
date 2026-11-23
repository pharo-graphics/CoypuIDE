"
I am a trigger (or toggle, for a Faust checkbox) shaped like a knob cell of a DSP UI: a square widgetSize cell (160 by default) with the parameter name on top in the knob style and a square pad in the middle that glows while pressed. So buttons line up with ICDarkKnob3 knobs in a grid without leaving holes.

	(ICPadButton label: 'KickTrigger') callback: [ :v | v traceCr ]; openInSpace
"
Class {
	#name : 'ICPadButton',
	#superclass : 'ICLabelButton',
	#category : 'CoypuIDE-button',
	#package : 'CoypuIDE',
	#tag : 'button'
}

{ #category : 'size' }
ICPadButton >> applyButtonSize [
	"pad look from ICLabelButton, then a fixed square size"

	super applyButtonSize.
	button
		padding: BlInsets empty;
		geometry: (BlRoundedRectangleGeometry cornerRadius: self cornerRadius);
		extent: self padSize asPoint
]

{ #category : 'size' }
ICPadButton >> cornerRadius [

	^ self padSize * self cornerRadiusRatio
]

{ #category : 'defaults' }
ICPadButton >> defaultFitsContent [
	"I keep the square size of a knob cell, whatever my label"

	^ false
]

{ #category : 'defaults' }
ICPadButton >> defaultWidgetSize [
	"the size of a knob cell in a DSP UI"

	^ 160 asPoint
]

{ #category : 'size' }
ICPadButton >> fontSize [
	"same size as the knob labels: 12 at the default 160"

	^ (self sizeUnit * 3 / 40 max: 6) rounded
]

{ #category : 'initialization' }
ICPadButton >> initializeButton [
	"the pad: a square centred in my cell"

	self button: (BlElement new
			 background: self offColor;
			 constraintsDo: [ :c |
					 c frame horizontal alignCenter.
					 c frame vertical alignCenter ];
			 yourself).
	self addChild: button
]

{ #category : 'initialization' }
ICPadButton >> initializeLabel [
	"the name sits on top of the cell, like the label of a knob"

	inputLabel ifNil: [
			inputLabel := BlTextElement new
				              constraintsDo: [ :c |
						              c frame horizontal alignCenter.
						              c frame vertical alignTop ];
				              yourself.
			self labelHost addChild: inputLabel ].
	self applyLabelSize
]

{ #category : 'initialization' }
ICPadButton >> initializeWidget [

	self background: self backColor.
	self layout: BlFrameLayout new
]

{ #category : 'accessing' }
ICPadButton >> labelColor [
	"my label is outside the pad, on the panel: always white like the knob labels"

	^ Color white
]

{ #category : 'initialization' }
ICPadButton >> labelHost [

	^ self
]

{ #category : 'defaults' }
ICPadButton >> padRatio [
	"side of the pad relative to my side"

	^ 11 / 20
]

{ #category : 'size' }
ICPadButton >> padSize [

	^ (self sizeUnit * self padRatio) rounded
]

{ #category : 'size' }
ICPadButton >> widgetPadding [
	"same inset as a knob cell (7.5 at 160) so my label lines up with the knob labels"

	^ self sizeUnit * 3 / 64
]
