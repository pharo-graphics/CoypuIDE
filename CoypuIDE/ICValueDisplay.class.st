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
		'attachedDsp'
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

	^ self new label: (aDictionary at: #label); attachedDsp: aDsp
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

{ #category : 'initialization' }
ICValueDisplay >> initialize [

	super initialize.
	self background: Color black lighter.
	self layout: BlFrameLayout new.

	self size: self widgetSize.
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

	^ labelText  asString
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

{ #category : 'accessing' }
ICValueDisplay >> textPaint [

^ Color red
]

{ #category : 'protocol' }
ICValueDisplay >> updateValue [

attachedDsp isNull ifTrue: [^ Error new signal: 'Invalid DSP'] ifFalse: [  
	^ [
	  [ self class isUpdating ] whileTrue: [
		  self value: (self attachedDsp getParamValue: self label).
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
