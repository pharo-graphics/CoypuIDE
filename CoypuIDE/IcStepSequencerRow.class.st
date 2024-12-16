"
I am a single row of the ICStepSequencer. I am connected to a key in the Performance.
If you click on the dice on my right side you randomise the gates in the Sequencer
"
Class {
	#name : 'IcStepSequencerRow',
	#superclass : 'BlElement',
	#instVars : [
		'stepNumber'
	],
	#category : 'CoypuIDE-stepSequencer',
	#package : 'CoypuIDE',
	#tag : 'stepSequencer'
}

{ #category : 'initialization' }
IcStepSequencerRow >> initialize [

	super initialize.
	stepNumber := 16.
	self background: Color orange.
	self layout: BlGridLayout horizontal.
	self constraintsDo: [ :aLayoutConstraints |
		aLayoutConstraints horizontal fitContent.
		aLayoutConstraints vertical fitContent ].
	1 to: self stepNumber do: [ :i |
		self addChild: (ICButton new
				 isToggleable: true;
				 widgetSize: 30 @ 30) ].
			^ self
]

{ #category : 'accessing' }
IcStepSequencerRow >> stepNumber [

^ stepNumber
]

{ #category : 'accessing' }
IcStepSequencerRow >> stepNumber: anInteger [

	stepNumber := anInteger 
]
