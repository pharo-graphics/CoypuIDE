"
In IdleMode, machine is stopped. Pressing notes on the keyboard makes you hear the note 
"
Class {
	#name : 'TpIdleMode',
	#superclass : 'TpMode',
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'as yet unclassified' }
TpIdleMode >> handleFunctionSwitch [

	'DOING NOTHING WITH FUNCTION SWITCH ' traceCr.
]

{ #category : 'as yet unclassified' }
TpIdleMode >> handleKeyboardNotes [

	self machine notesArray do: [ :key | "callbacks on mouseDown"
		key callbackDown: [
			self machine audioEngine
				setValue:
					(self machine noteNumbers at:
						 (self machine notesArray indexOf: key)) midiNoteToFreq
				parameter: 'AcidNote'.
			self machine audioEngine setValue: 1 parameter: 'AcidGate'.
			"(self machine noteNumbers at:
				 (self machine notesArray indexOf: key)) midiNoteToFreq traceCr" ].

		"On mouseUp"
		key callBackUp: [
			self machine audioEngine setValue: 0 parameter: 'AcidGate' ] ]
]

{ #category : 'action  handling' }
TpIdleMode >> handleNote_0 [

	"do nothing"
]

{ #category : 'action  handling' }
TpIdleMode >> handleNote_100 [

"do nothing"
]

{ #category : 'action  handling' }
TpIdleMode >> handleNote_9 [

	"do nothing"
]

{ #category : 'action  handling' }
TpIdleMode >> handleSwitchPitchMode [

	self machine mode: (TpPitchMode new
			 machine: machine;
			 handleKeyboardNotes).
	self machine note_0 isToggleable: true.
	self machine note_9 isToggleable: true.
]

{ #category : 'action  handling' }
TpIdleMode >> handleSwitchTimeMode [

	self machine mode: (TpTimeMode new machine: self machine).
"	self machine note_0 isToggleable: false.
	self machine note_9 isToggleable: false"
]
