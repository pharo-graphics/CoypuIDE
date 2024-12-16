"
I am a single row of the ICStepSequencer. I am connected to a key in the Performance.
If you click on the dice on my right side you randomise the gates in the Sequencer
"
Class {
	#name : 'ICStepSequencerRow',
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
ICStepSequencerRow >> backingSequencer [

^ backingSequencer
]

{ #category : 'accessing' }
ICStepSequencerRow >> backingSequencer: aSequencer [

 backingSequencer := aSequencer 
]

{ #category : 'initialization' }
ICStepSequencerRow >> initialize [

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
ICStepSequencerRow >> initializeSteps [

	1 to: self stepNumber do: [ :i |
		self addChild: (ICButton new
				 isToggleable: true;
				 id: i;
				 callback: [  :v | (Performance uniqueInstance at: self key ) gates at: i put: v];
				 widgetSize: self widgetSize) ]
]

{ #category : 'accessing' }
ICStepSequencerRow >> key [ 
^ key 
]

{ #category : 'accessing' }
ICStepSequencerRow >> key: aSymbol [

	key := aSymbol.
	
	16 rests notes: '60'; to: aSymbol.
	backingSequencer := Performance uniqueInstance at: aSymbol .
]

{ #category : 'accessing' }
ICStepSequencerRow >> stepNumber [

^ stepNumber
]

{ #category : 'accessing' }
ICStepSequencerRow >> stepNumber: anInteger [

	stepNumber := anInteger 
]

{ #category : 'accessing' }
ICStepSequencerRow >> widgetSize [

^ widgetSize
]

{ #category : 'accessing' }
ICStepSequencerRow >> widgetSize: aSize [

	widgetSize := aSize
]
