Class {
	#name : 'ICCleanSliderHandler',
	#superclass : 'BlCustomEventHandler',
	#category : 'CoypuIDE-Attic',
	#package : 'CoypuIDE',
	#tag : 'Attic'
}

{ #category : 'event management' }
ICCleanSliderHandler >> clickEvent: anEvent [

	anEvent currentTarget sliderBarClicked: anEvent
]

{ #category : 'event management' }
ICCleanSliderHandler >> dragEndEvent: anEvent [

	anEvent currentTarget sliderHandleReleased
]

{ #category : 'event management' }
ICCleanSliderHandler >> eventsToHandle [
	^ { BlMouseDownEvent . BlDragEndEvent . BlMouseUpEvent . BlMouseMoveEvent . BlClickEvent}
]

{ #category : 'event management' }
ICCleanSliderHandler >> mouseDownEvent: anEvent [

	anEvent currentTarget sliderHandlePushed: anEvent
]

{ #category : 'event management' }
ICCleanSliderHandler >> mouseMoveEvent: anEvent [

	anEvent currentTarget sliderHandleMoved: anEvent
]

{ #category : 'event management' }
ICCleanSliderHandler >> mouseUpEvent: anEvent [

	anEvent currentTarget sliderHandleReleased
]
