"
I am a Kyma/Capytalk-style reference browser built with Toplo accordions.

Sections, top to bottom: Search, Categories, Messages, Description, Examples.
Typing in Search filters the Messages list through a sieve; selecting a messagerefreshes Description and Examples. Selecting a category narrows Messages to that category.

```language=pharp
	ICReferenceBrowser openWithSampleData
```
"
Class {
	#name : 'ICReferenceBrowser',
	#superclass : 'ToElement',
	#instVars : [
		'entries',
		'messageList',
		'sieve',
		'categoryList',
		'descriptionBody',
		'exampleBody',
		'currentEntry'
	],
	#category : 'CoypuIDE-Reference',
	#package : 'CoypuIDE',
	#tag : 'Reference'
}

{ #category : 'examples' }
ICReferenceBrowser class >> openWithSampleData [

	<script>
	| browser |
	browser := self new entries: self sampleEntries.
	browser openInSpace.
	^ browser
]

{ #category : 'examples' }
ICReferenceBrowser class >> sampleEntries [

	^ {
		  self sampleRepeatingFullRamp.
		  self sampleRepeatingRamp.
		  self sampleRepeatingTriangle.
		  self sampleSin.
		  self sampleSqrt }
]

{ #category : 'examples' }
ICReferenceBrowser class >> sampleRepeatingFullRamp [

	^ (ICReferenceEntry name: 'repeatingFullRamp' category: 'Time')
		  range: '(-1,1)';
		  summary:
			  'Shortcut for !Gate repeatingFullRamp: 1 s. See repeatingFullRamp: for more details.';
		  examples: #( '!Gate repeatingFullRamp: !Dur s'
				   '(1 repeatingFullRamp: (!Rate hz inverse)) normSin as controlPosition'
				   '1 repeatingFullRamp: !Dur as looping time index' );
		  yourself
]

{ #category : 'examples' }
ICReferenceBrowser class >> sampleRepeatingRamp [

	^ (ICReferenceEntry name: 'repeatingRamp' category: 'Time')
		  range: '(0,1)';
		  summary: 'A ramp from 0 to 1 repeating at the given rate.';
		  examples: #( '1 repeatingRamp: !Dur s' );
		  yourself
]

{ #category : 'examples' }
ICReferenceBrowser class >> sampleSin [

	^ (ICReferenceEntry name: 'sin' category: 'Math')
		  range: '(-1,1)';
		  summary: 'Sine of the receiver, interpreted in radians.';
		  examples: #( '!Freq sin' );
		  yourself
]

{ #category : 'examples' }
ICReferenceBrowser class >> sampleSqrt [

	^ (ICReferenceEntry name: 'sqrt' category: 'Math')
		  range: '(0,1)';
		  summary: 'Square root of the receiver.';
		  examples: #( '!Amp sqrt' );
		  yourself
]

{ #category : 'text style' }
ICReferenceBrowser >> boldText: aString [

	^ aString asRopedText
		  bold;
		  yourself
]

{ #category : 'accessing' }
ICReferenceBrowser >> categoryList [ 
 ^  categoryList 
]

{ #category : 'querying' }
ICReferenceBrowser >> categoryNames [

	^ (self entries collect: [ :each | each category ]) asSet asSortedCollection
		  asArray
]

{ #category : 'accessing' }
ICReferenceBrowser >> currentEntry [ 
^ currentEntry 
]

{ #category : 'accessing' }
ICReferenceBrowser >> descriptionBody [ 
^ descriptionBody
]

{ #category : 'actions' }
ICReferenceBrowser >> editCurrentEntry [

	"Hook: open the current entry's source in a Coypu editor."

	currentEntry ifNil: [ ^ self ].
	self inform: 'Edit ' , currentEntry name
]

{ #category : 'accessing' }
ICReferenceBrowser >> entries [

	^ entries ifNil: [ entries := OrderedCollection new ]
]

{ #category : 'accessing' }
ICReferenceBrowser >> entries: aCollection [

	entries := aCollection asOrderedCollection.
	self refreshMessages: entries.
	self refreshCategories.
	entries ifNotEmpty: [ self showEntry: entries first ]
]

{ #category : 'querying' }
ICReferenceBrowser >> entriesInCategory: aCategory [

	^ self entries select: [ :each | each category = aCategory ]
]

{ #category : 'accessing' }
ICReferenceBrowser >> exampleBody [ 
^ exampleBody 
]

{ #category : 'text style' }
ICReferenceBrowser >> exampleColor [

	^ Color blue
]

{ #category : 'text style' }
ICReferenceBrowser >> gateKeywordText [

	^ self text: '!Gate ' color: self keywordColor bold: true
]

{ #category : 'initialization' }
ICReferenceBrowser >> initialize [

	super initialize.
	self initializeLayout.
	self initializeMessageList.
	self initializeCategoryList.
	self initializeDetailPanes.
	self initializeSections
]

{ #category : 'initialization' }
ICReferenceBrowser >> initializeCategoryList [

	categoryList := ToListElement finite.
	categoryList hMatchParent height: 120.
	categoryList nodeBuilder: [ :node :aCategory |
		node addChild: (ToLabel text: aCategory) ].
	categoryList
		addEventHandlerOn: ToListSelectionChangedEvent
		do: [ :event | self onCategorySelectionChanged ]
]

{ #category : 'initialization' }
ICReferenceBrowser >> initializeDetailPanes [

	descriptionBody := ToPane vertical hMatchParent vFitContent.
	exampleBody := ToPane vertical hMatchParent vFitContent
]

{ #category : 'initialization' }
ICReferenceBrowser >> initializeLayout [

	self layout: BlLinearLayout vertical.
	self matchParent.
	self padding: (BlInsets all: 6)
]

{ #category : 'initialization' }
ICReferenceBrowser >> initializeMessageList [

	messageList := ToListElement finite.
	messageList hMatchParent height: 220.
	messageList useScrollbar: true.
	messageList nodeBuilder: [ :node :anEntry |
		node addChild: (ToLabel text: anEntry name) ].
	self initializeSieve.
	messageList
		addEventHandlerOn: ToListSelectionChangedEvent
		do: [ :event | self onMessageSelectionChanged ]
]

{ #category : 'initialization' }
ICReferenceBrowser >> initializeSections [

	self addChild: self newSearchSection.
	self addChild: self newCategoriesSection.
	self addChild: self newMessagesSection.
	self addChild: self newDescriptionSection.
	self addChild: self newExamplesSection
]

{ #category : 'initialization' }
ICReferenceBrowser >> initializeSieve [

	sieve := messageList dataAccessor newSieve.
	sieve filter: [ :anEntry :pattern | anEntry matches: pattern ]
]

{ #category : 'text style' }
ICReferenceBrowser >> keywordColor [

	^ Color red
]

{ #category : 'accessing' }
ICReferenceBrowser >> messageList [ 
^ messageList
]

{ #category : 'text style' }
ICReferenceBrowser >> messageNameColor [

	^ Color magenta
]

{ #category : 'text style' }
ICReferenceBrowser >> messageNameText: aString [

	^ self text: aString color: self messageNameColor bold: true
]

{ #category : 'instance creation' }
ICReferenceBrowser >> newExampleLabelFor: aString [

	^ ToAttributedLabel new text:
		  (self text: aString color: self exampleColor bold: false)
]

{ #category : 'instance creation' }
ICReferenceBrowser >> newRangeLabelFor: aString [

	^ ToAttributedLabel new text: (self
			   text: '    Range ' , aString
			   color: Color gray
			   bold: false)
]

{ #category : 'instance creation' }
ICReferenceBrowser >> newSignatureLabelFor: anEntry [

	^ ToAttributedLabel new text:
		  (self gateKeywordText , (self messageNameText: anEntry name))
]

{ #category : 'querying' }
ICReferenceBrowser >> onCategorySelectionChanged [

	(self selectedIn: categoryList) ifNotNil: [ :aCategory |
		self selectCategory: aCategory ]
]

{ #category : 'querying' }
ICReferenceBrowser >> onMessageSelectionChanged [

	(self selectedIn: messageList) ifNotNil: [ :anEntry |
		self showEntry: anEntry ]
]

{ #category : 'actions' }
ICReferenceBrowser >> playCurrentExample [

	"Hook: send the selected example to Phausto/Faust."

	currentEntry ifNil: [ ^ self ].
	self inform: 'Play ' , currentEntry name
]

{ #category : 'updating' }
ICReferenceBrowser >> refreshCategories [

	categoryList dataAccessor removeAll.
	categoryList dataAccessor addAll: self categoryNames
]

{ #category : 'updating' }
ICReferenceBrowser >> refreshDescriptionFor: anEntry [

	descriptionBody removeChildren.
	descriptionBody addChild: (self newSignatureLabelFor: anEntry).
	anEntry range ifNotNil: [ :aRange |
		descriptionBody addChild: (self newRangeLabelFor: aRange) ].
	descriptionBody addChild: (ToLabel text: anEntry summary)
]

{ #category : 'updating' }
ICReferenceBrowser >> refreshExamplesFor: anEntry [

	exampleBody removeChildren.
	anEntry examples do: [ :each |
		exampleBody addChild: (self newExampleLabelFor: each) ]
]

{ #category : 'updating' }
ICReferenceBrowser >> refreshMessages: aCollection [

	messageList dataAccessor removeAll.
	messageList dataAccessor addAll: aCollection
]

{ #category : 'querying' }
ICReferenceBrowser >> selectedIn: aListElement [

	| indexes |
	indexes := aListElement selectionModel selectedIndexes.
	^ indexes ifEmpty: [ nil ] ifNotEmpty: [
		  aListElement dataAccessor at: indexes first ]
]

{ #category : 'updating' }
ICReferenceBrowser >> showEntry: anEntry [

	currentEntry := anEntry.
	self refreshDescriptionFor: anEntry.
	self refreshExamplesFor: anEntry
]

{ #category : 'accessing' }
ICReferenceBrowser >> sieve [ 
^ sieve
]

{ #category : 'actions' }
ICReferenceBrowser >> stopPlayback [

	"Hook: stop the running synth."

	self inform: 'Stop'
]

{ #category : 'text style' }
ICReferenceBrowser >> text: aString color: aColor bold: aBoolean [

	| rope |
	rope := aString asRopedText.
	rope foreground: aColor.
	aBoolean ifTrue: [ rope bold ].
	^ rope
]
