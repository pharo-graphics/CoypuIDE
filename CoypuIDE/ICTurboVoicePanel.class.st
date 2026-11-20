"
I am the editor of one Turbo voice (a TurboVoice: synth, STK instrument, ZdSampler, ZdLoopPlayer): an ICSimpleKnob per parameter and ICSimpleButtons for its gate and toggles, on a black background. Every change goes to the voice global in the ChucK VM.

```language=Pharo
	(ZdLoopPlayer folder: 'TurboSamples/breaks') display.
	(TurboRig default at: 'acid') display.
```
The voice decides what I show: uiRanges (suffix -> min, max, step) for the knobs, uiToggles for the suffixes shown as toggle buttons, uiActions for extra click buttons. Knobs start at the voice defaults, the values its shred starts with.
"
Class {
	#name : 'ICTurboVoicePanel',
	#superclass : 'Object',
	#instVars : [
		'voice',
		'knobs',
		'space',
		'sender',
		'scale'
	],
	#category : 'CoypuIDE-Turbo',
	#package : 'CoypuIDE',
	#tag : 'Turbo'
}

{ #category : 'instance creation' }
ICTurboVoicePanel class >> on: aTurboVoice [

	^ self new voice: aTurboVoice
]

{ #category : 'building' }
ICTurboVoicePanel >> button: aLabel toggle: aBoolean on: isOn do: aBlock [
	"an ICSimpleButton filling the size its cell gives it; toggle shows the initial state without running the callback"

	| button |
	button := ICSimpleButton label: aLabel.
	button isToggleable: aBoolean.
	button fitsContent: false.
	isOn ifTrue: [ button toggle ].
	button callback: aBlock.
	^ button
]

{ #category : 'building' }
ICTurboVoicePanel >> buttonCells: buttonList perCell: perCell [
	"tile-sized cells, each a column of up to perCell buttons sharing its height"

	| height cells |
	buttonList ifEmpty: [ ^ #(  ) ].
	height := self tileSize - (perCell - 1 * self gap) / perCell.
	buttonList do: [ :each | each widgetSize: self tileSize @ height ].
	cells := OrderedCollection new.
	1 to: buttonList size by: perCell do: [ :start |
			cells add: (BlElement new
					 layout: (BlLinearLayout vertical cellSpacing: self gap);
					 extent: self tileSize asPoint;
					 addChildren: (buttonList copyFrom: start to: (start + perCell - 1 min: buttonList size));
					 yourself) ].
	^ cells asArray
]

{ #category : 'building' }
ICTurboVoicePanel >> buttonNamed: aLabel in: anElement [
	"the button labelled aLabel in an element I built"

	anElement allChildrenBreadthFirstDo: [ :each |
		((each isKindOf: ICSimpleButton) and: [ each inputText = aLabel ]) ifTrue: [ ^ each ] ].
	^ nil
]

{ #category : 'building' }
ICTurboVoicePanel >> buttons [
	"SPORK when the voice can be sporked, TRIG and GATE when it has a gate, then its toggles and actions"

	| list |
	list := OrderedCollection new.
	voice canSpork ifTrue: [
			list add: (self
					 button: 'SPORK'
					 toggle: true
					 on: voice isSporked
					 do: [ :value |
							 value = 1
								 ifTrue: [ voice spork ]
								 ifFalse: [ voice unspork ] ]) ].
	self hasGate ifTrue: [ "held down: the gate is open while the mouse button is"
			list add: (self
					 button: 'TRIG'
					 toggle: false
					 on: false
					 do: [ :value | self send: 'Gate' value: value asFloat ]).
			list add: (self
					 button: 'GATE'
					 toggle: true
					 on: false
					 do: [ :value | self send: 'Gate' value: value asFloat ]) ].
	voice uiToggles do: [ :suffix |
			list add: (self
					 button: suffix asUppercase
					 toggle: true
					 on: (self defaultFor: suffix) > 0
					 do: [ :value | self send: suffix value: value asFloat ]) ].
	voice uiActions do: [ :action |
			list add: (self
					 button: action key
					 toggle: false
					 on: false
					 do: [ :value | value = 1 ifTrue: [ (knobs at: action value key) setValue: action value value ] ]) ].
	^ list
]

{ #category : 'building' }
ICTurboVoicePanel >> buttonsPerCell: buttonCount after: knobCount [
	"spread the buttons over the empty cells of the last knob row (a full row leaves a whole new row),
	2 to 4 to a cell, so a button is never taller than half a tile"

	| free |
	free := self columns - (knobCount \\ self columns).
	^ ((buttonCount / free) ceiling max: 2) min: 4
]

{ #category : 'accessing' }
ICTurboVoicePanel >> columns [

	^ 4
]

{ #category : 'parameters' }
ICTurboVoicePanel >> defaultFor: aSuffix [

	^ (voice globals detect: [ :each | each key = aSuffix ]) value
]

{ #category : 'building' }
ICTurboVoicePanel >> element [
	"title, then one grid: the knobs, and the buttons in the cells after the last knob"

	| knobElements buttonList |
	knobs := OrderedDictionary new.
	knobElements := self knobSuffixes collect: [ :each | self knobFor: each ].
	buttonList := self buttons.
	^ BlElement new
		  background: Color black;
		  padding: (BlInsets all: (self scaled: 20));
		  layout: (BlLinearLayout vertical cellSpacing: (self scaled: 16));
		  constraintsDo: [ :c |
				  c horizontal fitContent.
				  c vertical fitContent ];
		  addChildren: {
				  self title.
				  (self grid:
						   knobElements asArray
						   , (self buttonCells: buttonList perCell: (self buttonsPerCell: buttonList size after: knobElements size))) };
		  yourself
]

{ #category : 'building' }
ICTurboVoicePanel >> gap [

	^ self scaled: 6
]

{ #category : 'building' }
ICTurboVoicePanel >> grid: elements [

	^ BlElement new
		  layout: (BlGridLayout horizontal
				   columnCount: (self columns min: (elements size max: 1));
				   cellSpacing: self gap;
				   yourself);
		  constraintsDo: [ :c |
				  c horizontal fitContent.
				  c vertical fitContent ];
		  addChildren: elements;
		  yourself
]

{ #category : 'building' }
ICTurboVoicePanel >> hasGate [

	^ voice globals anySatisfy: [ :each | each key = 'Gate' ]
]

{ #category : 'building' }
ICTurboVoicePanel >> knobDiameter [

	^ self scaled: ICSimpleKnob defaultDiameter
]

{ #category : 'building' }
ICTurboVoicePanel >> knobFor: aSuffix [
	"the callback goes in last, so placing the knob on its default sends nothing to the VM"

	| range knob |
	range := self rangeFor: aSuffix.
	knob := ICSimpleKnob label: (voice uiLabelFor: aSuffix) minValue: range first maxValue: range second.
	knob diameter: self knobDiameter.
	knob stepValue: range third.
	knob setValue: (self defaultFor: aSuffix).
	knob callBack: [ :value | self send: aSuffix value: value asFloat ].
	knobs at: aSuffix put: knob.
	^ knob
]

{ #category : 'parameters' }
ICTurboVoicePanel >> knobSuffixes [
	"every global of the voice but its gate, its note and its index (the sequencer sets them), its toggles and a range with nothing in it"

	^ (voice globals collect: [ :each | each key ]) reject: [ :each |
			  (#( 'Gate' 'Note' 'Index' ) includes: each) or: [
				  (voice uiToggles includes: each) or: [ (self rangeFor: each) first = (self rangeFor: each) second ] ] ]
]

{ #category : 'accessing' }
ICTurboVoicePanel >> knobs [
	"suffix -> ICSimpleKnob, filled by element"

	^ knobs
]

{ #category : 'opening' }
ICTurboVoicePanel >> open [
	"spork the voice if it can be and is not (silent until a gate opens), then show me in my own window"

	| element |
	(voice canSpork and: [ voice isSporked not ]) ifTrue: [ voice spork ].
	element := self element.
	element forceLayout.
	space := BlSpace new
		         title: voice label;
		         extent: element extent;
		         yourself.
	space root
		background: Color black;
		addChild: element.
	space show.
	^ space
]

{ #category : 'parameters' }
ICTurboVoicePanel >> rangeFor: aSuffix [
	"{ min. max. step }, from the voice or worked out from the default"

	^ voice uiRanges at: aSuffix ifAbsent: [
			  {
				  0.
				  ((self defaultFor: aSuffix) * 2 max: 1).
				  0.01 } ]
]

{ #category : 'accessing' }
ICTurboVoicePanel >> scale [
	"size of everything against the default ICSimpleKnob (1 = 160 pixel tiles)"

	^ scale ifNil: [ 0.4 ]
]

{ #category : 'accessing' }
ICTurboVoicePanel >> scale: aNumber [

	scale := aNumber
]

{ #category : 'accessing' }
ICTurboVoicePanel >> scaled: aNumber [

	^ aNumber * self scale
]

{ #category : 'accessing' }
ICTurboVoicePanel >> send: aSuffix value: aNumber [

	sender ifNil: [ voice set: aSuffix to: aNumber ] ifNotNil: [ sender value: aSuffix value: aNumber ]
]

{ #category : 'accessing' }
ICTurboVoicePanel >> sender: aBlock [
	"[ :suffix :value | ... ] receives every change; tests use it to stay away from the VM"

	sender := aBlock
]

{ #category : 'accessing' }
ICTurboVoicePanel >> space [

	^ space
]

{ #category : 'building' }
ICTurboVoicePanel >> tileSize [
	"a knob tile, square"

	^ self knobDiameter * 8 / 3
]

{ #category : 'building' }
ICTurboVoicePanel >> title [

	| text |
	text := (voice name , '   ' , voice uiKind) asRopedText.
	text
		fontSize: ((self scaled: 44) max: 18);
		foreground: Color white.
	(text from: 1 to: voice name size) bold.
	^ BlTextElement new
		  text: text;
		  yourself
]

{ #category : 'accessing' }
ICTurboVoicePanel >> voice [

	^ voice
]

{ #category : 'accessing' }
ICTurboVoicePanel >> voice: aTurboVoice [

	voice := aTurboVoice
]
