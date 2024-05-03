Class {
	#name : #MfPianoElement,
	#superclass : #ToElement,
	#instVars : [
		'whiteKeyColor',
		'blackKeyColor',
		'nOctaves'
	],
	#category : #MooflodPianoKeyboardWidget
}

{ #category : #'visual properties' }
MfPianoElement >> backgroundPaint [ 

	^ Color black.
]

{ #category : #'simple keyboard' }
MfPianoElement >> buildKeyboard [

	| wtWid bkWid keyRect octavePt nWhite nBlack |
	wtWid := 8.
	bkWid := 5.
	self size: 10 @ 10.
	1 to: nOctaves + 1 do: [ :i |
		i <= nOctaves
			ifTrue: [
				nWhite := 7.
				nBlack := 5 ]
			ifFalse: [
				nWhite := 1.
				nBlack := 0 "High C" ].
		octavePt := self bounds topLeft + (7 * wtWid * (i - 1) - 1 @ -1).
		1 to: nWhite do: [ :j |
			| val |
			keyRect := octavePt + (j - 1 * wtWid @ 0) extent: wtWid + 1 @ 36.
			val := i - 1 * 12 + (#( 1 3 5 6 8 10 12 ) at: j) ].
		self addChild: (ToElement new
				 position: keyRect;
				 background: whiteKeyColor;
				 width: 1).
		1 to: nBlack do: [ :j |
			| val |
			keyRect := octavePt + ((#( 6 15 29 38 47 ) at: j) @ 1) extent:
				           bkWid @ 21.
			val := i - 1 * 12 + (#( 2 4 7 9 11 ) at: j) ] ].
	self addChild: (ToElement new
			 position: keyRect;
			 background: blackKeyColor;
			 width: 1).

]

{ #category : #initialization }
MfPianoElement >> initialize [
	"initialize the state of the receiver"

	super initialize.
	""

	whiteKeyColor := Color gray: 0.95.
	blackKeyColor := Color black.
	nOctaves := 2.
	self buildKeyboard
]

{ #category : #'as yet unclassified' }
MfPianoElement >> openPiano: aPiano [

	| space |
	space := BlSpace new.
	space root
		background: Color lightRed ;
		layout: BlFlowLayout horizontal.
	aPiano transformDo: [ :c | c translateBy: 200 @ 200 ].
	space root addChild: aPiano.
	space show.
	^ space
]

{ #category : #'as yet unclassified' }
MfPianoElement >> pianoExtent [

	^400@160.
]
