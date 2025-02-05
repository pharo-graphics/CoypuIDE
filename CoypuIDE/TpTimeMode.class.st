"
While in TimeMode we can insert gates, rests and ties with the buttons in the TimeMode zone.
"
Class {
	#name : 'TpTimeMode',
	#superclass : 'TpMode',
	#instVars : [
		'tempGatesPattern',
		'tempGatesPatternIndex',
		'tempGateTimesPattern'
	],
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'action  handling' }
TpTimeMode >> handleFunctionSwitch [

	(Performance uniqueInstance at: #Acid)
		gates: self tempGatesPattern asArray;
		gateTimes: self tempGateTimesPattern asArray.
self machine mode: (TpIdleMode new machine: self machine).
	"switch the UI toggle"
	self machine widget_TimeMode switch toggle.
	"switch the UI led"
	self machine widget_TimeMode indicator toggle
]

{ #category : 'as yet unclassified' }
TpTimeMode >> handleKeyboardNotes [

	"do nothoing"
]

{ #category : 'action  handling' }
TpTimeMode >> handleNote_0 [
	"note_0 insert a tie, it means, it modfies the previous gateTime to 1 and increment the index into the tempGatesOatternIndex"

	| currentStep previousStep  |
	
	currentStep := self tempGatesPatternIndex.
	previousStep := currentStep - 1.
	self tempGateTimesPattern add: 1.
	tempGatesPatternIndex := currentStep + 1
]

{ #category : 'action  handling' }
TpTimeMode >> handleNote_100 [
	"note_9 insert a gate with 80% gateTime"

	self tempGatesPattern add: 0.
	self tempGateTimesPattern add: 0.8.
	tempGatesPatternIndex := self tempGatesPatternIndex + 1
]

{ #category : 'action  handling' }
TpTimeMode >> handleNote_9 [
	"note_9 insert a gate"

	self tempGatesPattern add: 1.
	self tempGateTimesPattern add: 0.8.
	tempGatesPatternIndex := self tempGatesPatternIndex + 1
]

{ #category : 'action  handling' }
TpTimeMode >> handleSwitchPitchMode [
	"change the state"

	self machine mode: (TpPitchMode new
			 machine: machine;
			 handleKeyboardNotes).
	"switch the UI toggle"
	self machine widget_TimeMode switch toggle.
	"switch the UI led"
	self machine widget_TimeMode toggle.
	self machine note_0 isToggleable: true.
	self machine note_9 isToggleable: true.
	

]

{ #category : 'action  handling' }
TpTimeMode >> handleSwitchTimeMode [

	self machine mode: (TpIdleMode new machine: self machine).
	tempGatesPattern := OrderedCollection new.
	tempGatesPatternIndex := 1.
	self machine note_0 isToggleable: false.
	self machine note_9 isToggleable: false.

]

{ #category : 'initialization' }
TpTimeMode >> initialize [

	tempGatesPattern := OrderedCollection new.
tempGateTimesPattern := OrderedCollection new.
	tempGatesPatternIndex := 1
]

{ #category : 'accessing' }
TpTimeMode >> tempGateTimesPattern [

	^ tempGateTimesPattern
]

{ #category : 'accessing' }
TpTimeMode >> tempGatesPattern [

	^ tempGatesPattern
]

{ #category : 'accessing' }
TpTimeMode >> tempGatesPatternIndex [

	^ tempGatesPatternIndex
]
