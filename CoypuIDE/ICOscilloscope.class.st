"
Simple Oscilloscope to visualize Phausto's DSP output
"
Class {
	#name : 'ICOscilloscope',
	#superclass : 'Object',
	#instVars : [
		'sampleData'
	],
	#category : 'CoypuIDE-oscilloscope',
	#package : 'CoypuIDE',
	#tag : 'oscilloscope'
}

{ #category : 'initialization' }
ICOscilloscope >> initialize [ 

super initialize .
self initializeSampleData .
]

{ #category : 'initialization' }
ICOscilloscope >> initializeSampleData [
	sampleData := ( 1 to: 256 ) collect: [ :i | 0 ].
]

{ #category : 'accessing' }
ICOscilloscope >> sampleData [

^ sampleData
]
