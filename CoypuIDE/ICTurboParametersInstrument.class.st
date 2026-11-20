"
I am an instrument read from the parameters of the ChucK VM (PhuckVM>>globals), for TurboPhuckDisplay: a prefix and the suffixes of its globals (acid: Note, Gate, Gain, Cutoff ...). The prefix is empty for the master section, whose globals have no instrument (masterGain, pitchShift ...).

I answer what ICTurboVoicePanel asks a TurboVoice: name, globals (suffix -> default), uiRanges, uiToggles, uiActions, set:to:. I cannot be sporked: I only know names. The VM cannot be read back, so my defaults come from a table (Note 60, Gain 0.5, Slice -1 ...), else the bottom of the range.
"
Class {
	#name : 'ICTurboParametersInstrument',
	#superclass : 'Object',
	#instVars : [
		'prefix',
		'suffixes',
		'samplesRoot'
	],
	#category : 'CoypuIDE-Turbo',
	#package : 'CoypuIDE',
	#tag : 'Turbo'
}

{ #category : 'instance creation' }
ICTurboParametersInstrument class >> prefix: aString suffixes: aCollection [

	^ self new prefix: aString suffixes: aCollection
]

{ #category : 'accessing' }
ICTurboParametersInstrument >> canSpork [

	^ false
]

{ #category : 'parameters' }
ICTurboParametersInstrument >> defaultFor: aSuffix [
	"the VM cannot be read back: a table, else the bottom of the range"

	^ self defaults at: aSuffix ifAbsent: [ (self uiRanges at: aSuffix ifAbsent: [ #( 0 ) ]) first ]
]

{ #category : 'parameters' }
ICTurboParametersInstrument >> defaults [

	^ Dictionary new
		  at: 'Note' put: 60;
		  at: 'Gate' put: 0;
		  at: 'Gain' put: 0.5;
		  at: 'Slice' put: -1;
		at: 'Tuning' put: 0;
		  at: 'masterGain' put: 0.8;
		  at: 'pitchShift' put: 1;
		  at: 'highpassFreq' put: 20;
		  at: 'performanceBPM' put: 174;
		  yourself
]

{ #category : 'parameters' }
ICTurboParametersInstrument >> globals [
	"suffix -> default, like TurboVoice>>globals"

	| known |
	known := self order select: [ :each | suffixes includes: each ].
	^ known , ((suffixes reject: [ :each | known includes: each ]) sorted: [ :a :b | a asLowercase <= b asLowercase ]) collect: [
		  :each | each -> (self defaultFor: each) ]
]

{ #category : 'accessing' }
ICTurboParametersInstrument >> isMaster [

	^ prefix isEmpty
]

{ #category : 'accessing' }
ICTurboParametersInstrument >> isSporked [

	^ false
]

{ #category : 'accessing' }
ICTurboParametersInstrument >> label [

	^ self name
]

{ #category : 'accessing' }
ICTurboParametersInstrument >> name [

	^ self isMaster
		  ifTrue: [ 'master' ]
		  ifFalse: [ prefix ]
]

{ #category : 'parameters' }
ICTurboParametersInstrument >> order [
	"how the suffixes are shown: the usual ones first, the rest alphabetically"

	^ #( 'Note' 'Gate' 'Gain' 'Index' 'Position' 'Slice' 'Length' 'Reverse' 'masterGain' 'pitchShift' 'highpassFreq' 'performanceBPM' )
]

{ #category : 'parameters' }
ICTurboParametersInstrument >> parameter: aSuffix [

	^ prefix , aSuffix
]

{ #category : 'accessing' }
ICTurboParametersInstrument >> prefix [

	^ prefix
]

{ #category : 'accessing' }
ICTurboParametersInstrument >> prefix: aString suffixes: aCollection [

	prefix := aString.
	suffixes := aCollection asArray
]

{ #category : 'accessing' }
ICTurboParametersInstrument >> samplesRoot [
	"where a sample folder named like me tells the range of my Index"

	^ samplesRoot ifNil: [ TurboPhuckRig default root ]
]

{ #category : 'accessing' }
ICTurboParametersInstrument >> samplesRoot: aFolder [

	samplesRoot := aFolder
]

{ #category : 'parameters' }
ICTurboParametersInstrument >> set: aSuffix to: aNumber [

	PhuckVM uniqueInstance setValue: aNumber parameter: (self parameter: aSuffix)
]

{ #category : 'accessing' }
ICTurboParametersInstrument >> suffixes [

	^ suffixes
]

{ #category : 'ui' }
ICTurboParametersInstrument >> uiActions [

	^ (suffixes includes: 'Slice')
		  ifTrue: [ { ('WHOLE' -> ('Slice' -> -1)) } ]
		  ifFalse: [ #(  ) ]
]

{ #category : 'accessing' }
ICTurboParametersInstrument >> uiKind [

	^ ''
]

{ #category : 'ui' }
ICTurboParametersInstrument >> uiLabelFor: aSuffix [
	"master globals are whole names, too long for a knob"

	^ (Dictionary new
		   at: 'masterGain' put: 'Gain';
		   at: 'pitchShift' put: 'Pitch';
		   at: 'highpassFreq' put: 'HPF';
		   at: 'performanceBPM' put: 'BPM';
		   yourself) at: aSuffix ifAbsent: [ aSuffix ]
]

{ #category : 'ui' }
ICTurboParametersInstrument >> uiRanges [
	"the voices table, the master globals, and Index through the files of a sample folder named like me"

	| ranges folder |
	ranges := TurboVoice new uiRanges.
	ranges
		at: 'masterGain' put: #( 0 1 0.01 );
		at: 'pitchShift' put: #( 0.01 2 0.01 );
		at: 'highpassFreq' put: #( 20 2400 1 );
		at: 'performanceBPM' put: #( 60 200 1 ).
	self isMaster ifTrue: [ ^ ranges ].
	folder := self samplesRoot / prefix.
	folder isDirectory ifTrue: [
			ranges at: 'Index' put: {
					0.
					((ZdSampler folder: folder) audioFiles size - 1 max: 0).
					1 } ].
	^ ranges
]

{ #category : 'ui' }
ICTurboParametersInstrument >> uiToggles [

	^ #( 'Reverse' 'Waveform' ) select: [ :each | suffixes includes: each ]
]
