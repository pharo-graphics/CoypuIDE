"
I am an ICStepSequencer. I am used to edit Sequencers inside a Performance in a Time Unit Box System
https://en.wikipedia.org/wiki/Time_unit_box_system
I can contain many ICStepSequencerRows each one of them is connected to a key(hence a Sequencer in the uique instance of the Performance class).

"
Class {
	#name : 'ICStepSequencer',
	#superclass : 'BlElement',
	#instVars : [
		'instruments'
	],
	#category : 'CoypuIDE-stepSequencer',
	#package : 'CoypuIDE',
	#tag : 'stepSequencer'
}

{ #category : 'initialization' }
ICStepSequencer >> initialize [

	super initialize.
	self background: Color orange.
	self layout: BlGridLayout vertical
]

{ #category : 'accessing' }
ICStepSequencer >> instruments [

^ instruments
]

{ #category : 'accessing' }
ICStepSequencer >> instruments: anArrayOfSymbols [

	instruments := anArrayOfSymbols.
	anArrayOfSymbols do: [ :inst |
		self layout columnCount: instruments size.
		self addChild: (ICStepSequencerRow new key: inst).

		self constraintsDo: [ :aLayoutConstraints |
			aLayoutConstraints horizontal fitContent.
			aLayoutConstraints vertical fitContent ] ]
]
