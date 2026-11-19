Extension { #name : 'ZdLoopPlayer' }

{ #category : '*CoypuIDE' }
ZdLoopPlayer >> uiActions [
	"WHOLE turns slicing off: the slice knob goes to -1"

	^ { ('WHOLE' -> ('Slice' -> -1)) }
]

{ #category : '*CoypuIDE' }
ZdLoopPlayer >> uiToggles [

	^ #( 'Reverse' )
]
