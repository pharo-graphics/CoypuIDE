Extension { #name : 'MIDISender' }

{ #category : '*CoypuIDE' }
MIDISender >> createKnobForCC: aCCNumber onChannel: aMIDIChannel initialValue: anInteger withLabel: aLabel [

"create an ICDialKnob to control a MIDI Control Change parameter"

| knob |
knob :=  (ICDialKnob label: aLabel ) minValue: 0 ; maxValue: 127 ; stepValue: 1; setValue: anInteger .
knob  callBack: [ :v | self  sendCC: aCCNumber withValue: v asInteger onChannel: aMIDIChannel ].
^ knob
]
