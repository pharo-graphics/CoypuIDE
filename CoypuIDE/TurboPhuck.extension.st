Extension { #name : 'TurboPhuck' }

{ #category : '*CoypuIDE' }
TurboPhuck >> displayMasterUI [

| hpfFreqKnob pitchShiftKnob knobs sizes row space |
pitchShiftKnob := ICDarkKnob2 label: 'pitchShift' minValue: 0.01 maxValue: 2 callBack: [ :i | PhuckVM uniqueInstance setValue: i parameter: 'pitchShift' ].

hpfFreqKnob := ICDarkKnob2 label: 'highpassFreq' minValue: 20  maxValue: 2400 callBack: [ :i | PhuckVM uniqueInstance setValue: i parameter: 'highpassFreq' ].

knobs := { pitchShiftKnob. hpfFreqKnob }.
	sizes := knobs collect: [ :each | each widgetSize ].

	row := BlElement new
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		addChildren: knobs;
		yourself.

	space := BlSpace new
		title: 'Master';
		extent: sizes sum @ sizes max;
		yourself.
	space root addChild: row.
	space show.
	^ space
]
