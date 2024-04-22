private
removeEventHandler

	eventHandler ifNil: [ ^ self ].
	self flag: #toClean. "we should not test this"
	
	self removeEventHandler: eventHandler.
	eventHandler := nil.
	