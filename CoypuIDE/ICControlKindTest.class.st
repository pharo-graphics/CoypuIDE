Class {
	#name : 'ICControlKindTest',
	#superclass : 'TestCase',
	#category : 'CoypuIDE-tests',
	#package : 'CoypuIDE',
	#tag : 'tests'
}

{ #category : 'as yet unclassified' }
ICControlKindTest >> fixtureParameters [

	^ ICParameter onAll: (PhParameterSet fromJSON: '{ "ui": [
		{ "type": "hslider", "label": "mix", "shortname": "mix", "address": "/mix" },
		{ "type": "hslider", "label": "cutoff", "shortname": "cutoff", "address": "/cutoff", "meta": [ { "style": "knob" } ] },
		{ "type": "vslider", "label": "gain", "shortname": "gain", "address": "/gain" },
		{ "type": "nentry", "label": "mode", "shortname": "mode", "address": "/mode" },
		{ "type": "checkbox", "label": "bypass", "shortname": "bypass", "address": "/bypass" },
		{ "type": "button", "label": "gate", "shortname": "gate", "address": "/gate" },
		{ "type": "hbargraph", "label": "level", "shortname": "level", "address": "/level" },
		{ "type": "vbargraph", "label": "peak", "shortname": "peak", "address": "/peak" } ] }') parameters

]

{ #category : 'tests' }
ICControlKindTest >> testEachKindDispatchesToItsVisitMethod [
	"Self Shunt: the test case is the visitor."

	self
		assert: (self fixtureParameters collect: [ :each |
			each shortName -> (each acceptVisitor: self) ]) asDictionary
		equals: {
			'bypass' -> #checkbox.
			'cutoff' -> #knob.
			'gain' -> #verticalSlider.
			'gate' -> #button.
			'level' -> #horizontalBargraph.
			'mix' -> #horizontalSlider.
			'mode' -> #numEntry.
			'peak' -> #verticalBargraph } asDictionary

]

{ #category : 'visiting' }
ICControlKindTest >> visitButton: aParameter [
	^ #button

]

{ #category : 'visiting' }
ICControlKindTest >> visitCheckbox: aParameter [
	^ #checkbox

]

{ #category : 'visiting' }
ICControlKindTest >> visitHorizontalBargraph: aParameter [
	^ #horizontalBargraph
]

{ #category : 'visiting' }
ICControlKindTest >> visitHorizontalSlider: aParameter [
	^ #horizontalSlider

]

{ #category : 'visiting' }
ICControlKindTest >> visitKnob: aParameter [
	^ #knob
]

{ #category : 'visiting' }
ICControlKindTest >> visitNumEntry: aParameter [
	^ #numEntry

]

{ #category : 'visiting' }
ICControlKindTest >> visitVerticalBargraph: aParameter [
	^ #verticalBargraph
]

{ #category : 'visiting' }
ICControlKindTest >> visitVerticalSlider: aParameter [
	^ #verticalSlider

]
