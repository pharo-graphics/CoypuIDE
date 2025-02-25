Class {
	#name : 'PhaustoClassReference',
	#superclass : 'ToPane',
	#category : 'CoypuIDE-reference',
	#package : 'CoypuIDE',
	#tag : 'reference'
}

{ #category : 'initialization' }
PhaustoClassReference >> initialize [

	| filterField list sieve pane phaustoClasses |
	super initialize.
	self
		beVertical;
		matchParent.
	filterField := ToTextField new.
	filterField margin: (BlInsets all: 2).
	filterField placeholderBuilder: [ :placeholder :e |
		placeholder addChild:
			((ToAttributedLabel text: 'Class name filter')
				 foreground: Color lightGray;
				 yourself) ].
	list := ToAccordionListElement new.
	list withRowNumbers.
	list selectionMode multiple: true.
	sieve := ToListElementSieve new.
	sieve onInstalledIn: list.
	sieve dataFilter: [ :item :aPattern |
		item name beginsWith: aPattern caseSensitive: false ].

	filterField whenTextEditedDo: [
		| pattern |
		pattern := filterField text asString.
		sieve pattern: pattern ].

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
   
   phaustoClasses := Smalltalk globals allClasses select: [ :c | c package name = #Phausto ].
	list dataAccessor addAll: phaustoClasses . "reject: [ :cls | cls comment isEmpty ]"
	"list selectionOption masked: true."
	list matchParent.

	self  addChild: list.
	self addChild: filterField
]
