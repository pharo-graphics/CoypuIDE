Class {
	#name : 'ICOscilloscopeTest',
	#superclass : 'TestCase',
	#category : 'CoypuIDE-tests',
	#package : 'CoypuIDE',
	#tag : 'tests'
}

{ #category : 'tests' }
ICOscilloscopeTest >> testInitializeSampleData [

	| osci |
	osci := ICOscilloscope new.
	self deny: (osci sampleData allSatisfy: [ :i | i = 0 ]) = false
]
