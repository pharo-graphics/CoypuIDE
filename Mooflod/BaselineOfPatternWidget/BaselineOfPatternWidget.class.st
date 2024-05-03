Class {
	#name : #BaselineOfPatternWidget,
	#superclass : #BaselineOf,
	#category : #BaselineOfPatternWidget
}

{ #category : #baselines }
BaselineOfPatternWidget >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			spec package: 'PatternWidget'.
		]
]
