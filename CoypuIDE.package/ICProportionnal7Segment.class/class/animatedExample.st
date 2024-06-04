examples
animatedExample

	<script>
	| space elt |
	space := BlSpace new extent: 120 @ 250.
	elt := self new.

	elt constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	space root addChild: elt.
	space show.

	0 to: 9 do: [ :i |
		1 second wait.
		elt digit: i ].
	1 second wait.
	elt digit: nil