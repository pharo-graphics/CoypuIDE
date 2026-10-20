Class {
	#name : 'ICWidgetFactory',
	#superclass : 'Object',
	#category : 'CoypuIDE-Panel',
	#package : 'CoypuIDE',
	#tag : 'Panel'
}

{ #category : 'private' }
ICWidgetFactory >> widgetFor: anICParameter [
	"The kind was resolved when anICParameter was created: dispatch only."

	^ anICParameter acceptVisitor: self
]
