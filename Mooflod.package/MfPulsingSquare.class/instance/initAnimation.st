initialization
initAnimation

	anim := BlAnimation new duration: 0.5 seconds.
	anim beInfinite.
		anim addEventHandler: (BlEventHandler
				 on: BlAnimationLoopDoneEvent
				 do: [ :e |
					 self background paint color == Color white
						 ifTrue: [ self background: Color red ]
						 ifFalse: [ self background: Color white ] ]).
	self addAnimation: anim