"
A DSP for testing and previewing ICFaustUIBuilder UIs without libfaust: it records what the widgets send (sent: address -> value) and answers bargraphs from values. destroy stops their polling.
"
Class {
	#name : 'ICFaustStandInDsp',
	#superclass : 'Object',
	#instVars : [
		'sent',
		'values',
		'isInitialized',
		'isMIDI'
	],
	#category : 'CoypuIDE-FaustUI',
	#package : 'CoypuIDE',
	#tag : 'FaustUI'
}

{ #category : 'dsp protocol' }
ICFaustStandInDsp >> destroy [
	"its bargraphs stop polling"

	isInitialized := false
]

{ #category : 'dsp protocol' }
ICFaustStandInDsp >> getValueAtAddress: anAddress [

	^ self values at: anAddress ifAbsent: [ 0 ]
]

{ #category : 'dsp protocol' }
ICFaustStandInDsp >> isInitialized [

	^ isInitialized ifNil: [ true ]
]

{ #category : 'dsp protocol' }
ICFaustStandInDsp >> isMIDI [

	^ isMIDI ifNil: [ false ]
]

{ #category : 'dsp protocol' }
ICFaustStandInDsp >> isMIDI: aBoolean [

	isMIDI := aBoolean
]

{ #category : 'dsp protocol' }
ICFaustStandInDsp >> isNull [

	^ false
]

{ #category : 'dsp protocol' }
ICFaustStandInDsp >> sent [
	"address -> value, in the order the widgets sent them"

	^ sent ifNil: [ sent := OrderedCollection new ]
]

{ #category : 'dsp protocol' }
ICFaustStandInDsp >> setValue: aFloat ofItem: aDictionary [

	self sent add: (aDictionary at: #address) -> aFloat
]

{ #category : 'dsp protocol' }
ICFaustStandInDsp >> values [
	"address -> value answered to bargraphs"

	^ values ifNil: [ values := Dictionary new ]
]
