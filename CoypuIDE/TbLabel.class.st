Class {
	#name : 'TbLabel',
	#superclass : 'BlElement',
	#instVars : [
		'widgetSize',
		'inputText',
		'fontColor'
	],
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'as yet unclassified' }
TbLabel class >> LabelExample [
	<script>
	| container e1  |
	container:= BlElement new
		
		geometry: BlRectangleGeometry new;
		layout: (BlGridLayout new
		columnCount: 6;
		cellSpacing: 2
		);
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent.
			];
		"background: Color white ."
		background: (Color r: 249 g:239  b:224  range:255).

e1:=TbLabel new.

container addChildren: { e1}.
container openInSpace.
	
]

{ #category : 'initialization' }
TbLabel >> fontColor [
	^fontColor.
]

{ #category : 'initialization' }
TbLabel >> fontColor: aColor [
	fontColor:= aColor.
]

{ #category : 'initialization' }
TbLabel >> initialize [

	super initialize.
	self initializeSize.
	self initializeLayout.
	self initializeLabel.

]

{ #category : 'initialization' }
TbLabel >> initializeLabel [
	|labelText label|
	self fontColor: Color veryVeryDarkGray.
	
	labelText := 'Sample' asRopedText
 						foreground: self fontColor;
 						fontSize: 26;
 						"fontName: 'Helvetica';"
						"fontName:'Cascadia Code';"
 						bold.
 	
	label := BlTextElement new;
				text: labelText.
	label constraintsDo:[:c | c frame horizontal alignCenter. c frame vertical alignCenter].
	
	

		
	
	self addChildren: { label}.
	
	
]

{ #category : 'initialization' }
TbLabel >> initializeLayout [
	self background: (Color gray alpha:0.1).
	self padding: (BlInsets  top:1 left:1  bottom:1  right:1 ).
	self size: self widgetSize.
	self layout: BlFrameLayout new.


]

{ #category : 'initialization' }
TbLabel >> initializeSize [
	self widgetSize: 200@60.
]

{ #category : 'initialization' }
TbLabel >> inputText [
	^inputText.
]

{ #category : 'initialization' }
TbLabel >> inputText: aString [
	inputText:= aString.
]

{ #category : 'initialization' }
TbLabel >> widgetSize [
	^ widgetSize.
]

{ #category : 'initialization' }
TbLabel >> widgetSize: aSize [
	widgetSize := aSize.
]
