Class {
	#name : 'CoypuBlocLogger',
	#superclass : 'SignalLogger',
	#instVars : [
		'view'
	],
	#category : 'CoypuIDE-Logging',
	#package : 'CoypuIDE',
	#tag : 'Logging'
}

{ #category : 'accessing' }
CoypuBlocLogger class >> view: aLogElement [
	^ self new
		setView: aLogElement;
		yourself
]

{ #category : 'logging' }
CoypuBlocLogger >> nextPut: aSignal [
	view addEntry: aSignal
]

{ #category : 'initialization' }
CoypuBlocLogger >> setView: aLogElement [
	view := aLogElement
]
