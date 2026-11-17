"
I display a Coypu Sequencer as a row of step boxes, in the style of DiceTherapy (https://github.com/lucretiomsp/DiceTherapy): flat square cells on a black ground.

A step with a trig is filled with my triggeredColor and shows the note it plays; a step without a trig is black with a lavender border. Steps are grouped by beats of 4, and bars of 16 go on their own line. The sequencer key is shown at the top.

	(ICSequencerDisplay on: 16 rumba) openInWindow.
	(16 rumba notes: #(60 63 67); yourself) display triggeredColor: Color cyan.

"
Class {
	#name : 'ICSequencerDisplay',
	#superclass : 'BlElement',
	#instVars : [
		'sequencer',
		'triggeredColor',
		'stepSize',
		'editingIndex',
		'typedNote',
		'steps',
		'hoveredIndex'
	],
	#category : 'CoypuIDE-stepSequencer',
	#package : 'CoypuIDE',
	#tag : 'stepSequencer'
}

{ #category : 'instance creation' }
ICSequencerDisplay class >> on: aSequencer [

	^ self new
		  sequencer: aSequencer;
		  yourself
]

{ #category : 'editing' }
ICSequencerDisplay >> commitNote [

	| index note |
	index := editingIndex.
	note := Number readFrom: typedNote ifFail: [ nil ].
	editingIndex := nil.
	typedNote := nil.
	note ifNotNil: [ self note: note atStep: index ].
	self rebuild
]

{ #category : 'accessing' }
ICSequencerDisplay >> editingIndex [

	^ editingIndex
]

{ #category : 'actions' }
ICSequencerDisplay >> gateAt: anIndex put: aValue [
	"change a copy, so a playing sequencer never sees half-changed gates"

	| newGates |
	newGates := sequencer gates copy.
	newGates at: anIndex put: aValue.
	sequencer gates: newGates
]

{ #category : 'colors' }
ICSequencerDisplay >> groundColor [

	^ Color black
]

{ #category : 'editing' }
ICSequencerDisplay >> hoverStepAt: anIndex [

	hoveredIndex := anIndex.
	self requestFocus
]

{ #category : 'initialization' }
ICSequencerDisplay >> initialize [

	super initialize.
	triggeredColor := Color fromHexString: 'ff9933'.
	stepSize := 40.
	self
		layout: (BlLinearLayout vertical cellSpacing: 10);
		padding: (BlInsets all: 18);
		background: self groundColor;
		constraintsDo: [ :c |
				c horizontal fitContent.
				c vertical fitContent ].
	self
		addEventHandlerOn: BlTextInputEvent do: [ :evt | self typeText: evt text asString ];
		addEventHandlerOn: BlKeyDownEvent do: [ :evt | self pressKey: evt key ]
]

{ #category : 'building' }
ICSequencerDisplay >> labelFor: aRopedText color: aColor [

	^ BlTextElement new
		  text: (aRopedText
				   foreground: aColor;
				   yourself);
		  yourself
]

{ #category : 'editing' }
ICSequencerDisplay >> leaveStepAt: anIndex [

	anIndex = editingIndex ifTrue: [ self commitNote ].
	anIndex = hoveredIndex ifTrue: [ hoveredIndex := nil ]
]

{ #category : 'private' }
ICSequencerDisplay >> monospaceFontName [

	^ 'Source Code Pro'
]

{ #category : 'building' }
ICSequencerDisplay >> newBarWith: aCollectionOfSteps [

	^ BlElement new
		  layout: (BlLinearLayout horizontal cellSpacing: 12);
		  constraintsDo: [ :c |
				  c horizontal fitContent.
				  c vertical fitContent ];
		  addChildren: ((self split: aCollectionOfSteps every: self stepsPerBeat) collect: [ :beatSteps | self newBeatWith: beatSteps ]);
		  yourself
]

{ #category : 'building' }
ICSequencerDisplay >> newBeatWith: aCollectionOfSteps [

	^ BlElement new
		  layout: (BlLinearLayout horizontal cellSpacing: 3);
		  constraintsDo: [ :c |
				  c horizontal fitContent.
				  c vertical fitContent ];
		  addChildren: aCollectionOfSteps;
		  yourself
]

{ #category : 'building' }
ICSequencerDisplay >> newEmptyStep [

	^ self newStepFilledWith: self groundColor border: self ruleColor
]

{ #category : 'building' }
ICSequencerDisplay >> newGrid [
	"one line per bar, the steps of a bar grouped by beats"

	^ BlElement new
		  layout: (BlLinearLayout vertical cellSpacing: 8);
		  constraintsDo: [ :c |
				  c horizontal fitContent.
				  c vertical fitContent ];
		  addChildren: ((self split: self newSteps every: self stepsPerBar) collect: [ :barSteps | self newBarWith: barSteps ]);
		  yourself
]

{ #category : 'building' }
ICSequencerDisplay >> newHeader [

	^ BlElement new
		  layout: (BlLinearLayout horizontal alignBottomLeft cellSpacing: 12);
		  constraintsDo: [ :c |
				  c horizontal fitContent.
				  c vertical fitContent ];
		  addChildren: {
				  (self
					   labelFor: (self title asRopedText
							    bold;
							    fontSize: 22;
							    yourself)
					   color: triggeredColor).
				  (self
					   labelFor: (self summary asRopedText
							    fontName: self monospaceFontName;
							    fontSize: 11;
							    yourself)
					   color: self softColor) };
		  yourself
]

{ #category : 'building' }
ICSequencerDisplay >> newNoteLabel: aString [
	"the label lets the mouse through to its step, so replacing it while typing never sends the step a mouse leave"

	^ (self
		   labelFor: (aString asRopedText
				    bold;
				    fontName: self monospaceFontName;
				    fontSize: (stepSize * 0.3) rounded;
				    yourself)
		   color: self groundColor)
		  preventMouseEvents;
		  constraintsDo: [ :c |
				  c frame horizontal alignCenter.
				  c frame vertical alignCenter ];
		  yourself
]

{ #category : 'building' }
ICSequencerDisplay >> newRule [

	^ BlElement new
		  background: self ruleColor;
		  constraintsDo: [ :c |
				  c horizontal matchParent.
				  c vertical exact: 1 ];
		  yourself
]

{ #category : 'building' }
ICSequencerDisplay >> newStepFilledWith: aColor border: aBorderColor [

	^ BlElement new
		  extent: stepSize @ stepSize;
		  padding: (BlInsets all: 3);
		  background: aColor;
		  border: (BlBorder paint: aBorderColor width: 1);
		  layout: BlFrameLayout new;
		  yourself
]

{ #category : 'building' }
ICSequencerDisplay >> newSteps [
	"the notes advance only on trigs, as when the sequencer plays. A click switches a step between rest and trig; typing over a step sets its note"

	| trigCount |
	trigCount := 0.
	^ steps := (1 to: sequencer gates size) collect: [ :index |
			           | step |
			           step := (sequencer gates at: index) > 0
				                   ifTrue: [
						                   trigCount := trigCount + 1.
						                   self newTriggeredStepWith: (self noteForTrig: trigCount) ]
				                   ifFalse: [ self newEmptyStep ].
			           step
				           addEventHandlerOn: BlClickEvent do: [ :evt | self toggleStepAt: index ];
				           addEventHandlerOn: BlMouseEnterEvent do: [ :evt | self hoverStepAt: index ];
				           addEventHandlerOn: BlMouseLeaveEvent do: [ :evt | self leaveStepAt: index ];
				           yourself ]
]

{ #category : 'building' }
ICSequencerDisplay >> newTriggeredStepWith: aNoteOrNil [

	| step |
	step := self newStepFilledWith: triggeredColor border: triggeredColor lighter.
	aNoteOrNil ifNotNil: [ step addChild: (self newNoteLabel: (self noteStringFor: aNoteOrNil)) ].
	^ step
]

{ #category : 'actions' }
ICSequencerDisplay >> note: aNumber atStep: anIndex [
	"set the note of the step at anIndex, making a rest a trig. The notes are spread one per trig first, so every other trig keeps its note"

	| notes trigNumber |
	notes := ((1 to: (sequencer numberOfTrigs max: sequencer notesSize)) collect: [ :each | self noteForTrig: each ])
		         asOrderedCollection.
	trigNumber := self trigNumberAt: anIndex.
	(sequencer gates at: anIndex) > 0
		ifTrue: [ notes at: trigNumber put: aNumber ]
		ifFalse: [
				notes add: aNumber beforeIndex: trigNumber + 1.
				self gateAt: anIndex put: 1 ].
	sequencer notes: (notes collect: [ :each | each ifNil: [ aNumber ] ]) asArray
]

{ #category : 'private' }
ICSequencerDisplay >> noteForTrig: anIndex [

	| notes |
	notes := sequencer notes.
	notes isEmptyOrNil ifTrue: [ ^ nil ].
	^ notes at: anIndex - 1 \\ notes size + 1
]

{ #category : 'private' }
ICSequencerDisplay >> noteStringFor: aNote [

	aNote isNumber ifFalse: [ ^ aNote asString ].
	^ aNote isInteger
		  ifTrue: [ aNote printString ]
		  ifFalse: [ aNote printShowingDecimalPlaces: 1 ]
]

{ #category : 'opening' }
ICSequencerDisplay >> openInWindow [
	"open me in a window that follows my size"

	| space |
	space := BlSpace new.
	space title: 'Sequencer ' , self title.
	space root
		background: self groundColor;
		addChild: self.
	self addEventHandlerOn: BlElementExtentChangedEvent do: [ :evt | space extent: evt target extent ].
	space show.
	^ space
]

{ #category : 'editing' }
ICSequencerDisplay >> pressKey: aKey [

	editingIndex ifNil: [ ^ self ].
	aKey = KeyboardKey enter ifTrue: [ ^ self commitNote ].
	aKey = KeyboardKey escape ifTrue: [ ^ self stopEditing ].
	aKey = KeyboardKey backspace ifTrue: [
			typedNote := typedNote allButLast.
			self showTypedNote ]
]

{ #category : 'building' }
ICSequencerDisplay >> rebuild [

	self removeChildren.
	sequencer ifNil: [ ^ self ].
	self addChildren: {
			self newHeader.
			self newRule.
			self newGrid }
]

{ #category : 'colors' }
ICSequencerDisplay >> ruleColor [

	^ Color fromHexString: '9a78dc'
]

{ #category : 'accessing' }
ICSequencerDisplay >> sequencer [

	^ sequencer
]

{ #category : 'accessing' }
ICSequencerDisplay >> sequencer: aSequencer [

	sequencer := aSequencer.
	self rebuild
]

{ #category : 'editing' }
ICSequencerDisplay >> showTypedNote [
	"update only the step being typed in, so nothing is rebuilt under the mouse"

	(steps at: editingIndex)
		background: triggeredColor;
		border: (BlBorder paint: Color white width: 2);
		removeChildren;
		addChild: (self newNoteLabel: typedNote , '_')
]

{ #category : 'colors' }
ICSequencerDisplay >> softColor [

	^ Color fromHexString: 'c2aef0'
]

{ #category : 'private' }
ICSequencerDisplay >> split: aCollection every: anInteger [

	^ (1 to: aCollection size by: anInteger) collect: [ :start |
		  aCollection copyFrom: start to: (start + anInteger - 1 min: aCollection size) ]
]

{ #category : 'accessing' }
ICSequencerDisplay >> stepSize [

	^ stepSize
]

{ #category : 'accessing' }
ICSequencerDisplay >> stepSize: aNumber [

	stepSize := aNumber.
	self rebuild
]

{ #category : 'accessing' }
ICSequencerDisplay >> steps [

	^ steps
]

{ #category : 'accessing' }
ICSequencerDisplay >> stepsPerBar [

	^ 16
]

{ #category : 'accessing' }
ICSequencerDisplay >> stepsPerBeat [

	^ 4
]

{ #category : 'editing' }
ICSequencerDisplay >> stopEditing [

	editingIndex := nil.
	typedNote := nil.
	self rebuild
]

{ #category : 'private' }
ICSequencerDisplay >> summary [

	^ sequencer gates size printString , ' steps · ' , sequencer numberOfTrigs printString , ' trigs'
]

{ #category : 'accessing' }
ICSequencerDisplay >> title [
	"the sequencer key as a plain string, so a Symbol shows without its hash"

	^ (sequencer seqKey ifNil: [ 'sequencer' ]) asString asUppercase
]

{ #category : 'actions' }
ICSequencerDisplay >> toggleStepAt: anIndex [
	"switch the step at anIndex between rest and trig in my sequencer, then redraw. The sequencer keeps its length"

	editingIndex := nil.
	typedNote := nil.
	self gateAt: anIndex put: ((sequencer gates at: anIndex) > 0
			 ifTrue: [ 0 ]
			 ifFalse: [ 1 ]).
	self rebuild
]

{ #category : 'private' }
ICSequencerDisplay >> trigNumberAt: anIndex [

	^ ((sequencer gates first: anIndex) select: [ :gate | gate > 0 ]) size
]

{ #category : 'accessing' }
ICSequencerDisplay >> triggeredColor [

	^ triggeredColor
]

{ #category : 'accessing' }
ICSequencerDisplay >> triggeredColor: aColor [

	triggeredColor := aColor.
	self rebuild
]

{ #category : 'editing' }
ICSequencerDisplay >> typeText: aString [

	| digits |
	hoveredIndex ifNil: [ ^ self ].
	digits := aString select: [ :each | each isDigit or: [ each = $. ] ].
	digits ifEmpty: [ ^ self ].
	editingIndex = hoveredIndex ifFalse: [
			editingIndex ifNotNil: [ self commitNote ].
			editingIndex := hoveredIndex.
			typedNote := '' ].
	digits := typedNote , digits.
	typedNote := digits copyFrom: 1 to: (digits size min: 5).
	self showTypedNote
]
