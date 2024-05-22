as yet unclassified
initAnimation: nbSteps

	anim := BlAnimation new duration: nbSteps.
	anim beInfinite.
	anim addEventHandler: (BlEventHandler
			 on: BlAnimationLoopDoneEvent
			 do: [ :e |
				 self cleanVisualizer  ]).
	self addAnimation: anim