"
Simple BlTextElement that display a chaning values (designed to be used with Phausto PhHBarGraph)
"
Class {
	#name : 'ICValueDisplay',
	#superclass : 'BlElement',
	#instVars : [
		'labelText',
		'valueText',
		'label',
		'attachedDsp',
		'address',
		'isPolling'
	],
	#classInstVars : [
		'isUpdating'
	],
	#category : 'CoypuIDE-numericalEntry',
	#package : 'CoypuIDE',
	#tag : 'numericalEntry'
}

{ #category : 'instance creation' }
ICValueDisplay class >> fromDictionary: aDictionary forDsp: aDsp [

	^ self new
		  label: (aDictionary at: #label);
		  address: (aDictionary at: #address ifAbsent: [ nil ]);
		  attachedDsp: aDsp
]

{ #category : 'accessing' }
ICValueDisplay class >> isUpdating [


^ isUpdating ifNil: [  ^ true ]
]

{ #category : 'accessing' }
ICValueDisplay class >> isUpdating: aBoolean [


isUpdating  := aBoolean
]

{ #category : 'accessing' }
ICValueDisplay >> address [
	"the full Faust address of the bargraph shown, nil to look it up by label"

	^ address
]

{ #category : 'accessing' }
ICValueDisplay >> address: aString [

	address := aString
]

{ #category : 'accessing' }
ICValueDisplay >> attachedDsp [ 

^ attachedDsp
]

{ #category : 'accessing' }
ICValueDisplay >> attachedDsp: aDsp [

	attachedDsp := aDsp.
	"after having assigned a Dsp, we can start the mechainsm to upate value"
	self updateValue.
]

{ #category : 'accessing' }
ICValueDisplay >> configuredString: aString [

	^ aString asRopedText attributes:
		  { (BlTextForegroundAttribute paint: self textPaint) }
]

{ #category : 'protocol' }
ICValueDisplay >> currentValue [
	"the bargraph's value in the DSP, by address when known (nil when unknown: never ask libfaust for index -1)"

	^ address
		  ifNil: [ (attachedDsp getParamIndex: self label) < 0 ifFalse: [ attachedDsp getParamValue: self label ] ]
		  ifNotNil: [ attachedDsp getValueAtAddress: address ]
]

{ #category : 'initialization' }
ICValueDisplay >> initialize [

	super initialize.
	self background: Color black lighter.
	self layout: BlFrameLayout new.

	self extent: self widgetSize.
	self constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignCenter ].
	self initializeValueText.
	self initializeLabel: 'Value'.

	self addChild: valueText
]

{ #category : 'accessing' }
ICValueDisplay >> initializeLabel: aString [

	labelText := BlTextElement new.
	labelText text: (self configuredString: aString).
	labelText text fontSize: 20.
	labelText constraintsDo: [ :c | c frame horizontal alignCenter ].
		valueText transformDo: [ :t | t translateBy: 0 @ 2 ].


	self addChild: labelText
]

{ #category : 'initialization' }
ICValueDisplay >> initializeValueText [

	valueText := BlTextElement new.
	valueText text: (self configuredString: '0').
	valueText text fontSize: 80.
	valueText layout: BlFrameLayout new.

	valueText constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	valueText transformDo: [ :t | t translateBy: 0@6 ]
]

{ #category : 'accessing' }
ICValueDisplay >> inputText [
	"the parameter's label, as the other DSP widgets (it answered the label element's printString)"

	^ label ifNil: [ '' ]
]

{ #category : 'accessing' }
ICValueDisplay >> isPolling [
	"false once stopUpdating was sent: this display never asks its DSP again"

	^ isPolling ifNil: [ isPolling := true ]
]

{ #category : 'accessing' }
ICValueDisplay >> label [

^ label
]

{ #category : 'accessing' }
ICValueDisplay >> label: aString [

	labelText text: (self configuredString: aString).
	labelText text fontSize: 20.
	label := aString
]

{ #category : 'protocol' }
ICValueDisplay >> shouldUpdate [
	"poll while this display and all displays are on, and while the DSP is alive: a destroyed DSP must never be asked again"

	^ self class isUpdating and: [
		  self isPolling and: [
			  attachedDsp isNotNil and: [ attachedDsp isNull not and: [ attachedDsp isInitialized ] ] ] ]
]

{ #category : 'protocol' }
ICValueDisplay >> stopUpdating [
	"stop polling the DSP (its window closes); the other displays keep going"

	isPolling := false
]

{ #category : 'accessing' }
ICValueDisplay >> textPaint [

^ Color red
]

{ #category : 'protocol' }
ICValueDisplay >> updateValue [

attachedDsp isNull ifTrue: [^ Error new signal: 'Invalid DSP'] ifFalse: [  
	^ [
	  [ self shouldUpdate ] whileTrue: [
		  self currentValue ifNotNil: [ :v | self value: v ].
		  (Delay forMilliseconds: 200) wait ] ] forkAt: 10]
]

{ #category : 'accessing' }
ICValueDisplay >> value: aNumber [

	valueText text: (self configuredString: aNumber asString).
	valueText text fontSize: 80
]

{ #category : 'accessing' }
ICValueDisplay >> widgetSize [

	^ 200 @ 80
]
