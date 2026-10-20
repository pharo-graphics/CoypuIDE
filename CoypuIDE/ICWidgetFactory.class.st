Class {
	#name : 'ICWidgetFactory',
	#superclass : 'Object',
	#category : 'CoypuIDE-Panel',
	#package : 'CoypuIDE',
	#tag : 'Panel'
}

{ #category : 'private' }
ICWidgetFactory >> visitSelectorFor: aParameter [
	"Faust's rule: [style:knob] turns hslider, vslider and nentry into a knob."

	(aParameter style = 'knob' and: [ #( 'hslider' 'vslider' 'nentry' ) includes: aParameter type ])
		ifTrue: [ ^ #visitKnob: ].
	^ self visitSelectors
		at: aParameter type
		ifAbsent: [ self error: 'No widget for Faust type ' , aParameter type ]
]

{ #category : 'private' }
ICWidgetFactory >> visitSelectors [

	^ {
		'hslider' -> #visitHorizontalSlider: .
		'vslider' -> #visitVerticalSlider: .
		'nentry' -> #visitNumEntry: .
		'checkbox' -> #visitCheckbox: .
		'button' -> #visitButton: .
		'hbargraph' -> #visitHorizontalBargraph: .
		'vbargraph' -> #visitVerticalBargraph: } asDictionary
]

{ #category : 'private' }
ICWidgetFactory >> widgetFor: aParameter [
	"Faust declares the widget; I only pick the method that builds it."

	^ self perform: (self visitSelectorFor: aParameter) with: aParameter

]
