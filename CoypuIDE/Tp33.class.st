"
I am the virtual Tp33 Bass Line connected to the Acid sound from TurboPhausto
"
Class {
	#name : 'Tp33',
	#superclass : 'Tp33_OnlyUI',
	#instVars : [
		'audioEngine',
		'notesArray'
	],
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'accessing' }
Tp33 >> audioEngine [

	^ audioEngine
]

{ #category : 'accessing' }
Tp33 >> audioEngine: aDsp [

	audioEngine := aDsp
]

{ #category : 'initialization' }
Tp33 >> initalizeNotesArray [

	notesArray := Array new: 13.
	notesArray
		at: 1 put: self note_C;
		at: 2 put: self note_CSharp;
		at: 3 put: self note_D;
		at: 4 put: self note_DSharp; 
		at: 5 put: self note_E;
		at: 6 put: self note_F;
		at: 7 put: self note_FSharp;
		at: 8 put: self note_G; 
		at: 9 put: self note_GSharp; 
		at: 10 put: self note_A;
		at: 11 put: self note_ASharp;
		at: 12 put: self note_B;
		at: 13 put: self note_C1 . 
]

{ #category : 'initialization' }
Tp33 >> initializeNotesCallbacks [

^ self shouldBeImplemented 
]

{ #category : 'instance creation' }
Tp33 >> newWithDsp: aDsp [

audioEngine := aDsp.
self initialize.
]

{ #category : 'accessing' }
Tp33 >> notesArray [

	^ notesArray
]

{ #category : 'accessing' }
Tp33 >> notesArray: anArrayOfBlElements [

	notesArray := anArrayOfBlElements 
]
