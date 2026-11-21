Extension { #name : 'TurboAux' }

{ #category : '*CoypuIDE' }
TurboAux >> uiDefaults [
	"whole global name -> the value my shred starts with: delayTime -> 0.375"

	^ (self globals collect: [ :each | (self parameter: each key) -> each value ]) asDictionary
]

{ #category : '*CoypuIDE' }
TurboAux >> uiKnobs [
	"one ICLightKnob per global, on my ranges and defaults; the callback goes in last, so building them sends nothing to the VM"

	^ self globals collect: [ :each |
			  | range knob |
			  range := self ranges at: each key.
			  knob := ICLightKnob label: (self uiLabelFor: each key) minValue: range first maxValue: range second.
			  knob stepValue: range third.
			  knob setValue: each value.
			  knob callBack: [ :value | self set: each key to: value asFloat ].
			  knob ]
]

{ #category : '*CoypuIDE' }
TurboAux >> uiLabelFor: aSuffix [
	"the name on the knob of aSuffix: Delay Time"

	^ self name capitalized , ' ' , aSuffix
]

{ #category : '*CoypuIDE' }
TurboAux >> uiLabels [
	"whole global name -> knob label: delayTime -> Delay Time"

	^ (self globals collect: [ :each | (self parameter: each key) -> (self uiLabelFor: each key) ]) asDictionary
]

{ #category : '*CoypuIDE' }
TurboAux >> uiRanges [
	"whole global name -> { min. max. step }: delayTime -> #(0.01 1.0 0.01)"

	^ (self globals collect: [ :each | (self parameter: each key) -> (self ranges at: each key) ]) asDictionary
]
