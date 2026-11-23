Class {
	#name : 'ICFaustUIBuilderTest',
	#superclass : 'TestCase',
	#instVars : [
		'dsp'
	],
	#category : 'CoypuIDE-FaustUI',
	#package : 'CoypuIDE',
	#tag : 'FaustUI'
}

{ #category : 'fixtures' }
ICFaustUIBuilderTest >> annotatedJSON [
	"the JSON of this Faust program (compiled by libfaust on 2026-11-23):
import('stdfaust.lib');
osc = hgroup('[0]osc[tooltip:the oscillator]',
	hslider('[0]wave[style:menu{'sine':0;'saw':1;'square':2}]',1,0,2,1)
	+ hslider('[1]freq[style:knob][unit:Hz][scale:log][tooltip:pitch]',440,50,2000,1)
	+ hslider('[2]g',0.5,0,1,0.01)
	+ vslider('[3]vol[hidden:1]',0.5,0,1,0.01)
	+ nentry('[4]mode[style:radio{'a':0;'b':1}]',0,0,1,1)
	+ hslider('[5]pan[style:slider]',0,-1,1,0.01));
env = vgroup('[1]env', button('[0]gate') + checkbox('[1]on') + hslider('[2]g',0.2,0,1,0.01) : hbargraph('[3]lvl[style:led]',0,1) : vbargraph('[4]out[unit:dB]',-60,0));
bank = hgroup('[2]bank', par(i,10,hslider('k%i',0,0,1,0.01)) :> _);
process = tgroup('synth', osc + env, bank) :> _;"

	^ '{
	"name": "MyApp",
	"filename": "MyApp",
	"inputs": 0,
	"outputs": 1,
	"meta": [ 
		{ "filename": "MyApp" },
		{ "name": "MyApp" }
	],
	"ui": [ 
		{
			"type": "tgroup",
			"label": "synth",
			"items": [ 
				{
					"type": "hgroup",
					"label": "osc",
					"meta": [
						{ "0": "" },
						{ "tooltip": "the oscillator" }
					],
					"items": [ 
						{
							"type": "hslider",
							"label": "wave",
							"shortname": "wave",
							"address": "/synth/osc/wave",
							"meta": [
								{ "0": "" },
								{ "style": "menu{''sine'':0;''saw'':1;''square'':2}" }
							],
							"init": 1,
							"min": 0,
							"max": 2,
							"step": 1
						},
						{
							"type": "hslider",
							"label": "freq",
							"shortname": "freq",
							"address": "/synth/osc/freq",
							"meta": [
								{ "1": "" },
								{ "scale": "log" },
								{ "style": "knob" },
								{ "tooltip": "pitch" },
								{ "unit": "Hz" }
							],
							"init": 440,
							"min": 50,
							"max": 2000,
							"step": 1
						},
						{
							"type": "hslider",
							"label": "g",
							"shortname": "osc_g",
							"address": "/synth/osc/g",
							"meta": [
								{ "2": "" }
							],
							"init": 0.5,
							"min": 0,
							"max": 1,
							"step": 0.01
						},
						{
							"type": "vslider",
							"label": "vol",
							"shortname": "vol",
							"address": "/synth/osc/vol",
							"meta": [
								{ "3": "" },
								{ "hidden": "1" }
							],
							"init": 0.5,
							"min": 0,
							"max": 1,
							"step": 0.01
						},
						{
							"type": "nentry",
							"label": "mode",
							"shortname": "mode",
							"address": "/synth/osc/mode",
							"meta": [
								{ "4": "" },
								{ "style": "radio{''a'':0;''b'':1}" }
							],
							"init": 0,
							"min": 0,
							"max": 1,
							"step": 1
						},
						{
							"type": "hslider",
							"label": "pan",
							"shortname": "pan",
							"address": "/synth/osc/pan",
							"meta": [
								{ "5": "" },
								{ "style": "slider" }
							],
							"init": 0,
							"min": -1,
							"max": 1,
							"step": 0.01
						}
					]
				},
				{
					"type": "vgroup",
					"label": "env",
					"meta": [
						{ "1": "" }
					],
					"items": [ 
						{
							"type": "button",
							"label": "gate",
							"shortname": "gate",
							"address": "/synth/env/gate",
							"meta": [
								{ "0": "" }
							]
						},
						{
							"type": "checkbox",
							"label": "on",
							"shortname": "on",
							"address": "/synth/env/on",
							"meta": [
								{ "1": "" }
							]
						},
						{
							"type": "hslider",
							"label": "g",
							"shortname": "env_g",
							"address": "/synth/env/g",
							"meta": [
								{ "2": "" }
							],
							"init": 0.2,
							"min": 0,
							"max": 1,
							"step": 0.01
						},
						{
							"type": "hbargraph",
							"label": "lvl",
							"shortname": "lvl",
							"address": "/synth/env/lvl",
							"meta": [
								{ "3": "" },
								{ "style": "led" }
							],
							"min": 0,
							"max": 1
						},
						{
							"type": "vbargraph",
							"label": "out",
							"shortname": "out",
							"address": "/synth/env/out",
							"meta": [
								{ "4": "" },
								{ "unit": "dB" }
							],
							"min": -60,
							"max": 0
						}
					]
				},
				{
					"type": "hgroup",
					"label": "bank",
					"meta": [
						{ "2": "" }
					],
					"items": [ 
						{
							"type": "hslider",
							"label": "k0",
							"shortname": "k0",
							"address": "/synth/bank/k0",
							"init": 0,
							"min": 0,
							"max": 1,
							"step": 0.01
						},
						{
							"type": "hslider",
							"label": "k1",
							"shortname": "k1",
							"address": "/synth/bank/k1",
							"init": 0,
							"min": 0,
							"max": 1,
							"step": 0.01
						},
						{
							"type": "hslider",
							"label": "k2",
							"shortname": "k2",
							"address": "/synth/bank/k2",
							"init": 0,
							"min": 0,
							"max": 1,
							"step": 0.01
						},
						{
							"type": "hslider",
							"label": "k3",
							"shortname": "k3",
							"address": "/synth/bank/k3",
							"init": 0,
							"min": 0,
							"max": 1,
							"step": 0.01
						},
						{
							"type": "hslider",
							"label": "k4",
							"shortname": "k4",
							"address": "/synth/bank/k4",
							"init": 0,
							"min": 0,
							"max": 1,
							"step": 0.01
						},
						{
							"type": "hslider",
							"label": "k5",
							"shortname": "k5",
							"address": "/synth/bank/k5",
							"init": 0,
							"min": 0,
							"max": 1,
							"step": 0.01
						},
						{
							"type": "hslider",
							"label": "k6",
							"shortname": "k6",
							"address": "/synth/bank/k6",
							"init": 0,
							"min": 0,
							"max": 1,
							"step": 0.01
						},
						{
							"type": "hslider",
							"label": "k7",
							"shortname": "k7",
							"address": "/synth/bank/k7",
							"init": 0,
							"min": 0,
							"max": 1,
							"step": 0.01
						},
						{
							"type": "hslider",
							"label": "k8",
							"shortname": "k8",
							"address": "/synth/bank/k8",
							"init": 0,
							"min": 0,
							"max": 1,
							"step": 0.01
						},
						{
							"type": "hslider",
							"label": "k9",
							"shortname": "k9",
							"address": "/synth/bank/k9",
							"init": 0,
							"min": 0,
							"max": 1,
							"step": 0.01
						}
					]
				}
			]
		}
	]
}'
]

{ #category : 'helpers' }
ICFaustUIBuilderTest >> builder [

	^ ICFaustUIBuilder json: self annotatedJSON dsp: dsp
]

{ #category : 'helpers' }
ICFaustUIBuilderTest >> flatJSON [
	"a DSP without groups of its own: Faust wraps its widgets in a vgroup named after it"

	^ '{ "ui": [ { "type": "vgroup", "label": "MyApp", "items": [
		{ "type": "hslider", "label": "a", "address": "/MyApp/a", "init": 0, "min": 0, "max": 1, "step": 0.1 },
		{ "type": "hslider", "label": "b", "address": "/MyApp/b", "init": 0, "min": 0, "max": 1, "step": 0.1 },
		{ "type": "button", "label": "c", "address": "/MyApp/c" } ] } ] }'
]

{ #category : 'helpers' }
ICFaustUIBuilderTest >> isWidget: anElement [

	^ #( #ICSlider #ICButton #ICValueDisplay #ICFaustChoice #ICNentry ) anySatisfy: [ :name |
		  anElement isKindOf: (Smalltalk at: name) ]
]

{ #category : 'helpers' }
ICFaustUIBuilderTest >> labelOf: aWidget [

	^ (aWidget isKindOf: ICFader)
		  ifTrue: [ aWidget name ]
		  ifFalse: [ aWidget inputText ]
]

{ #category : 'helpers' }
ICFaustUIBuilderTest >> polyJSON [
	"a MIDI DSP: Faust's poly wrapper, the voice second"

	^ '{ "ui": [ { "type": "vgroup", "label": "Polyphonic", "items": [
		{ "type": "button", "label": "Panic", "address": "/Polyphonic/Panic" },
		{ "type": "vgroup", "label": "Voices", "items": [
			{ "type": "hslider", "label": "freq", "address": "/Polyphonic/Voices/MyApp/freq", "init": 440, "min": 20, "max": 2000, "step": 1 },
			{ "type": "hslider", "label": "cutoff", "address": "/Polyphonic/Voices/MyApp/cutoff", "init": 1000, "min": 20, "max": 5000, "step": 1 } ] } ] } ] }'
]

{ #category : 'running' }
ICFaustUIBuilderTest >> setUp [

	super setUp.
	dsp := ICFaustStandInDsp new
]

{ #category : 'running' }
ICFaustUIBuilderTest >> tearDown [
	"stops the polling of the bargraphs built"

	dsp destroy.
	super tearDown
]

{ #category : 'tests - annotations' }
ICFaustUIBuilderTest >> testBuildingSendsNothing [

	self builder build.
	self assert: dsp sent isEmpty
]

{ #category : 'tests - groups' }
ICFaustUIBuilderTest >> testFlatDspIsOneGridWithoutHeader [

	| b ui |
	b := ICFaustUIBuilder json: self flatJSON dsp: dsp.
	ui := b build.
	self assert: ui childrenCount equals: 1.
	self assert: b grids size equals: 1.
	self assert: ((self widgetsIn: ui) collect: [ :each | self labelOf: each ]) asArray equals: #( 'a' 'b' 'c' )
]

{ #category : 'tests - groups' }
ICFaustUIBuilderTest >> testHgroupLinesUpVgroupStacks [

	| ui |
	ui := self builder build.
	self assert: (ui pages at: 1) layout isHorizontal.
	self assert: (ui pages at: 2) layout isVertical
]

{ #category : 'tests - annotations' }
ICFaustUIBuilderTest >> testHiddenWidgetIsNotShown [

	self assert: (self widgetsLabeled: 'vol' in: self builder build) isEmpty
]

{ #category : 'tests - annotations' }
ICFaustUIBuilderTest >> testLedBargraph [

	| ui |
	ui := self builder build.
	self assert: (self widgetLabeled: 'lvl' in: ui) class equals: ICFaustLed.
	self assert: (self widgetLabeled: 'out' in: ui) class equals: ICValueDisplay
]

{ #category : 'tests - annotations' }
ICFaustUIBuilderTest >> testMenuSendsTheValueOfTheChosenName [

	| wave |
	wave := self widgetLabeled: 'wave' in: self builder build.
	wave selectIndex: 3.
	self assert: dsp sent last equals: '/synth/osc/wave' -> 2
]

{ #category : 'tests - groups' }
ICFaustUIBuilderTest >> testMidiDspStartsAtTheVoice [

	| ui |
	dsp isMIDI: true.
	ui := (ICFaustUIBuilder json: self polyJSON dsp: dsp) build.
	self assert: ((self widgetsIn: ui) collect: [ :each | self labelOf: each ]) asArray equals: #( 'freq' 'cutoff' )
]

{ #category : 'tests - groups' }
ICFaustUIBuilderTest >> testNestedGroupIsFramedUnderItsLabel [

	| json ui inner |
	json := '{ "ui": [ { "type": "vgroup", "label": "MyApp", "items": [
		{ "type": "hgroup", "label": "filter", "meta": [ { "tooltip": "the filter" } ], "items": [
			{ "type": "hslider", "label": "cutoff", "address": "/MyApp/filter/cutoff", "init": 1, "min": 0, "max": 2, "step": 0.1 } ] } ] } ] }'.
	ui := (ICFaustUIBuilder json: json dsp: dsp) build.
	inner := ui children first.
	self assert: inner children first text asString equals: 'filter'.
	self assert: (inner children first userData at: #faustTooltip) equals: 'the filter'.
	self assert: inner children second layout isHorizontal.
	self assert: (self labelOf: (self widgetsIn: inner) first) equals: 'cutoff'
]

{ #category : 'tests - groups' }
ICFaustUIBuilderTest >> testPianoKeyboardTakesFreqAndGate [

	| ui |
	ui := self builder
		      skipsPianoKeys: true;
		      build.
	self assert: (self widgetsLabeled: 'gate' in: ui) isEmpty.
	self deny: (self widgetsLabeled: 'on' in: ui) isEmpty
]

{ #category : 'tests - annotations' }
ICFaustUIBuilderTest >> testSameLabelInTwoGroupsSendsTwoAddresses [

	| knobs |
	knobs := self widgetsLabeled: 'g' in: self builder build.
	self assert: knobs size equals: 2.
	knobs first currentValue: 0.3.
	knobs second currentValue: 0.7.
	self assert: (dsp sent collect: [ :each | each key ]) asArray equals: #( '/synth/osc/g' '/synth/env/g' ).
	self assert: dsp sent first value closeTo: 0.3.
	self assert: dsp sent second value closeTo: 0.7
]

{ #category : 'tests - annotations' }
ICFaustUIBuilderTest >> testScaleAndUnit [

	| freq |
	freq := self widgetLabeled: 'freq' in: self builder build.
	self assert: freq scale equals: #log.
	self assert: freq unit equals: 'Hz'.
	self assert: (freq valueAtPosition: 0.5) closeTo: (50 * 2000) sqrt.
	self assert: (freq currentLabel text asString endsWith: ' Hz')
]

{ #category : 'tests - groups' }
ICFaustUIBuilderTest >> testSelectingATabShowsOnlyItsPage [

	| ui |
	ui := self builder build.
	ui selectTab: 2.
	self assert: ui selectedPage identicalTo: (ui pages at: 2).
	ui pages doWithIndex: [ :page :i | self assert: page visibility isVisible equals: i = 2 ]
]

{ #category : 'tests - annotations' }
ICFaustUIBuilderTest >> testSliderWithoutStyleIsAKnob [

	self assert: (self widgetLabeled: 'g' in: self builder build) class equals: ICFaustKnob
]

{ #category : 'tests - annotations' }
ICFaustUIBuilderTest >> testStyleMenu [

	| wave |
	wave := self widgetLabeled: 'wave' in: self builder build.
	self assert: wave class equals: ICFaustChoice.
	self assert: wave isMenu.
	self assert: (wave choices collect: [ :each | each key ]) asArray equals: #( 'sine' 'saw' 'square' ).
	self assert: wave selectedName equals: 'saw'
]

{ #category : 'tests - annotations' }
ICFaustUIBuilderTest >> testStyleRadio [

	| mode |
	mode := self widgetLabeled: 'mode' in: self builder build.
	self deny: mode isMenu.
	self assert: mode optionElements size equals: 2
]

{ #category : 'tests - annotations' }
ICFaustUIBuilderTest >> testStyleSliderIsAFader [
	"pan is an hslider"

	| pan |
	pan := self widgetLabeled: 'pan' in: self builder build.
	self assert: (pan isKindOf: ICFader).
	self assert: pan isHorizontal
]

{ #category : 'tests - groups' }
ICFaustUIBuilderTest >> testTgroupBecomesTabsInFaustOrder [

	| ui |
	ui := self builder build.
	self assert: ui class equals: ICFaustTabGroup.
	self assert: ui tabLabels asArray equals: #( 'osc' 'env' 'bank' ).
	self assert: ui selectedIndex equals: 1
]

{ #category : 'tests - annotations' }
ICFaustUIBuilderTest >> testTooltips [

	| ui |
	ui := self builder build.
	self assert: ((self widgetLabeled: 'freq' in: ui) userData at: #faustTooltip) equals: 'pitch'.
	self assert: (ui tabs first userData at: #faustTooltip) equals: 'the oscillator'
]

{ #category : 'tests - annotations' }
ICFaustUIBuilderTest >> testVsliderWithStyleSliderIsAVerticalFader [

	| json fader |
	json := '{ "ui": [ { "type": "vgroup", "label": "MyApp", "items": [
		{ "type": "vslider", "label": "vol", "address": "/MyApp/vol", "meta": [ { "style": "slider" } ], "init": 0.5, "min": 0, "max": 1, "step": 0.01 } ] } ] }'.
	fader := self widgetLabeled: 'vol' in: (ICFaustUIBuilder json: json dsp: dsp) build.
	self deny: fader isHorizontal
]

{ #category : 'tests - groups' }
ICFaustUIBuilderTest >> testWidgetsWrapAfterMaxColumns [
	"the bank's 10 knobs: 8 on the first row; with 4 columns the 5th starts the second row"

	| b bankGrid knobs |
	b := self builder.
	b build.
	bankGrid := b grids detect: [ :each | each childrenCount = 10 ].
	knobs := bankGrid children.
	bankGrid forceLayout.
	self assert: (knobs at: 8) position y equals: (knobs at: 1) position y.
	self assert: (knobs at: 9) position y > (knobs at: 1) position y.
	b maxColumns: 4.
	bankGrid
		requestLayout;
		forceLayout.
	self assert: (knobs at: 4) position y equals: (knobs at: 1) position y.
	self assert: (knobs at: 5) position y > (knobs at: 1) position y
]

{ #category : 'helpers' }
ICFaustUIBuilderTest >> widgetLabeled: aString in: anElement [

	^ (self widgetsLabeled: aString in: anElement) first
]

{ #category : 'helpers' }
ICFaustUIBuilderTest >> widgetsIn: anElement [
	"the parameter widgets, in the order of the tree"

	| widgets |
	widgets := OrderedCollection new.
	anElement withAllChildrenBreadthFirstDo: [ :each | (self isWidget: each) ifTrue: [ widgets add: each ] ].
	^ widgets
]

{ #category : 'helpers' }
ICFaustUIBuilderTest >> widgetsLabeled: aString in: anElement [

	^ (self widgetsIn: anElement) select: [ :each | (self labelOf: each) = aString ]
]
