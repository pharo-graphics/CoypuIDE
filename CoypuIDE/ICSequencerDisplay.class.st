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
		'stepSize'
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

{ #category : 'colors' }
ICSequencerDisplay >> groundColor [

	^ Color black
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
				c vertical fitContent ]
]

{ #category : 'building' }
ICSequencerDisplay >> labelFor: aRopedText color: aColor [

	^ BlTextElement new
		  text: (aRopedText
				   foreground: aColor;
				   yourself);
		  yourself
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
	"the notes advance only on trigs, as when the sequencer plays"

	| trigCount |
	trigCount := 0.
	^ (Array withAll: sequencer gates) collect: [ :gate |
			  gate > 0
				  ifTrue: [
						  trigCount := trigCount + 1.
						  self newTriggeredStepWith: (self noteForTrig: trigCount) ]
				  ifFalse: [ self newEmptyStep ] ]
]

{ #category : 'building' }
ICSequencerDisplay >> newTriggeredStepWith: aNoteOrNil [

	| step |
	step := self newStepFilledWith: triggeredColor border: triggeredColor lighter.
	aNoteOrNil ifNotNil: [
			step addChild: ((self
					  labelFor: ((self noteStringFor: aNoteOrNil) asRopedText
							   bold;
							   fontName: self monospaceFontName;
							   fontSize: (stepSize * 0.3) rounded;
							   yourself)
					  color: self groundColor) constraintsDo: [ :c |
						 c frame horizontal alignCenter.
						 c frame vertical alignCenter ]) ].
	^ step
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
ICSequencerDisplay >> stepsPerBar [

	^ 16
]

{ #category : 'accessing' }
ICSequencerDisplay >> stepsPerBeat [

	^ 4
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

{ #category : 'accessing' }
ICSequencerDisplay >> triggeredColor [

	^ triggeredColor
]

{ #category : 'accessing' }
ICSequencerDisplay >> triggeredColor: aColor [

	triggeredColor := aColor.
	self rebuild
]
