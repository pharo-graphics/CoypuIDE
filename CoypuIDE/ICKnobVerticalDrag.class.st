Class {
	#name : 'ICKnobVerticalDrag',
	#superclass : 'BlElement',
	#category : 'CoypuIDE-knob',
	#package : 'CoypuIDE',
	#tag : 'knob'
}

{ #category : 'examples' }
ICKnobVerticalDrag class >> basicExample [

	<script>
	| knob |
	knob := self new position: 100 @ 100.

	knob openInSpace

	"knob callBack: [ :v | v inspect ]"
]

{ #category : 'initialization' }
ICKnobVerticalDrag >> initializeEvents [

	| valueAtOrigin dragOrigin|
	self addEventHandlerOn: BlKeyDownEvent do: [ :e |
		e key name = #LEFT ifTrue: [ self angle: self angle - 15 ].
		e key name = #RIGHT ifTrue: [ self angle: self angle + 15 ] ].
	self
		addEventHandlerOn: BlClickEvent
		do: [ :e | self clickAt: e position ].
	self addEventHandlerOn: BlDragStartEvent do: [ :event |
		event consumed: true.
		dragOrigin := event position.
		self clickAt: event position.
		valueAtOrigin := self currentValue ].
	self addEventHandlerOn: BlDragEvent do: [ :event |
		| offset |
		offset := event position y - dragOrigin y.
		self setValue: valueAtOrigin - offset ].
	self requestFocus
]
