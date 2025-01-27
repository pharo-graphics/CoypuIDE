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
TpTimeMode >> handleSwitchTimeMode [

	self machine mode: (TpIdleMode new machine: self machine)
]