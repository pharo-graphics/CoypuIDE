initialization
initAnimation

	anim := BlAnimation new
		        duration: 0.5 seconds;
		        loops: 10000.
	anim addEventHandler: (BlEventHandler
			 on: BlAnimationLoopDoneEvent
			 do: [ :e |
				 self background paint color == Color white
					 ifTrue: [ self background: Color red ]
					 ifFalse: [ self background: Color white ] ]).
	self addAnimation: anim