Class {
	#name : 'ICWidgetFactoryTest',
	#superclass : 'TestCase',
	#category : 'CoypuIDE-tests',
	#package : 'CoypuIDE',
	#tag : 'tests'
}

{ #category : 'as yet unclassified' }
ICWidgetFactoryTest >> fixtureParameters [

	^ (PhParameterSet fromJSON: '{ "ui": [
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
ICWidgetFactoryTest >> testEachControlPicksItsVisitMethod [

	self
		assert: (self fixtureParameters collect: [ :each |
			each shortName -> (ICLinearOnlyFactory new visitSelectorFor: each) ]) asDictionary
		equals: {
			'bypass' -> #visitCheckbox: .
			'cutoff' -> #visitKnob: .
			'gain' -> #visitVerticalSlider: .
			'gate' -> #visitButton: .
			'level' -> #visitHorizontalBargraph: .
			'mix' -> #visitHorizontalSlider: .
			'mode' -> #visitNumEntry: .
			'peak' -> #visitVerticalBargraph: } asDictionary
]
