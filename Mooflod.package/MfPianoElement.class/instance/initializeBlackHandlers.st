initialization
initializeBlackHandlers

	blacknotes do: [ :n |
		n
			addEventHandlerOn: BlMouseDownEvent
			do: [ :evt | n background: Color lightGray ].
		n
			addEventHandlerOn: BlMouseUpEvent
			do: [ :evt | n background: blackKeyColor ].
		n
			addEventHandlerOn: BlMouseLeaveEvent
			do: [ :evt | n background: blackKeyColor ] ]