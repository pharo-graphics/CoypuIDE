Class {
	#name : 'ICKnobTest',
	#superclass : 'TestCase',
	#category : 'CoypuIDE-tests',
	#package : 'CoypuIDE',
	#tag : 'tests'
}

{ #category : 'tests' }
ICKnobTest >> testForMidi [ 

| knob |
knob := (ICKnob label: 'MidiControl') forMidi.

self assert: knob minValue equals: 0.
self assert: knob maxValue equals: 127.
self assert: knob stepValue equals: 1.
]
