"
I am the widget a Faust control declares: _hslider_, _vslider_, _nentry_, _knob ([style:knob])_, _checkbox_, _button_, _hbargraph_ or _vbargraph_. 
**forParameter:** resolves me from the type and style of a PhParameter, once, when an ICParameter is created; it is the only place CoypuIDE reads a Faust type.

**acceptVisitor:for:** sends one of **visitHorizontalSlider:**, **visitVerticalSlider:**, **visitNumEntry:**, **visitKnob:**, **visitCheckbox:**, **visitButton:**, **visitHorizontalBargraph:**, **visitVerticalBargraph:**.

Pattern: Replace Type Code with Subclasses, and the element side of a Visitor whose visitors are the ICWidgetFactory subclasses.'.

"
Class {
	#name : 'ICControlKind',
	#superclass : 'Object',
	#category : 'CoypuIDE-Panel',
	#package : 'CoypuIDE',
	#tag : 'Panel'
}

{ #category : 'as yet unclassified' }
ICControlKind class >> classForFaustType: aString [

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

{ #category : 'instance creation' }
ICControlKind class >> fromStyle: aString [
	"Most kinds ignore the style."

	^ self new
]

{ #category : 'instance creation' }
ICControlKind >> acceptVisitor: aVisitor for: aParameter [

	^ self subclassResponsibility

]

{ #category : 'as yet unclassified' }
ICControlKind >> classForFaustType: aString [

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
ICControlKind >> forParameter: aParameter [
	"The only place CoypuIDE reads a Faust type. aParameter: a PhParameter."

	^ (self classForFaustType: aParameter type) fromStyle: aParameter style
]
