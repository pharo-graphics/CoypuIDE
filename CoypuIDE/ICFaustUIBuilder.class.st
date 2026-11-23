"
Builds a DSP's Bloc UI from its Faust JSON ui tree, keeping Faust's groups and annotations.

Groups: a vgroup stacks its children, an hgroup lines them up, a tgroup shows one per tab (ICFaustTabGroup). Every group but the root is framed under its label. Consecutive widgets share a grid wrapping after maxColumns (8).
Annotations (ICFaustUINode reads them): [style:knob] or none -> ICFaustKnob (Phausto's PhSlider default), [style:slider] -> ICFader, [style:menu{...}] / [style:radio{...}] -> ICFaustChoice, [style:numerical] and nentries -> ICNentry, [style:led] bargraph -> ICFaustLed, [scale:log/exp] and [unit:...] -> ICFaustKnob, [tooltip:...] -> a Toplo tooltip (groups: on their title), [hidden:1] -> not shown, [0] [1]... order -> Faust already sorts the JSON.
Widgets set their parameter by its full address (DSP>>setValue:ofItem:), so same labels in different groups stay distinct.

	(ICFaustUIBuilder forDsp: aDsp) build
	(ICFaustUIBuilder json: aJSONString dsp: ICFaustStandInDsp new) build
"
Class {
	#name : 'ICFaustUIBuilder',
	#superclass : 'Object',
	#instVars : [
		'dsp',
		'rootNode',
		'maxColumns',
		'grids',
		'skipsPianoKeys'
	],
	#category : 'CoypuIDE-FaustUI',
	#package : 'CoypuIDE',
	#tag : 'FaustUI'
}

{ #category : 'instance creation' }
ICFaustUIBuilder class >> forDsp: aDsp [
	"builds aDsp's UI from its Faust JSON, groups and annotations included"

	^ self json: aDsp getJSON dsp: aDsp
]

{ #category : 'instance creation' }
ICFaustUIBuilder class >> json: aJSONString dsp: aDsp [
	"tests give a JSON string and a stand-in DSP (it only receives setValue:ofItem: and, for bargraphs, getValueAtAddress:)"

	^ self new
		  json: aJSONString dsp: aDsp;
		  yourself
]

{ #category : 'building' }
ICFaustUIBuilder >> addTooltip: aStringOrNil to: anElement [
	"[tooltip:...]: the Toplo tooltip manager works on any element through its userData"

	| manager |
	(aStringOrNil isNil or: [ aStringOrNil isEmpty ]) ifTrue: [ ^ anElement ].
	manager := anElement userData at: #tooltipManager ifAbsentPut: [
			           | m |
			           m := ToTooltipManager new.
			           anElement addEventHandler: m.
			           m ].
	manager windowBuilder: [ :win :request |
			win root addChild: ((ToLabel text: aStringOrNil asRopedText)
					 beMultiLine;
					 yourself) ].
	anElement userData at: #faustTooltip put: aStringOrNil.
	^ anElement
]

{ #category : 'building' }
ICFaustUIBuilder >> basicWidgetFor: aNode [
	"sliders are knobs unless [style:slider] (Phausto's PhSlider default); [style:menu/radio{...}] list names; [style:numerical] and nentries are number entries; [style:led] bargraphs are lamps"

	| kind |
	kind := aNode styleKind.
	aNode isContinuous ifTrue: [
			(#( #menu #radio ) includes: kind) ifTrue: [ ^ self choiceFor: aNode ].
			kind = #slider ifTrue: [ ^ self faderFor: aNode ].
			(kind = #numerical or: [ aNode type = 'nentry' and: [ kind ~= #knob ] ]) ifTrue: [
				^ ICNentry fromDictionary: aNode dictionary forDsp: dsp ].
			^ self knobFor: aNode ].
	aNode isBargraph ifTrue: [
			kind = #led ifTrue: [ ^ ICFaustLed fromDictionary: aNode dictionary forDsp: dsp ].
			^ ICValueDisplay fromDictionary: aNode dictionary forDsp: dsp ].
	^ BlElement new fromDictionary: aNode dictionary forDsp: dsp
]

{ #category : 'building' }
ICFaustUIBuilder >> boxFor: aNode [

	| box run flush |
	box := BlElement new
		       layout: ((aNode type = 'hgroup'
				         ifTrue: [ BlLinearLayout horizontal ]
				         ifFalse: [ BlLinearLayout vertical ]) cellSpacing: 6);
		       constraintsDo: [ :c |
				       c horizontal fitContent.
				       c vertical fitContent ];
		       yourself.
	run := OrderedCollection new.
	flush := [
		         run ifNotEmpty: [
				         box addChild: (self gridOf: run).
				         run := OrderedCollection new ] ].
	(aNode items select: [ :each | self shows: each ]) do: [ :each |
			each isGroup
				ifTrue: [
						flush value.
						box addChild: (self elementForGroup: each isRoot: false) ]
				ifFalse: [ run add: (self widgetFor: each) ] ].
	flush value.
	^ box
]

{ #category : 'building' }
ICFaustUIBuilder >> build [
	"the whole UI: the root group, without a header (its label is the DSP's name, already in the window title)"

	grids := OrderedCollection new.
	^ self elementForGroup: rootNode isRoot: true
]

{ #category : 'building' }
ICFaustUIBuilder >> choiceFor: aNode [

	| item |
	item := aNode dictionary.
	^ (ICFaustChoice
		   label: aNode label
		   choices: aNode choices
		   menu: aNode styleKind = #menu
		   callBack: nil)
		  setValue: aNode init;
		  callBack: [ :value | dsp setValue: value ofItem: item ];
		  yourself
]

{ #category : 'accessing' }
ICFaustUIBuilder >> dsp [

	^ dsp
]

{ #category : 'building' }
ICFaustUIBuilder >> elementForGroup: aNode isRoot: aBoolean [
	"a vgroup stacks its children, an hgroup lines them up, a tgroup shows one per tab; consecutive widgets share a grid"

	| content |
	content := aNode type = 'tgroup'
		           ifTrue: [ self tabsFor: aNode ]
		           ifFalse: [ self boxFor: aNode ].
	aBoolean ifTrue: [ ^ content ].
	^ self frame: content titled: aNode label tooltip: aNode tooltip
]

{ #category : 'building' }
ICFaustUIBuilder >> elementForNode: aNode [

	^ aNode isGroup
		  ifTrue: [ self elementForGroup: aNode isRoot: false ]
		  ifFalse: [ self widgetFor: aNode ]
]

{ #category : 'building' }
ICFaustUIBuilder >> faderFor: aNode [
	"[style:slider]: a horizontal fader for an hslider, a vertical one for a vslider"

	| item fader |
	item := aNode dictionary.
	fader := ICFader label: (aNode unit ifNil: [ aNode label ] ifNotNil: [ :u | aNode label , ' (' , u , ')' ]).
	aNode type = 'hslider'
		ifTrue: [ fader beHorizontal ]
		ifFalse: [ fader beVertical ].
	^ fader
		  minValue: aNode min;
		  maxValue: aNode max;
		  stepValue: aNode step;
		  setValue: aNode init;
		  callBack: [ :value | dsp setValue: value ofItem: item ];
		  yourself
]

{ #category : 'building' }
ICFaustUIBuilder >> frame: anElement titled: aString tooltip: aTooltipString [
	"a group: its label above its content, in a thin frame"

	| title frame |
	title := BlTextElement new
		         text: (aString asRopedText
				          fontSize: 14;
				          foreground: Color orange;
				          bold;
				          yourself);
		         padding: (BlInsets
				          top: 2
				          left: 4
				          bottom: 4
				          right: 4);
		         yourself.
	frame := BlElement new
		         layout: BlLinearLayout vertical;
		         constraintsDo: [ :c |
				         c horizontal fitContent.
				         c vertical fitContent ];
		         padding: (BlInsets all: 4);
		         border: (BlBorder paint: Color gray darker width: 1);
		         addChild: title;
		         addChild: anElement;
		         yourself.
	self addTooltip: aTooltipString to: title.
	^ frame
]

{ #category : 'building' }
ICFaustUIBuilder >> gridOf: aCollectionOfWidgets [

	| grid |
	grid := BlElement new
		        layout: (BlGridLayout new
				         columnCount: ((aCollectionOfWidgets size min: self maxColumns) max: 1);
				         cellSpacing: 0);
		        constraintsDo: [ :c |
				        c horizontal fitContent.
				        c vertical fitContent ];
		        background: Color veryVeryDarkGray;
		        addChildren: aCollectionOfWidgets;
		        yourself.
	grids add: grid.
	^ grid
]

{ #category : 'accessing' }
ICFaustUIBuilder >> grids [
	"the grids of widgets built, one per run of widgets in a group"

	^ grids
]

{ #category : 'accessing' }
ICFaustUIBuilder >> json: aJSONString dsp: aDsp [
	"a MIDI (poly) DSP is wrapped in Faust's Polyphonic/Voices groups: its UI is its voice, as DSP>>getUIItems"

	| root |
	dsp := aDsp.
	root := ICFaustUINode on: ((STONJSON fromString: aJSONString) at: #ui) first.
	(aDsp isMIDI and: [ root items size >= 2 ]) ifTrue: [ root := root items at: 2 ].
	rootNode := root.
	grids := OrderedCollection new
]

{ #category : 'building' }
ICFaustUIBuilder >> knobFor: aNode [

	| item |
	item := aNode dictionary.
	^ (ICFaustKnob
		   label: aNode label
		   minValue: aNode min
		   maxValue: aNode max
		   callBack: nil)
		  scale: aNode scale;
		  unit: aNode unit;
		  stepValue: aNode step;
		  setValue: aNode init;
		  callBack: [ :value | dsp setValue: value ofItem: item ];
		  yourself
]

{ #category : 'accessing' }
ICFaustUIBuilder >> maxColumns [
	"a run of widgets in a group wraps after this many"

	^ maxColumns ifNil: [ 8 ]
]

{ #category : 'accessing' }
ICFaustUIBuilder >> maxColumns: anInteger [
	"also re-wraps the grids already built"

	maxColumns := anInteger.
	grids do: [ :each | each layout columnCount: ((each childrenCount min: anInteger) max: 1) ]
]

{ #category : 'accessing' }
ICFaustUIBuilder >> rootNode [

	^ rootNode
]

{ #category : 'building' }
ICFaustUIBuilder >> shows: aNode [
	"hidden widgets and groups, soundfiles and (for the piano keyboard) freq and gate are not shown"

	aNode isHidden ifTrue: [ ^ false ].
	aNode isSoundfile ifTrue: [ ^ false ].
	(self skipsPianoKeys and: [ aNode isGroup not and: [ #( 'freq' 'gate' ) includes: aNode label ] ]) ifTrue: [ ^ false ].
	^ true
]

{ #category : 'accessing' }
ICFaustUIBuilder >> skipsPianoKeys [
	"a DSP played from the piano keyboard has no freq / gate widgets"

	^ skipsPianoKeys ifNil: [ false ]
]

{ #category : 'accessing' }
ICFaustUIBuilder >> skipsPianoKeys: aBoolean [

	skipsPianoKeys := aBoolean
]

{ #category : 'building' }
ICFaustUIBuilder >> tabsFor: aNode [

	| tabsElement |
	tabsElement := ICFaustTabGroup new.
	(aNode items select: [ :each | self shows: each ]) do: [ :each |
			tabsElement addTab: each label page: (each isGroup
					 ifTrue: [ self elementForGroup: each isRoot: true ]
					 ifFalse: [ self gridOf: { (self widgetFor: each) } ]).
			each isGroup ifTrue: [ self addTooltip: each tooltip to: tabsElement tabs last ] ].
	^ tabsElement
]

{ #category : 'building' }
ICFaustUIBuilder >> widgetFor: aNode [
	"one widget, following its annotations, with its tooltip"

	^ self addTooltip: aNode tooltip to: (self basicWidgetFor: aNode)
]
