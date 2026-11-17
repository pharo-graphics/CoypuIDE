Extension { #name : 'Sequencer' }

{ #category : '*CoypuIDE' }
Sequencer >> display [
	"open a window showing my steps: trigs in colour with their note, rests in black. Answer the display, whose triggeredColor: recolours it"

	| display |
	display := ICSequencerDisplay on: self.
	display openInWindow.
	^ display
]
