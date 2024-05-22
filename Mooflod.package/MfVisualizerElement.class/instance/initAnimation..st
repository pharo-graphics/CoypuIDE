as yet unclassified
initAnimation: nbSteps

	anim := BlAnimation new duration: (nbSteps / 4) seconds.
	anim addEventHandler: (BlEventHandler
			 on: BlAnimationLoopDoneEvent
			 do: [ :e | self cleanVisualizer ]).
	self addAnimation: anim