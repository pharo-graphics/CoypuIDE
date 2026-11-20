"
I am the fader of TurboPhuck>>displayUIForGains: an ICMixerFader without min/max labels and without a number on the handle. My current value is written just below the bar (two decimals), fonts are 30% bigger at the same bar width, and I keep a little space on both sides; a name too long for me is cut at my edges.
"
Class {
	#name : 'ICTurboGainFader',
	#superclass : 'ICMixerFader',
	#instVars : [
		'valueText'
	],
	#category : 'CoypuIDE-Turbo',
	#package : 'CoypuIDE',
	#tag : 'Turbo'
}

{ #category : 'instance creation' }
ICTurboGainFader class >> label: aString min: aMin max: aMax value: aValue step: aStep callBack: aBlock [
	"thin (70% of an ICMixerFader); the value is set before the callBack, so building me sends nothing"

	^ (self label: aString)
		  barLength: 120 thickness: 49;
		  minValue: aMin;
		  maxValue: aMax;
		  stepValue: aStep;
		  setValue: aValue;
		  callBack: aBlock;
		  yourself
]

{ #category : 'accessing' }
ICTurboGainFader >> applyLabelSizes [

	super applyLabelSizes.
	self updateValueLabel
]

{ #category : 'accessing' }
ICTurboGainFader >> barOrigin [
	"vertically: the name band, then a short gap, then the bar, centred in my width"

	^ self ifHorizontal: [ super barOrigin ] ifVertical: [ self widgetExtent x - self barSize x / 2 @ self barTop ]
]

{ #category : 'accessing' }
ICTurboGainFader >> barTop [

	^ self bandHeight + self topGap
]

{ #category : 'accessing' }
ICTurboGainFader >> bottomSpace [
	"below the value, before the next row; inside me so it keeps my background"

	^ 8
]

{ #category : 'accessing' }
ICTurboGainFader >> fontSize [
	"30% bigger than an ICMixerFader of my thickness"

	^ super fontSize * 1.3
]

{ #category : 'accessing' }
ICTurboGainFader >> initialize [

	super initialize.
	self clipChildren: true
]

{ #category : 'accessing' }
ICTurboGainFader >> initializeValueLabels [
	"no min/max labels and no number on the handle: the current value is written below the bar"

	super initializeValueLabels.
	{
		minLabel.
		maxLabel.
		valueLabel } do: [ :each | each visibility: BlVisibility gone ].
	valueText := BlTextElement new.
	self addChild: valueText.
	self updateValueLabel
]

{ #category : 'accessing' }
ICTurboGainFader >> labelColumnWidth [
	"the bigger font must not make the bar column wider"

	^ super labelColumnWidth / 1.3
]

{ #category : 'accessing' }
ICTurboGainFader >> placeLabelsVertically [

	super placeLabelsVertically.
	valueText ifNotNil: [
			valueText constraintsDo: [ :c |
					c padding: (BlInsets all: 0).
					c margin: (BlInsets top: self valueTop).
					c frame horizontal alignCenter.
					c frame vertical alignTop ] ]
]

{ #category : 'accessing' }
ICTurboGainFader >> sideSpace [
	"left and right of the bar column, so neighbouring names stay apart"

	^ 5
]

{ #category : 'accessing' }
ICTurboGainFader >> topGap [
	"between the name and the top of the bar: 60% of an ICMixerFader's"

	^ self lengthPadding + marginLength * 0.6
]

{ #category : 'accessing' }
ICTurboGainFader >> updateValueLabel [

	valueText ifNotNil: [ valueText text: (self labelText: self valueString color: Color white) ]
]

{ #category : 'accessing' }
ICTurboGainFader >> valueGap [
	"between the end of the bar and the value"

	^ 10
]

{ #category : 'accessing' }
ICTurboGainFader >> valueString [

	^ (value ifNil: [ 0 ]) printShowingDecimalPlaces: 2
]

{ #category : 'accessing' }
ICTurboGainFader >> valueText [

	^ valueText
]

{ #category : 'accessing' }
ICTurboGainFader >> valueTop [

	^ self barTop + barLength + self valueGap
]

{ #category : 'accessing' }
ICTurboGainFader >> widgetExtent [
	"vertically: name, gap, bar, gap, value, bottom space; side space left and right"

	^ self
		  ifHorizontal: [ super widgetExtent ]
		  ifVertical: [ super widgetExtent x + (2 * self sideSpace) @ (self valueTop + self bandHeight + self bottomSpace) ]
]
