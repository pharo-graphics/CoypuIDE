Class {
	#name : 'ICFaustChoice',
	#superclass : 'BlElement',
	#instVars : [
		'label',
		'choices',
		'isMenu',
		'selectedIndex',
		'callBack',
		'optionElements',
		'labelElement'
	],
	#category : 'CoypuIDE-FaustUI',
	#package : 'CoypuIDE',
	#tag : 'FaustUI'
}

{ #category : 'instance creation' }
ICFaustChoice class >> label: aString choices: aCollectionOfAssociations menu: aBoolean callBack: aBlock [
	"a [style:menu{...}] (one line cycling through the names on click) or [style:radio{...}] (every name, the chosen one lit) widget; aCollectionOfAssociations maps each name to the value sent"

	^ self new
		  label: aString choices: aCollectionOfAssociations menu: aBoolean;
		  callBack: aBlock;
		  yourself
]

{ #category : 'initialization' }
ICFaustChoice >> buildParts [

	self
		removeChildren;
		layout: (BlLinearLayout vertical cellSpacing: 2);
		padding: (BlInsets all: 8);
		background: Color veryVeryDarkGray;
		constraintsDo: [ :c |
				c horizontal exact: 140.
				c vertical fitContent ].
	labelElement := self textElement: label color: Color white size: 14.
	labelElement text bold.
	self addChild: labelElement.
	optionElements := isMenu
		                  ifTrue: [ { (self textElement: '' color: Color white size: 13) } ]
		                  ifFalse: [ choices collect: [ :each | self textElement: each key color: Color white size: 13 ] ].
	optionElements doWithIndex: [ :each :i |
			each
				geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
				constraintsDo: [ :c | c horizontal matchParent ];
				addEventHandlerOn: BlClickEvent do: [ :event |
						event consume.
						self selectIndex: (isMenu
									 ifTrue: [ selectedIndex \\ choices size + 1 ]
									 ifFalse: [ i ]) ].
			self addChild: each ].
	self refreshOptions
]

{ #category : 'accessing' }
ICFaustChoice >> callBack [

	^ callBack
]

{ #category : 'accessing' }
ICFaustChoice >> callBack: aBlock [
	"aBlock receives the value of the chosen name"

	callBack := aBlock
]

{ #category : 'accessing' }
ICFaustChoice >> choices [
	"name -> value, in order"

	^ choices
]

{ #category : 'accessing' }
ICFaustChoice >> inputText [
	"as the other DSP widgets: the parameter's label"

	^ label
]

{ #category : 'accessing' }
ICFaustChoice >> isMenu [

	^ isMenu
]

{ #category : 'accessing' }
ICFaustChoice >> label [

	^ label
]

{ #category : 'initialization' }
ICFaustChoice >> label: aString choices: aCollectionOfAssociations menu: aBoolean [

	label := aString.
	choices := aCollectionOfAssociations asArray.
	isMenu := aBoolean.
	selectedIndex := 1.
	self buildParts
]

{ #category : 'accessing' }
ICFaustChoice >> optionElements [
	"one text element per name (radio), or the single cycling one (menu)"

	^ optionElements
]

{ #category : 'operations' }
ICFaustChoice >> refreshOptions [

	choices isEmpty ifTrue: [ ^ self ].
	isMenu
		ifTrue: [
				optionElements first
					text: ((self selectedName , '  >') asRopedText
							 fontSize: 13;
							 foreground: Color white;
							 yourself);
					background: Color orange darker darker ]
		ifFalse: [
				optionElements doWithIndex: [ :each :i |
						each background: (i = selectedIndex
								 ifTrue: [ Color orange darker darker ]
								 ifFalse: [ Color black ]) ] ]
]

{ #category : 'operations' }
ICFaustChoice >> selectIndex: anInteger [
	"choose the anInteger-th name and send its value"

	choices isEmpty ifTrue: [ ^ self ].
	selectedIndex := (anInteger max: 1) min: choices size.
	self refreshOptions.
	callBack ifNotNil: [ :b | b value: self value ]
]

{ #category : 'accessing' }
ICFaustChoice >> selectedIndex [

	^ selectedIndex
]

{ #category : 'accessing' }
ICFaustChoice >> selectedName [

	^ (choices at: selectedIndex) key
]

{ #category : 'operations' }
ICFaustChoice >> setValue: aNumber [
	"choose the name whose value is closest to aNumber (the parameter's init)"

	choices isEmpty ifTrue: [ ^ self ].
	self selectIndex: ((1 to: choices size) detectMin: [ :i | ((choices at: i) value - aNumber) abs ])
]

{ #category : 'initialization' }
ICFaustChoice >> textElement: aString color: aColor size: aNumber [

	^ BlTextElement new
		  text: (aString asRopedText
				   fontSize: aNumber;
				   foreground: aColor;
				   yourself);
		  padding: (BlInsets
				   top: 3
				   left: 8
				   bottom: 3
				   right: 8);
		  yourself
]

{ #category : 'accessing' }
ICFaustChoice >> value [
	"the value of the chosen name"

	^ (choices at: selectedIndex) value
]
