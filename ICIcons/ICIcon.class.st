Class {
	#name : 'ICIcon',
	#superclass : 'BlElement',
	#instVars : [
		'color',
		'background',
		'backgroundColor'
	],
	#category : 'ICIcons',
	#package : 'ICIcons'
}

{ #category : 'accessing' }
ICIcon >> backgroundColor [
	^ backgroundColor
]

{ #category : 'accessing' }
ICIcon >> backgroundColor: aColor [ 
	backgroundColor := aColor.
	self initializeIcon 
]

{ #category : 'accessing' }
ICIcon >> defaultBackColor [
	^(Color r:255 g:255 b:255 range:255)
]

{ #category : 'accessing' }
ICIcon >> defaultDarkBackColor [
	^(Color r:35 g:35 b:37 range:255)

]

{ #category : 'accessing' }
ICIcon >> defaultDarkLineColor [
	^(Color r:20 g:225 b:167 range:255)

]

{ #category : 'accessing' }
ICIcon >> defaultLineColor [
	^ (Color black)

]

{ #category : 'initialization' }
ICIcon >> initialize [ 
super initialize .
backgroundColor := Color white 
]

{ #category : 'initialization' }
ICIcon >> initializeBackColor [
	"background:= self defaultDarkBackColor."
	background:= self defaultBackColor.

]

{ #category : 'initialization' }
ICIcon >> initializeIcon [

self subclassResponsibility 
]

{ #category : 'initialization' }
ICIcon >> initializeLineColor [
	"color:= self defaultDarkLineColor."
	color:= self defaultLineColor.
]

{ #category : 'initialization' }
ICIcon >> initializeSize [
	self size: 80@80.
]
