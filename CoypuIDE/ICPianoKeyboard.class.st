"
I represent a 2 octaves piano. 

### Next step
I should get a call back that it invoked when pressed. 
"
Class {
	#name : 'ICPianoKeyboard',
	#superclass : 'ICPianoKeyboardElement',
	#instVars : [
		'whiteKeyColor',
		'blackKeyColor',
		'whiteNotesArray',
		'startNote',
		'whitenotes',
		'nOctaves',
		'xPositionOfBlackNotes',
		'blacknotes'
	],
	#category : 'CoypuIDE-PianoKeyboard',
	#package : 'CoypuIDE',
	#tag : 'PianoKeyboard'
}

{ #category : 'testing' }
ICPianoKeyboard class >> isDeprecated [
		" Uses ICPianoKeyboardElement instead of ICPianoKeyboard"
		^ true
]
