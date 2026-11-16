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
PhaustoClassReference >> addClasses: aCollection [

	list dataAccessor addAll: (aCollection collect: [ :cls |
			 ToAccordionElement new
				 id: cls name;
				 addAllStamps: { #borderless. #ghost };
				 headerBuilder: [ :header | header addChild: (ToLabel text: cls name) ];
				 bodyBuilder: [ :body |
					 | album |
					 body margin: (BlInsets all: 5).
					 { BlClickEvent. BlDoubleClickEvent } do: [ :eventClass |
						 body addEventHandlerOn: eventClass do: [ :evt | evt consumed: true ] ].
					 album := ToAlbum new
						          withSaveCapability;
						          whenSaveRequestedDo: [ :saveRequested | saveRequested accepted: true ];
						          whenCancelRequestedDo: [ :cancelRequested |
							          cancelRequested editorElement text: cls comment ];
						          hMatchParent;
						          vFitContent;
						          minHeight: 50;
						          yourself.
					 album albumEditorElement constraintsDo: [ :c |
						 c vertical fitContent.
						 c horizontal matchParent ].
					 album infinite constraintsDo: [ :c |
						 c vertical fitContent.
						 c horizontal matchParent ].
					 album text: (Microdown asRichText: (Microdown parse: cls comment)).
					 body addChild: album ];
				 yourself ])
]

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

	super initialize.
	self initializeList.
	self initializeFilterField.
	self initializeTypeCheckboxGroup.
	self initializeCollectionOfClasses.
	self
		beVertical;
		matchParent.
	self addClasses: visibleClasses.
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

	| sieve |
	filterField := ToTextField new.
	filterField margin: (BlInsets all: 2).
	filterField placeholderBuilder: [ :placeholder :e |
		placeholder addChild: ((ToAttributedLabel text: 'Class name filter')
				 foreground: Color lightGray;
				 yourself) ].
	sieve := ToListElementSieve new.
	sieve onInstalledIn: list.
	sieve filter: [ :item :aPattern |
		item id beginsWith: aPattern caseSensitive: false ].
	filterField whenTextEditedDo: [ sieve pattern: filterField text asString ]
]

{ #category : 'initialization' }
PhaustoClassReference >> initializeList [

	list := ToCheckableListElement new.
	list withRowNumbers.
	list selectionMode multiple: true.
	list placeholderBuilder: [ :ph :e |
		ph empty label: ((ToAttributedLabel text: 'No Data')
				 foreground: Color lightGray;
				 fontSize: 24;
				 yourself) ]
]

{ #category : 'initialization' }
PhaustoClassReference >> initializeTypeCbEventHandler [

	group addEventHandlerOn: ToCheckableGroupChangedEvent do: [ :event |
		| type |
		type := event checkedList first id.
		type = #All
			ifTrue: [ self initializeCollectionOfClasses ]
			ifFalse: [ self filterVisibleClassesWithType: type ].
		list dataAccessor removeAll.
		self addClasses: visibleClasses ]
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
