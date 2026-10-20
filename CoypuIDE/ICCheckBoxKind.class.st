"
I am a Faust _checkbox_, a latching toggle. JUCE: ToggleButton with a ButtonAttachment.

"
Class {
	#name : 'ICCheckboxKind',
	#superclass : 'ICControlKind',
	#category : 'CoypuIDE-Panel',
	#package : 'CoypuIDE',
	#tag : 'Panel'
}

{ #category : 'visiting' }
ICCheckboxKind >> acceptVisitor: aVisitor for: aParameter [

	^ aVisitor visitCheckbox: aParameter
]
