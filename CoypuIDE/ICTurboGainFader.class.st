"
I am the fader of TurboPhuck>>displayUIForGains: an ICMixerFader without min/max labels, fonts 15% bigger at the same width, whose name turns yellow when my instrument is in the Performance (highlighted: true).
"
Class {
	#name : 'ICTurboGainFader',
	#superclass : 'ICMixerFader',
	#instVars : [
		'highlighted'
	],
	#category : 'CoypuIDE-Turbo',
	#package : 'CoypuIDE',
	#tag : 'Turbo'
}

{ #category : 'accessing' }
ICTurboGainFader >> fontSize [
	"15% bigger than an ICMixerFader of my thickness"

	^ super fontSize * 1.15
]

{ #category : 'accessing' }
ICTurboGainFader >> highlighted [

	^ highlighted ifNil: [ false ]
]

{ #category : 'accessing' }
ICTurboGainFader >> highlighted: aBoolean [
	"yellow name when my instrument plays in the Performance, white otherwise"

	aBoolean = self highlighted ifTrue: [ ^ self ].
	highlighted := aBoolean.
	label text: (self labelText: self name color: self labelColor)
]

{ #category : 'accessing' }
ICTurboGainFader >> initializeValueLabels [
	"no min/max labels, only the value on the handle"

	super initializeValueLabels.
	minLabel visibility: BlVisibility gone.
	maxLabel visibility: BlVisibility gone
]

{ #category : 'accessing' }
ICTurboGainFader >> labelColor [

	^ self highlighted
		  ifTrue: [ Color yellow ]
		  ifFalse: [ Color white ]
]

{ #category : 'accessing' }
ICTurboGainFader >> labelColumnWidth [
	"the bigger font must not make me wider"

	^ super labelColumnWidth / 1.15
]
