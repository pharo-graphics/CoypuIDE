"
Search and see the documentation for Phausto classes.

```language=pharo
ref := PhaustoClassReference new.
ref openInSpace
```
"
Class {
	#name : 'PhaustoClassReference',
	#superclass : 'ToPane',
	#instVars : [
		'filterField',
		'list',
		'group',
		'visibleClasses'
	],
	#category : 'CoypuIDE-reference',
	#package : 'CoypuIDE',
	#tag : 'reference'
}

{ #category : 'initialization' }
PhaustoClassReference >> filterVisibleClassesWithType: aSymbol [

	visibleClasses := Smalltalk globals allClasses select: [ :c |
		                  c packageTag name = aSymbol ]
]

{ #category : 'accessing' }
PhaustoClassReference >> group [

^ group 
]

{ #category : 'initialization' }
PhaustoClassReference >> initialize [

	| phaustoClasses |
	"reject: [ :cls | cls comment isEmpty ]""list selectionOption masked: true."
	super initialize.
	self initializeList.
	self initializeFilterField.
	self initializeTypeCheckboxGroup.
	self initializeCollectionOfClasses .

	self
		beVertical;
		matchParent.

	phaustoClasses := Smalltalk globals allClasses select: [ :c |
		                  c package name = #Phausto ].
	list dataAccessor addAll: visibleClasses.
	list matchParent.
	self addChild: list.
	self addChild: filterField.
	self addChildren: self group registeredCheckables
]

{ #category : 'initialization' }
PhaustoClassReference >> initializeCollectionOfClasses [

	visibleClasses := Smalltalk globals allClasses select: [ :c |
		                  c package name = #Phausto ]
]

{ #category : 'initialization' }
PhaustoClassReference >> initializeFilterField [

	|  sieve |
	filterField := ToTextField new.
	filterField margin: (BlInsets all: 2).
	filterField placeholderBuilder: [ :placeholder :e |
		placeholder addChild:
			((ToAttributedLabel text: 'Class name filter')
				 foreground: Color lightGray;
				 yourself) ].
			sieve := ToListElementSieve new.
	sieve onInstalledIn: list.
	sieve dataFilter: [ :item :aPattern |
		item name beginsWith: aPattern caseSensitive: false ].
	filterField whenTextEditedDo: [
		| pattern |
		pattern := filterField text asString.
		sieve pattern: pattern ].
	
]

{ #category : 'initialization' }
PhaustoClassReference >> initializeList [

	list := ToAccordionListElement new.
	list withRowNumbers.
	list selectionMode multiple: true.

	list placeholderBuilder: [ :ph :e |
		| lab |
		ph layout alignCenter.
		lab := (ToAttributedLabel text: 'No Data')
			       foreground: Color lightGray;
			       fontSize: 24;
			       yourself.
		ph addChild: lab ].
	list itemBuilder: [ :item :cls :holder |
		item addAllStamps: { #borderless. #ghost }.
		item
			headerBuilder: [ :header |
				header addChild:
						(ToLabel text: cls name) preventSelectionSkinEvents ];
			bodyBuilder: [ :body |
				| album |
				body margin: (BlInsets all: 5).
				album := ToAlbum new
					         withSaveCapability;
					         whenSaveRequestedDo: [ :saveRequested |
						         saveRequested accepted: true ];
					         whenCancelRequestedDo: [ :cancelRequested |
						         cancelRequested editorElement text: cls comment ];
					         yourself.
				album hMatchParent.
				album vFitContent.
				album next constraintsDo: [ :c |
					c vertical fitContent.
					c horizontal matchParent ].
				album infinite constraintsDo: [ :c |
					c vertical fitContent.
					c horizontal matchParent ].
				album minHeight: 50.
				album text: cls comment.
				body addChild: album ];
			yourself ].
	
	
]

{ #category : 'initialization' }
PhaustoClassReference >> initializeTypeCbEventHandler [

| eventLabel |
	group addEventHandler: (BlEventHandler
			 on: ToCheckableGroupChangedEvent
			 do: [ :event |			 
				 eventLabel := (event checkedList at: 1) label text asString asSymbol.
				 self list dataAccessor removeAll.
				 eventLabel = #All ifTrue:
				 [self initializeCollectionOfClasses .
				 self list dataAccessor addAll: visibleClasses ] ifFalse: [  self filterVisibleClassesWithType: eventLabel . self list dataAccessor addAll: visibleClasses ]
				
				
				 ])
]

{ #category : 'initialization' }
PhaustoClassReference >> initializeTypeCheckboxGroup [

	| buttons labels |
	labels := #( 'All' 'Oscillators' 'Envelopes' 'Synths' 'UIPrimitives'
	             'PhysicalModels' 'ToolKit' 'Demo' 'Filters' 'Effects'
	             'TurboPhausto' ).
	group := ToCheckableGroup new.
	buttons := OrderedCollection new.
	1 to: labels size do: [ :idx |
		| chb |
		chb := ToCheckbox new
			       beEndToStart;
			       labelText: (labels at: idx);
			       id: (labels at: idx).
		buttons add: chb ].
	buttons second checked: true.
	group registerAll: buttons.
	self initializeTypeCbEventHandler
]

{ #category : 'accessing' }
PhaustoClassReference >> list [

^ list
]
