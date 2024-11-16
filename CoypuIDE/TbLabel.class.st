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

{ #category : 'examples' }
TbLabel class >> LabelExample [
	<script>
	| container e0 e1  e2 e3|
	container:= BlElement new
		
		geometry: BlRectangleGeometry new;
		layout: (BlGridLayout new
		columnCount: 1;
		cellSpacing: 4
		);
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent.
			];
		"background: Color white ."
		background: (Color r: 233 g:224  b:208  range:255).

e0:=TbLabel new.
e1:=TbLabel_BassLine new.
e2:=TbLabel_Phausto new.
e3:=TbLabel_TP33 new.
container addChildren: {e0. e1. e2. e3}.
container openInSpace.
	
]

{ #category : 'initialization' }
TbLabel >> configuredString: aString [ 
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: self fontColor) . 
	"(BlFontWeightAttribute bold) . "
	(BlFontEmphasisAttribute italic).
	(BlFontSizeAttribute size:self fontSize) }
	
"configuredString: aString 
	^ aString asRopedText italic foreground: self fontColor; defaultFontSize: 40."

]

{ #category : 'initialization' }
TbLabel >> configuredString: aString size: anInteger [
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: self fontColor ) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:anInteger)}.
]

{ #category : 'initialization' }
TbLabel >> configuredStringDark: aString [ 
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: self fontColor) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:35) }
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
TbLabel >> fontSize [
	^40.
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
	
	"labelText := 'Sample' asRopedText
 						foreground: self fontColor;
 						fontSize: 40;
						fontName: 'Inria Serif'.
 						
	label := BlTextElement new;
				text: labelText."
				
	label := BlTextElement new;
				text: (self configuredString: 'SAMple' ).
				
	"label := BlAttributedTextElement new.
	label text: 'SAMple' asRopedText ;
				fontSize:18;
				bold."
	
				
	label constraintsDo:[:c | c frame horizontal alignCenter. c frame vertical alignCenter].
	
	

		
	
	self addChildren: { label}.
	
	
]

{ #category : 'initialization' }
TbLabel >> initializeLayout [
	self background: (Color gray alpha:0.0).
	self padding: (BlInsets  top:1 left:1  bottom:1  right:1 ).
	self size: self widgetSize.
	self layout: BlFrameLayout new.


]

{ #category : 'initialization' }
TbLabel >> initializeSize [
	self widgetSize: 400@80.
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
