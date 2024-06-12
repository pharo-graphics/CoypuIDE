initialization
initializeWhiteHandlers

	whitenotes do: [ :n |
		n
			addEventHandlerOn: BlMouseDownEvent
			do: [ :evt | n background: Color lightGray ].
		n
			addEventHandlerOn: BlMouseUpEvent
			do: [ :evt | n background: whiteKeyColor ].
		n
			addEventHandlerOn: BlMouseLeaveEvent
			do: [ :evt | n background: whiteKeyColor ] ]