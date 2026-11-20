"
I show every instrument of the ChucK VM in one scrollable window, each as an ICTurboVoicePanel (ICSimpleKnob per parameter, ICSimpleButtons), master section first, on black.

```language=Pharo
	TurboPhuckDisplay open.
	TurboPhuckDisplay new columns: 2; scale: 0.5; open.
```
For now I read the parameters of the VM (PhuckVM>>globals): every <name>Gate global is an instrument, its other globals are <name> + a capitalized suffix (the longest name wins: kick99Note belongs to kick99, not kick). Later I will read the instruments themselves (TurboRig voices), which know their real defaults and can be sporked.
"
Class {
	#name : 'TurboPhuckDisplay',
	#superclass : 'Object',
	#instVars : [
		'parameters',
		'instruments',
		'space',
		'sender',
		'scale',
		'columns'
	],
	#category : 'CoypuIDE-Turbo',
	#package : 'CoypuIDE',
	#tag : 'Turbo'
}

{ #category : 'instance creation' }
TurboPhuckDisplay class >> on: aParameterDictionary [
	"name -> type, like PhuckVM>>globals"

	^ self new parameters: aParameterDictionary
]

{ #category : 'instance creation' }
TurboPhuckDisplay class >> open [

	^ self new open
]

{ #category : 'instruments' }
TurboPhuckDisplay >> buildInstruments [

	| names groups master |
	names := self instrumentNames.
	groups := Dictionary new.
	master := OrderedCollection new.
	self parameters keysDo: [ :each |
			(self instrumentOf: each among: names)
				ifNil: [ master add: each ]
				ifNotNil: [ :instrument |
				(groups at: instrument ifAbsentPut: [ OrderedCollection new ]) add: (each allButFirst: instrument size) ] ].
	^ (master ifEmpty: [ #(  ) ] ifNotEmpty: [ { (ICTurboParametersInstrument prefix: '' suffixes: master) } ])
	  , ((groups keys sorted: [ :a :b | a asLowercase <= b asLowercase ]) collect: [ :each |
			   ICTurboParametersInstrument prefix: each suffixes: (groups at: each) ]) asArray
]

{ #category : 'building' }
TurboPhuckDisplay >> columnOf: somePanelElements [

	^ BlElement new
		  layout: BlLinearLayout vertical;
		  constraintsDo: [ :c |
				  c horizontal fitContent.
				  c vertical fitContent ];
		  addChildren: somePanelElements;
		  yourself
]

{ #category : 'accessing' }
TurboPhuckDisplay >> columns [
	"instrument panels per row"

	^ columns ifNil: [ 3 ]
]

{ #category : 'accessing' }
TurboPhuckDisplay >> columns: anInteger [

	columns := anInteger
]

{ #category : 'building' }
TurboPhuckDisplay >> element [
	"every instrument panel on black, in columns that each stack their panels with no gap to wait for a taller neighbour;
	panels are dealt left to right, so the order still reads row by row"

	| panelElements columnCount |
	self instruments ifEmpty: [ ^ self emptyElement ].
	panelElements := self panels collect: [ :each | each element ].
	columnCount := self columns min: panelElements size.
	^ BlElement new
		  background: Color black;
		  layout: BlLinearLayout horizontal;
		  constraintsDo: [ :c |
				  c horizontal fitContent.
				  c vertical fitContent ];
		  addChildren: ((1 to: columnCount) collect: [ :column |
					   self columnOf: (panelElements withIndexSelect: [ :each :index | index - 1 \\ columnCount + 1 = column ]) ]);
		  yourself
]

{ #category : 'building' }
TurboPhuckDisplay >> emptyElement [

	| text |
	text := 'No parameters in the VM yet: TurboRig start, or spork a voice' asRopedText.
	text
		fontSize: 12;
		foreground: Color white.
	^ BlTextElement new
		  text: text;
		  padding: (BlInsets all: 20);
		  yourself
]

{ #category : 'instruments' }
TurboPhuckDisplay >> instrumentNames [
	"every <name>Gate global is an instrument"

	^ (self parameters keys select: [ :each | (each endsWith: 'Gate') and: [ each size > 4 ] ]) collect: [ :each |
		  each allButLast: 4 ]
]

{ #category : 'instruments' }
TurboPhuckDisplay >> instrumentOf: aParameterName among: names [
	"the longest name that is aParameterName minus a capitalized suffix, nil for the master section"

	| matches |
	matches := names select: [ :each |
		           aParameterName size > each size and: [
			           (aParameterName beginsWith: each) and: [ (aParameterName at: each size + 1) isUppercase ] ] ].
	^ matches ifEmpty: [ nil ] ifNotEmpty: [ matches detectMax: [ :each | each size ] ]
]

{ #category : 'instruments' }
TurboPhuckDisplay >> instruments [
	"the master section (globals of no instrument) first, then the instruments alphabetically"

	^ instruments ifNil: [ instruments := self buildInstruments ]
]

{ #category : 'opening' }
TurboPhuckDisplay >> open [
	"a window as wide as the panels, at most 900 high, scrolling the rest"

	| content scroller |
	content := self element.
	content forceLayout.
	scroller := content asScrollableElement.
	scroller constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
	space := BlSpace new
		         title: 'TurboPhuck';
		         extent: content extent x @ (content extent y min: 900);
		         yourself.
	space root
		background: Color black;
		addChild: scroller.
	space show.
	^ space
]

{ #category : 'building' }
TurboPhuckDisplay >> panelFor: anInstrument [

	| panel |
	panel := (ICTurboVoicePanel on: anInstrument)
		         scale: self scale;
		         yourself.
	sender ifNotNil: [ panel sender: [ :suffix :value | sender value: (anInstrument parameter: suffix) value: value ] ].
	^ panel
]

{ #category : 'building' }
TurboPhuckDisplay >> panels [

	^ self instruments collect: [ :each | self panelFor: each ]
]

{ #category : 'accessing' }
TurboPhuckDisplay >> parameters [
	"name -> type of the ChucK globals"

	^ parameters ifNil: [ PhuckVM uniqueInstance globals ]
]

{ #category : 'accessing' }
TurboPhuckDisplay >> parameters: aDictionary [

	parameters := aDictionary.
	instruments := nil
]

{ #category : 'accessing' }
TurboPhuckDisplay >> scale [

	^ scale ifNil: [ 0.4 ]
]

{ #category : 'accessing' }
TurboPhuckDisplay >> scale: aNumber [

	scale := aNumber
]

{ #category : 'accessing' }
TurboPhuckDisplay >> sender: aBlock [
	"[ :parameterName :value | ... ] receives every change instead of the VM; for tests"

	sender := aBlock
]

{ #category : 'accessing' }
TurboPhuckDisplay >> space [

	^ space
]
