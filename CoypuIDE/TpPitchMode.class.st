"
While in Pitch mode, pressing notes on the keyboard, inserts note in the pattern
Octave and accent can also be changed.
"
Class {
	#name : 'TpPitchMode',
	#superclass : 'TpMode',
	#instVars : [
		'tempNotesPattern',
		'tempNotesPatternIndex'
	],
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'as yet unclassified' }
TpPitchMode >> handleFunctionSwitch [

	(Performance uniqueInstance at: #Acid) notes: self tempNotesPattern asArray
]

{ #category : 'action  handling' }
TpPitchMode >> handleKeyboardNotes [

	self machine notesArray do: [ :key | "callbacks on mouseDown"
		key callbackDown: [
			self machine audioEngine
				setValue:
					(self machine noteNumbers at:
						 (self machine notesArray indexOf: key)) midiNoteToFreq
				parameter: 'AcidNote'.
			self machine audioEngine setValue: 1 parameter: 'AcidGate'.
			(self machine noteNumbers at:
				 (self machine notesArray indexOf: key)) traceCr .
				"add notes to temporary pattern"
				self tempNotesPattern add: (self machine noteNumbers at: (self machine notesArray indexOf: key)).
				"increment index"
				tempNotesPatternIndex :=  self tempNotesPatternIndex + 1.
				tempNotesPattern asString traceCr .
				
				].

		"On mouseUp"
		key callBackUp: [
			self machine audioEngine setValue: 0 parameter: 'AcidGate' ] ]
]

{ #category : 'action  handling' }
TpPitchMode >> handleSwitchPitchMode [


	self machine mode: (TpIdleMode new machine: self machine)
]

{ #category : 'action  handling' }
TpPitchMode >> handleSwitchTimeMode [

	self machine mode: (TpTimeMode new machine: self machine).
	"switch the UI toggle"
	self machine widget_PitchMode switch toggle.
	"switch the UI led"
	self machine widget_PitchMode indicator toggle.
]

{ #category : 'initialization' }
TpPitchMode >> initialize [

	tempNotesPattern := OrderedCollection new.
	tempNotesPatternIndex := 1
]

{ #category : 'accessing' }
TpPitchMode >> tempNotesPattern [

	^ tempNotesPattern
]

{ #category : 'accessing' }
TpPitchMode >> tempNotesPatternIndex [

	^ tempNotesPatternIndex
]
