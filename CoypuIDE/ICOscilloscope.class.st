"
Simple Oscilloscope to visualize Phausto's DSP output
"
Class {
	#name : 'ICOscilloscope',
	#superclass : 'Object',
	#instVars : [
		'sampleData',
		'audioDisplay',
		'dsp',
		'isUpdating'
	],
	#category : 'CoypuIDE-oscilloscope',
	#package : 'CoypuIDE',
	#tag : 'oscilloscope'
}

{ #category : 'accessing' }
ICOscilloscope >> audioDisplay [ 

^ audioDisplay
]

{ #category : 'accessing' }
ICOscilloscope >> dsp [ 

^ dsp
]

{ #category : 'accessing' }
ICOscilloscope >> dsp: aDsp [
]

{ #category : 'initialization' }
ICOscilloscope >> initialize [

	super initialize.
	self initializeSampleData.
	audioDisplay := ICAudioDisplay fromArray: sampleData.

]

{ #category : 'initialization' }
ICOscilloscope >> initializeSampleData [
	sampleData := ( 1 to: 256 ) collect: [ :i | 0 ].
]

{ #category : 'accessing' }
ICOscilloscope >> isUpdating [ 

^ isUpdating
]

{ #category : 'accessing' }
ICOscilloscope >> isUpdating: aBoolean [

	isUpdating := aBoolean
]

{ #category : 'convenience' }
ICOscilloscope >> openInSpace [

	| space |
	"first we build the UI"
	space := BlSpace new title:  'ICOscilloscope'.
	self isUpdating: true.
	space root background: Color black lighter.
	space root addChild: self audioDisplay.
	self audioDisplay
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :evt | space extent: evt target extent ].


	"ADD EVENT HANDLER TO SAFELY TERMINATE EVERY ICVISUALIZER UPDATEVALUE PROCESS"
	space
		addEventHandlerOn: BlSpaceClosedEvent
		do: [ self isUpdating: false ].
	space show.


	^ space
]

{ #category : 'accessing' }
ICOscilloscope >> sampleData [

^ sampleData
]

{ #category : 'as yet unclassified' }
ICOscilloscope >> updateSampleData [

	| buf |
	[
		self isUpdating whileTrue: [
				buf := PhaustoDynamicEngine uniqueInstance getBuffer: self dsp.
				sampleData := buf
					              readArrayOf: FFIFloat32 new
					              until: [ :eachFloat :count | count = 513 ].
				self audioDisplay readArray: sampleData.
				0.06 seconds wait ] ] fork
]
