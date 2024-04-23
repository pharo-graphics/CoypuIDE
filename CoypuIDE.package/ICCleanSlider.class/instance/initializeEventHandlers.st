initialization
initializeEventHandlers

	self isSliderBuilt ifFalse: [
		^ self error: 'The slider must be built first' ].
	eventHandler ifNotNil: [ ^ self ].
	self flag: #toClean. "to be cleaned after"
	
	eventHandler := BlCleanSliderHandler new.
	self  addEventHandler: eventHandler
	
