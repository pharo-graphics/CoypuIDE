"
I am a single row of the ICStepSequencer. I am connected to a key in the Performance.
If you click on the dice on my right side you randomise the gates in the Sequencer
"
Class {
	#name : 'IcStepSequencerRow',
	#superclass : 'BlElement',
	#instVars : [
		'stepNumber',
		'backingSequencer',
		'widgetSize',
		'key'
	],
	#category : 'CoypuIDE-stepSequencer',
	#package : 'CoypuIDE',
	#tag : 'stepSequencer'
}

{ #category : 'accessing' }
IcStepSequencerRow >> backingSequencer [

^ backingSequencer
]

{ #category : 'accessing' }
IcStepSequencerRow >> backingSequencer: aSequencer [

 backingSequencer := aSequencer 
]

{ #category : 'initialization' }
IcStepSequencerRow >> initialize [

	super initialize.
	stepNumber := 16.
	self background: Color orange.
	self layout: BlGridLayout horizontal.
	self constraintsDo: [ :aLayoutConstraints |
		aLayoutConstraints horizontal fitContent.
		aLayoutConstraints vertical fitContent ].
	self initializeSteps.
	
	^ self
]

{ #category : 'initialization' }
IcStepSequencerRow >> initializeSteps [

	1 to: self stepNumber do: [ :i |
		self addChild: (ICButton new
				 isToggleable: true;
				 id: i;
				 callback: [  :v | (Performance uniqueInstance at: self key ) gates at: i put: v];
				 widgetSize: self widgetSize) ]
]

{ #category : 'accessing' }
IcStepSequencerRow >> key [ 
^ key 
]

{ #category : 'accessing' }
IcStepSequencerRow >> key: aSymbol [

	key := aSymbol.
	
	16 rests notes: '60'; to: aSymbol.
	backingSequencer := Performance uniqueInstance at: aSymbol .
]

{ #category : 'accessing' }
IcStepSequencerRow >> stepNumber [

^ stepNumber
]

{ #category : 'accessing' }
IcStepSequencerRow >> stepNumber: anInteger [

	stepNumber := anInteger 
]

{ #category : 'accessing' }
IcStepSequencerRow >> widgetSize [

^ widgetSize
]

{ #category : 'accessing' }
IcStepSequencerRow >> widgetSize: aSize [

	widgetSize := aSize
]
