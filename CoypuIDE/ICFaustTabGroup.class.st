Class {
	#name : 'ICFaustTabGroup',
	#superclass : 'BlElement',
	#instVars : [
		'tabBar',
		'pagesFrame',
		'tabs',
		'pages',
		'selectedIndex'
	],
	#category : 'CoypuIDE-FaustUI',
	#package : 'CoypuIDE',
	#tag : 'FaustUI'
}

{ #category : 'accessing' }
ICFaustTabGroup >> addTab: aString page: anElement [
	"the first tab added is the one shown"

	| tab index |
	index := tabs size + 1.
	tab := BlTextElement new
		       text: (aString asRopedText
				        fontSize: 14;
				        foreground: Color white;
				        bold;
				        yourself);
		       padding: (BlInsets
				        top: 4
				        left: 12
				        bottom: 4
				        right: 12);
		       geometry: (BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new
					         topLeft: 4;
					         topRight: 4;
					         bottomLeft: 0;
					         bottomRight: 0;
					         yourself));
		       yourself.
	tab addEventHandlerOn: BlClickEvent do: [ :event |
			event consume.
			self selectTab: index ].
	tabs add: tab.
	pages add: anElement.
	tabBar addChild: tab.
	pagesFrame addChild: anElement.
	self selectTab: (selectedIndex = 0
			 ifTrue: [ 1 ]
			 ifFalse: [ selectedIndex ])
]

{ #category : 'accessing' }
ICFaustTabGroup >> initialize [
	"a Faust tgroup: a row of tabs above one page shown at a time. Every page stays in the frame (hidden ones invisible and deaf to the mouse), so the group is as big as its biggest page and does not jump when switching"

	super initialize.
	tabs := OrderedCollection new.
	pages := OrderedCollection new.
	selectedIndex := 0.
	tabBar := BlElement new
		          layout: (BlLinearLayout horizontal cellSpacing: 2);
		          constraintsDo: [ :c |
				          c horizontal fitContent.
				          c vertical fitContent ];
		          yourself.
	pagesFrame := BlElement new
		              layout: BlFrameLayout new;
		              constraintsDo: [ :c |
				              c horizontal fitContent.
				              c vertical fitContent ];
		              border: (BlBorder paint: Color orange darker darker width: 1);
		              yourself.
	self
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
				c horizontal fitContent.
				c vertical fitContent ];
		addChild: tabBar;
		addChild: pagesFrame
]

{ #category : 'accessing' }
ICFaustTabGroup >> pages [

	^ pages
]

{ #category : 'accessing' }
ICFaustTabGroup >> selectTab: anInteger [

	selectedIndex := anInteger.
	tabs doWithIndex: [ :tab :i |
			tab background: (i = anInteger
					 ifTrue: [ Color orange darker darker ]
					 ifFalse: [ Color veryDarkGray ]) ].
	pages doWithIndex: [ :page :i |
			i = anInteger
				ifTrue: [
						page
							visibility: BlVisibility visible;
							allowMouseEvents ]
				ifFalse: [
						page
							visibility: BlVisibility hidden;
							preventMouseEvents ] ]
]

{ #category : 'accessing' }
ICFaustTabGroup >> selectedIndex [

	^ selectedIndex
]

{ #category : 'accessing' }
ICFaustTabGroup >> selectedPage [

	^ selectedIndex = 0
		  ifTrue: [ nil ]
		  ifFalse: [ pages at: selectedIndex ]
]

{ #category : 'accessing' }
ICFaustTabGroup >> tabLabels [

	^ tabs collect: [ :each | each text asString ]
]

{ #category : 'accessing' }
ICFaustTabGroup >> tabs [
	"the tab elements, in order"

	^ tabs
]
