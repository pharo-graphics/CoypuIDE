Extension { #name : 'ZdLoopPlayer' }

{ #category : '*CoypuIDE' }
ZdLoopPlayer >> uiActions [
	"WHOLE turns slicing off: the slice knob goes to -1"

	^ { ('WHOLE' -> ('Slice' -> -1)) }
]

{ #category : '*CoypuIDE' }
ZdLoopPlayer >> uiRanges [

	^ super uiRanges
		  at: 'Position' put: #( 0 1 0.01 );
		  at: 'Slice' put: #( -1 15 1 );
		  at: 'Length' put: #( 0 8 0.25 );
		  yourself
]

{ #category : '*CoypuIDE' }
ZdLoopPlayer >> uiToggles [

	^ #( 'Reverse' )
]
