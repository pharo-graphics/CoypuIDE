Class {
	#name : #BaselineOfpharotest,
	#superclass : #BaselineOf,
	#category : #BaselineOfpharotest
}

{ #category : #baselines }
BaselineOfpharotest >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			spec package: 'PatternWidget'.
			spec package: 'InputWidget'.
			spec package: 'KeyboardWidget'.
			spec package: 'PianoKeyboardWidget'.
		]
]
