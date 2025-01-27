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

{ #category : 'action  handling' }
TpIdleMode >> handleSwitchPitchMode [


self machine mode: (TpPitchMode new machine: machine)
]

{ #category : 'action  handling' }
TpIdleMode >> handleSwitchTimeMode [

	self machine mode: (TpTimeMode new machine: self machine )
]
