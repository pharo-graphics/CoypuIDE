"
I am the button that goes with ICSimpleKnob: white when on, with a black label and a white glow; very dark gray when off. Same API as ICLabelButton:

```language=Pharo
	(ICSimpleButton label: 'GATE') isToggleable: true; callback: [ :v | v traceCr ]; yourself
```
"
Class {
	#name : 'ICSimpleButton',
	#superclass : 'ICLabelButton',
	#category : 'CoypuIDE-button',
	#package : 'CoypuIDE',
	#tag : 'button'
}

{ #category : 'size' }
ICSimpleButton >> applyButtonSize [
	"fitsContent false: the pill fills my widgetSize (minus padding), the label stays centered in it"

	super applyButtonSize.
	self fitsContent ifFalse: [
			button constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : 'size' }
ICSimpleButton >> backColor [
	"invisible on a black panel: only the pill shows"

	^ Color black
]

{ #category : 'accessing' }
ICSimpleButton >> buttonColor [

	^ Color white
]

{ #category : 'accessing' }
ICSimpleButton >> glowColor [

	^ Color white
]

{ #category : 'size' }
ICSimpleButton >> initializeWidget [
	"a frame, so the pill can fill me when I do not fit my content"

	super initializeWidget.
	self layout: BlFrameLayout new
]
