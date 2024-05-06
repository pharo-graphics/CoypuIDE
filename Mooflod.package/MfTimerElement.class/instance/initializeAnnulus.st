initialization
initializeAnnulus

	annulus := BlElement new background: Color lightOrange.
	annulus size: 300 @ 300.
	annulus geometry: self annulusGeometry.
	annulus constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	self addChild: annulus.
	self initAnimation 