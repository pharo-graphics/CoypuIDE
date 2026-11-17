Extension { #name : 'Performance' }

{ #category : '*CoypuIDE' }
Performance >> display [
	"open a window with one lane per sequencer, scrolling vertically"

	| display |
	display := ICPerformanceDisplay on: self.
	display openInWindow.
	^ display
]
