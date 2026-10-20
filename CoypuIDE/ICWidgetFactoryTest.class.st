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
ICWidgetFactoryTest >> testDescriptorRowsCarryTheExportDefaults [
	"The rows PhaustoParams.h gets for a toggle and a slider."

	self
		assert: (DSP new apvtsDescriptorRowFor: (self parameterNamed: 'gate'))
		equals: '        { "gate", "/fx/gate", "gate", 0.0f, 1.0f, 0.0f, 0.01f, true },';
		assert: (DSP new apvtsDescriptorRowFor: (self parameterNamed: 'cutoff'))
		equals: '        { "cutoff", "/fx/cutoff", "cutoff", 20.0f, 20000.0f, 1000.0f, 1.0f, false },'
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
