"
While in TimeMode we can insert gates, rests and ties with the buttons in the TimeMode zone.
"
Class {
	#name : 'TpTimeMode',
	#superclass : 'TpMode',
	#instVars : [
		'tempGatesPattern',
		'tempGatesPatternIndex'
	],
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'as yet unclassified' }
TpTimeMode >> handleFunctionSwitch [

(Performance uniqueInstance at: #Acid) gates: self tempGatesPattern asArray .

"switch the UI toggle"
	self machine widget_TimeMode switch toggle.
	"switch the UI led"
	self machine widget_TimeMode indicator toggle
]

{ #category : 'action  handling' }
TpTimeMode >> handleNote_100 [
	"note_9 insert a gate"

	self tempGatesPattern add: 0.
	tempGatesPatternIndex := self tempGatesPatternIndex + 1.
	
]

{ #category : 'action  handling' }
TpTimeMode >> handleNote_9 [
	"note_9 insert a gate"

	self tempGatesPattern add: 1.
tempGatesPatternIndex := self tempGatesPatternIndex + 1
]

{ #category : 'action  handling' }
TpTimeMode >> handleSwitchPitchMode [
	"change the state"

	self machine mode: (TpPitchMode new machine: machine; handleKeyboardNotes).
	"switch the UI toggle"
	self machine widget_TimeMode switch toggle.
	"switch the UI led"
	self machine widget_TimeMode toggle
]

{ #category : 'action  handling' }
TpTimeMode >> handleSwitchTimeMode [

  
	self machine mode: (TpIdleMode new machine: self machine).
	tempGatesPattern := OrderedCollection new.
	tempGatesPatternIndex := 1.
	
]

{ #category : 'initialization' }
TpTimeMode >> initialize [

	tempGatesPattern := OrderedCollection new.
	tempGatesPatternIndex := 1
]

{ #category : 'accessing' }
TpTimeMode >> tempGatesPattern [

	^ tempGatesPattern
]

{ #category : 'accessing' }
TpTimeMode >> tempGatesPatternIndex [

	^ tempGatesPatternIndex
]
