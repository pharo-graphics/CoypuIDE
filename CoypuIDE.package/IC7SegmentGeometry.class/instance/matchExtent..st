geometry
matchExtent: anExtent

	extent := anExtent.
	vertices := isVertical
		            ifTrue: [
			            {
				            (0 @ (1 / 12 * anExtent y)).
				            (anExtent x / 2 @ (-1 / 12 * anExtent y)).
				            (anExtent x @ (1 / 12 * anExtent y)).
				            (anExtent x @ (11 / 12 * anExtent y)).
				            (anExtent x / 2 @ (13 / 12 * anExtent y)).
				            (0 @ (11 / 12 * anExtent y)) } ]
		            ifFalse: [
			            {
				            (1 / 12 * anExtent x @ 0).
				            (11 / 12 * anExtent x @ 0).
				            (13 / 12 * anExtent x @ (anExtent y / 2)).
				            (11 / 12 * anExtent x @ anExtent y).
				            (1 / 12 * anExtent x @ anExtent y).
				            (-1 / 12 * anExtent x @ (anExtent y / 2)) } ]