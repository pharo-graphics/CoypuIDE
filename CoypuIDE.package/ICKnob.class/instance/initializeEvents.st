initialization
initializeEvents

	self addEventHandlerOn: BlKeyDownEvent do: [ :e |
		e key name = #LEFT ifTrue: [
			self knob transformDo: [ :t |
				self angle: self angle - 15.
				t rotateBy: angle ] ].
		e key name = #RIGHT ifTrue: [
			self knob transformDo: [ :t |
				self angle: self angle + 15.
				t rotateBy: angle ] ] ].
	self
		addEventHandlerOn: BlClickEvent
		do: [ :e | self clickAt: e position ].
	self addEventHandlerOn: BlDragStartEvent do: [ :event | event consumed: true. self clickAt: event position ].
	self addEventHandlerOn: BlDragEvent do: [ :event | self clickAt: event position ].  
	self requestFocus