"
Superclass to implement states for the machine following State Design Pattern.
These are our states:
PitchMode: to enter notes into the pattern, nut also slides and accents.
TimeMode: to enter gates, rests, ties
PlayMode: keyboard select different patterns in memory
"
Class {
	#name : 'TpMode',
	#superclass : 'Object',
	#instVars : [
		'machine'
	],
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'as yet unclassified' }
TpMode >> handleFunctionSwitch [

^ self subclassResponsibility 
]

{ #category : 'as yet unclassified' }
TpMode >> handleKeyboardNotes [

^ self subclassResponsibility 
]

{ #category : 'action  handling' }
TpMode >> handleNote_0 [

	^ self subclassResponsibility
]

{ #category : 'action  handling' }
TpMode >> handleNote_100 [

	^ self subclassResponsibility
]

{ #category : 'action  handling' }
TpMode >> handleNote_9 [

	^ self subclassResponsibility
]

{ #category : 'action  handling' }
TpMode >> handleSwitchPitchMode [

	^ self subclassResponsibility
]

{ #category : 'action  handling' }
TpMode >> handleSwitchTimeMode [

^ self subclassResponsibility 
]

{ #category : 'accessing' }
TpMode >> machine [

^ machine 
]

{ #category : 'accessing' }
TpMode >> machine: aTp33 [

machine := aTp33
]
