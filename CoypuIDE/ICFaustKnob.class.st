Class {
	#name : 'ICFaustKnob',
	#superclass : 'ICDarkKnob3',
	#instVars : [
		'scale',
		'unit'
	],
	#category : 'CoypuIDE-FaustUI',
	#package : 'CoypuIDE',
	#tag : 'FaustUI'
}

{ #category : 'accessing' }
ICFaustKnob >> angleToValue [
	"as ICKnob, through the knob's scale"

	^ (self valueAtPosition: self angle - self minAngle / (self maxAngle - self minAngle)) asFloat
]

{ #category : 'accessing' }
ICFaustKnob >> currentValue: aNumber [
	"as ICKnob, with the unit after the value"

	| roundedValue text |
	roundedValue := aNumber roundTo: self stepValue.
	currentValue := roundedValue.
	self callBack ifNotNil: [ :c | c value: currentValue ].
	text := roundedValue printShowingDecimalPlaces: 3.
	unit ifNotNil: [ text := text , ' ' , unit ].
	self currentLabel text: (text asRopedText attributes: { (BlTextForegroundAttribute paint: self valueColor) })
]

{ #category : 'scaling' }
ICFaustKnob >> effectiveScale [
	"log needs a positive range, exp a range whose exponential stays finite: otherwise the knob is linear"

	self scale = #log ifTrue: [
			^ (self minValue > 0 and: [ self maxValue > self minValue ])
				  ifTrue: [ #log ]
				  ifFalse: [ #linear ] ].
	self scale = #exp ifTrue: [
			^ (self maxValue < 700 and: [ self maxValue > self minValue ])
				  ifTrue: [ #exp ]
				  ifFalse: [ #linear ] ].
	^ #linear
]

{ #category : 'scaling' }
ICFaustKnob >> positionOfValue: aNumber [
	"the fraction (0..1) of the knob's travel showing aNumber"

	| s lo hi v |
	s := self effectiveScale.
	lo := self minValue.
	hi := self maxValue.
	hi = lo ifTrue: [ ^ 0 ].
	v := (aNumber max: lo) min: hi.
	s = #log ifTrue: [ ^ (v / lo) ln / (hi / lo) ln ].
	s = #exp ifTrue: [ ^ v exp - lo exp / (hi exp - lo exp) ].
	^ v - lo / (hi - lo)
]

{ #category : 'scaling' }
ICFaustKnob >> scale [
	"#linear, #log or #exp ([scale:log] / [scale:exp]): how the knob's travel maps onto its range"

	^ scale ifNil: [ #linear ]
]

{ #category : 'scaling' }
ICFaustKnob >> scale: aSymbol [

	scale := aSymbol
]

{ #category : 'scaling' }
ICFaustKnob >> unit [
	"[unit:Hz]: shown after the value, nil for none"

	^ unit
]

{ #category : 'scaling' }
ICFaustKnob >> unit: aString [

	unit := aString
]

{ #category : 'scaling' }
ICFaustKnob >> valueAtPosition: aFraction [
	"the value at aFraction (0..1) of the knob's travel, as Faust's LogValueConverter / ExpValueConverter"

	| s lo hi |
	s := self effectiveScale.
	lo := self minValue.
	hi := self maxValue.
	s = #log ifTrue: [ ^ lo * (hi / lo raisedTo: aFraction) ].
	s = #exp ifTrue: [ ^ (lo exp + (aFraction * (hi exp - lo exp))) ln ].
	^ aFraction * (hi - lo) + lo
]

{ #category : 'accessing' }
ICFaustKnob >> valueToAngle: aNumber [
	"as ICKnob, through the knob's scale"

	^ (self positionOfValue: aNumber) * (self maxAngle - self minAngle) + self minAngle
]
