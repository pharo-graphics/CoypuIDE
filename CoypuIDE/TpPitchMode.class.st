"
While in Pitch mode, pressing notes on the keyboard, inserts note in the pattern
Octave and accent can also be changed.
"
Class {
	#name : 'TpPitchMode',
	#superclass : 'TpMode',
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'action  handling' }
TpPitchMode >> handleSwitchPitchMode [


	self machine mode: (TpIdleMode new machine: self machine)
]

{ #category : 'action  handling' }
TpPitchMode >> handleSwitchTimeMode [

	self machine mode: (TpTimeMode new machine: self machine).
	"switch the UI toggle and led"
	self machine widget_PitchMode switch toggle.
	
]
