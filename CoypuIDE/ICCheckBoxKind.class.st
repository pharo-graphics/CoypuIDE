Class {
	#name : 'ICCheckBoxKind',
	#superclass : 'ICControlKind',
	#category : 'CoypuIDE-Panel',
	#package : 'CoypuIDE',
	#tag : 'Panel'
}

{ #category : 'visiting' }
ICCheckBoxKind >> acceptVisitor: aVisitor for: aParameter [

	^ aVisitor visitCheckbox: aParameter
]
