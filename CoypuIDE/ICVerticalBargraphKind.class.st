Class {
	#name : 'ICVerticalBargraphKind',
	#superclass : 'ICSliderKind',
	#category : 'CoypuIDE-Panel',
	#package : 'CoypuIDE',
	#tag : 'Panel'
}

{ #category : 'as yet unclassified' }
ICVerticalBargraphKind class >> classForFaustType: aString [

	^ {
		'hslider' -> ICHorizontalSliderKind.
		'vslider' -> ICVerticalSliderKind.
		'nentry' -> ICNumEntryKind.
		'checkbox' -> ICCheckboxKind.
		'button' -> ICButtonKind.
		'hbargraph' -> ICHorizontalBargraphKind.
		'vbargraph' -> ICVerticalBargraphKind } asDictionary
			at: aString
			ifAbsent: [ self error: 'No widget kind for Faust type ' , aString ]

]

{ #category : 'as yet unclassified' }
ICVerticalBargraphKind class >> forParameter: aParameter [
	"The only place CoypuIDE reads a Faust type. aParameter: a PhParameter."

	^ (self classForFaustType: aParameter type) fromStyle: aParameter style

]

{ #category : 'visiting' }
ICVerticalBargraphKind >> acceptVisitor: aVisitor for: aParameter [

	^ aVisitor visitVerticalBargraph: aParameter
]
