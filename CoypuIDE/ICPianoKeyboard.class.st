"
I represent a 2 octaves piano. 

### Next step
I should get a call back that it invoked when pressed. 
"
Class {
	#name : 'ICPianoKeyboard',
	#superclass : 'ToElement',
	#instVars : [
		'whiteKeyColor',
		'blackKeyColor',
		'whiteNoteNames',
		'startNote',
		'whitenotes',
		'nOctaves',
		'xPositionOfBlackNotes',
		'blacknotes'
	],
	#category : 'CoypuIDE-PianoKeyboard',
	#package : 'CoypuIDE',
	#tag : 'PianoKeyboard'
}

{ #category : 'examples' }
ICPianoKeyboard class >> openPiano [

	<script>
	| space aPiano |
	space := BlSpace new.
	space root
		background: Color lightRed;
		layout: BlFlowLayout horizontal.
	aPiano := self new.
	aPiano transformDo: [ :c | c translateBy: 200 @ 200 ].
	space root addChild: aPiano.
	space show.
	^ space
]

{ #category : 'visual properties' }
ICPianoKeyboard >> backgroundPaint [ 

	^ Color black.
]

{ #category : 'accessing' }
ICPianoKeyboard >> blacknotes [
	^ blacknotes
]

{ #category : 'initialization' }
ICPianoKeyboard >> initialize [

	super initialize.
	whiteNoteNames := #( 'C' 'D' 'E' 'F' 'G' 'A' 'B' ).
	self border: (BlBorder paint: Color black width: 2).
	self geometry: BlRectangleGeometry new.
	whiteKeyColor := Color gray: 0.95.
	blackKeyColor := Color black.
	self
		nOctaves: 5;
		startNote: 'C'
]

{ #category : 'initialization' }
ICPianoKeyboard >> initializeBlackHandlers [

	blacknotes do: [ :n |
		n
			addEventHandlerOn: BlMouseDownEvent
			do: [ :evt | n background: Color lightGray ].
		n
			addEventHandlerOn: BlMouseUpEvent
			do: [ :evt | n background: blackKeyColor ].
		n
			addEventHandlerOn: BlMouseLeaveEvent
			do: [ :evt | n background: blackKeyColor ] ]
]

{ #category : 'initialization' }
ICPianoKeyboard >> initializeBlackNotes [

	| wN wx bN bx whiteNoteDescriptions blackNoteXArray array |
	"initializing notes for the two octaves"
	array := #( 'C' 'D' 'E' 'F' 'G' 'A' 'B' ).
	whitenotes := OrderedCollection new.
	blacknotes := OrderedCollection new.
	"for now the note description is not used and only for the white notes"
	whiteNoteDescriptions := OrderedCollection new.
	nOctaves timesRepeat: [
		array do: [ :e | whiteNoteDescriptions add: e ] ].
	wx := 0.
	bx := 0.
	"adding the white notes"
	1 to: nOctaves * 7 do: [ :i |
		wN := ICPianoWhiteNoteElement newWithColor: whiteKeyColor.
		wN note: (whiteNoteDescriptions at: i).
		self addChild: wN.
		wN transformDo: [ :e |
			e translateBy: wx @ 0.
			wx := wx + 36 ].
		whitenotes add: wN ].
	self initializeWhiteHandlers.

	"changing the disposition of black notes depending on start note"
	1 to: 7 do: [ :e |
		startNote = (whiteNoteDescriptions at: e) ifTrue: [
			blackNoteXArray := xPositionOfBlackNotes at: e ] ].
	"now add the black notes to the widget"
	1 to: blackNoteXArray size do: [ :i |
		bN := ICPianoBlackNoteElement newWithColor: blackKeyColor.
		blacknotes add: bN.
		self addChild: bN.
		bN transformDo: [ :e |
			bx := bx + (blackNoteXArray at: i).
			e translateBy: bx @ 0 ] ]. "blackNoteXArray size"
	self initializeBlackHandlers.

	^ blackNoteXArray
]

{ #category : 'initialization' }
ICPianoKeyboard >> initializeNotes [

	self initializeWhiteNotes.
	"self initializeBlackNotes"
]

{ #category : 'initialization' }
ICPianoKeyboard >> initializeWhiteHandlers [

	whitenotes do: [ :n |
		n
			addEventHandlerOn: BlMouseDownEvent
			do: [ :evt | n background: Color lightGray ].
		n
			addEventHandlerOn: BlMouseUpEvent
			do: [ :evt | n background: whiteKeyColor ].
		n
			addEventHandlerOn: BlMouseLeaveEvent
			do: [ :evt | n background: whiteKeyColor ] ]
]

{ #category : 'initialization' }
ICPianoKeyboard >> initializeWhiteNotes [

	| wN wx bx whiteNoteDescriptions  |
	"initializing notes for the two octaves"
	
	whitenotes := OrderedCollection new.
	blacknotes := OrderedCollection new.
	"for now the note description is not used and only for the white notes"
	whiteNoteDescriptions := OrderedCollection new.
	nOctaves timesRepeat: [
		self whiteNoteNames do: [ :e | whiteNoteDescriptions add: e ] ].
	wx := 0.
	bx := 0.
	"adding the white notes"
	1 to: nOctaves * 7 do: [ :i |
		wN := ICPianoWhiteNoteElement newWithColor: whiteKeyColor.
		wN note: (whiteNoteDescriptions at: i).
		self addChild: wN.
		wN transformDo: [ :e |
			e translateBy: wx @ 0.
			wx := wx + 36 ].
		whitenotes add: wN ].
	self initializeWhiteHandlers
]

{ #category : 'initialization' }
ICPianoKeyboard >> initializeXPositionsOfBlackNotes [

	| cA dA eA fA gA aA bA |
	"each array represent the x coordinate of black notes based the starting one.
	cA is for when the C is starting....
	"
	cA := #( 26.5 36 67 40 39 68.5 36 68 41 40 ).
	dA := #( 28 65 40 39 68 40 70 39 39 ).
	eA := #( 60 39 39 68 36 70 39 39 68 ).
	fA := #( 24 39 39 68 36 70 39 39 68 36 ).
	gA := #( 26 39 68 36 70 39 39 68 36 ).
	aA := #( 29 68 36 70 39 39 68 36 70 ).
	bA := #( 62 36 70 39 39 68 36 70 39 ).

	xPositionOfBlackNotes := {
		                         cA.
		                         dA.
		                         eA.
		                         fA.
		                         gA.
		                         aA.
		                         bA }
]

{ #category : 'accessing' }
ICPianoKeyboard >> nOctaves [

^nOctaves 
]

{ #category : 'accessing' }
ICPianoKeyboard >> nOctaves: num [

	nOctaves := num.
		self size: self pianoExtent.
]

{ #category : 'accessing' }
ICPianoKeyboard >> pianoExtent [

	^ (252.5 *nOctaves)  @ 130
]

{ #category : 'accessing' }
ICPianoKeyboard >> startNote [

^startNote 
]

{ #category : 'accessing' }
ICPianoKeyboard >> startNote: aNote [

	startNote := aNote.
	self initializeXPositionsOfBlackNotes .
	self initializeNotes 
]

{ #category : 'accessing' }
ICPianoKeyboard >> whiteKeyColor [
	^ whiteKeyColor
]

{ #category : 'accessing' }
ICPianoKeyboard >> whiteNoteNames [

^ whiteNoteNames 
]

{ #category : 'accessing' }
ICPianoKeyboard >> whitenotes [

^whitenotes
]
