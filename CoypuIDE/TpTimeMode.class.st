"
While in TimeMode we can insert gates, rests and ties with the buttons in the TimeMode zone.
"
Class {
	#name : 'TpTimeMode',
	#superclass : 'TpMode',
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'action  handling' }
TpTimeMode >> handleSwitchPitchMode [
	"change the state"

	

	self machine mode: (TpPitchMode new machine: machine).
	"switch the UI toggle"
	self machine widget_TimeMode switch toggle.
	"switch the UI led"
	self machine widget_TimeMode  toggle.
]

{ #category : 'action  handling' }
TpTimeMode >> handleSwitchTimeMode [

	self machine mode: (TpIdleMode new machine: self machine)
]
