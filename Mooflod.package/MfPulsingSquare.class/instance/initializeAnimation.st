initialization
initializeAnimation

	flashingAnimation := BlAnimation new duration: 0.5 seconds.
	flashingAnimation beInfinite.
	flashingAnimation addEventHandler: (BlEventHandler
			 on: BlAnimationLoopDoneEvent
			 do: [ :e |
				 self background paint color = Color white
					 ifTrue: [ self background: Color red ]
					 ifFalse: [ self background: Color white ] ]).
	self addAnimation: flashingAnimation