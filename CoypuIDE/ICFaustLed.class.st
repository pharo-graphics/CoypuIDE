Class {
	#name : 'ICFaustLed',
	#superclass : 'ICValueDisplay',
	#instVars : [
		'minValue',
		'maxValue',
		'lamp'
	],
	#category : 'CoypuIDE-FaustUI',
	#package : 'CoypuIDE',
	#tag : 'FaustUI'
}

{ #category : 'instance creation' }
ICFaustLed class >> fromDictionary: aDictionary forDsp: aDsp [
	"a [style:led] bargraph"

	^ self new
		  label: (aDictionary at: #label);
		  minValue: (aDictionary at: #min ifAbsent: [ 0 ]);
		  maxValue: (aDictionary at: #max ifAbsent: [ 1 ]);
		  address: (aDictionary at: #address ifAbsent: [ nil ]);
		  attachedDsp: aDsp
]

{ #category : 'accessing' }
ICFaustLed >> initialize [
	"an ICValueDisplay drawn as a lamp: dark at the bargraph's min, bright red at its max"

	super initialize.
	minValue := 0.
	maxValue := 1.
	self
		removeChildren;
		layout: (BlLinearLayout vertical cellSpacing: 6) alignCenter;
		padding: (BlInsets all: 8);
		constraintsDo: [ :c |
				c horizontal exact: 90.
				c vertical fitContent ].
	lamp := BlElement new
		        geometry: BlCircleGeometry new;
		        extent: 36 @ 36;
		        border: (BlBorder paint: Color gray width: 1);
		        background: (self lampColorAt: 0);
		        yourself.
	self
		addChild: lamp;
		addChild: labelText
]

{ #category : 'accessing' }
ICFaustLed >> label: aString [

	labelText text: (aString asRopedText
			 fontSize: 13;
			 foreground: Color white;
			 yourself).
	label := aString
]

{ #category : 'accessing' }
ICFaustLed >> lamp [

	^ lamp
]

{ #category : 'accessing' }
ICFaustLed >> lampColorAt: aFraction [

	^ Color black mixed: 1 - aFraction with: Color red
]

{ #category : 'accessing' }
ICFaustLed >> levelOf: aNumber [
	"aNumber's place between min and max, 0..1"

	maxValue = minValue ifTrue: [ ^ 0 ].
	^ (aNumber - minValue / (maxValue - minValue) max: 0) min: 1
]

{ #category : 'accessing' }
ICFaustLed >> maxValue: aNumber [

	maxValue := aNumber
]

{ #category : 'accessing' }
ICFaustLed >> minValue: aNumber [

	minValue := aNumber
]

{ #category : 'accessing' }
ICFaustLed >> value: aNumber [
	"light the lamp; polled from a background process, so the change goes through the element's task queue"

	| color |
	color := self lampColorAt: (self levelOf: aNumber).
	self isAttachedToSceneGraph
		ifTrue: [ self enqueueTask: (BlTaskAction new action: [ lamp background: color ]) ]
		ifFalse: [ lamp background: color ]
]
