Class {
	#name : 'TbLEDDarkButton',
	#superclass : 'TbButton',
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'evaluating' }
TbLEDDarkButton >> backColor [
	^ (Color veryVeryDarkGray alpha:1.0)
	"^ (Color r: 249 g:239  b:224  range:255)"
]

{ #category : 'evaluating' }
TbLEDDarkButton >> shadowColor [
	^ (Color orange alpha:0.2)
]
