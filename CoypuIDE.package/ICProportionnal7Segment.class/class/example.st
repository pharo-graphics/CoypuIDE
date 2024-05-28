examples
example

	<script>
	| space segment |
	space := BlSpace new extent: 120 @ 250.
	segment := ICProportionnal7Segment new digit: 5.

	segment constraintsDo: [ :c |
		c vertical matchParent.
		c horizontal matchParent ].

	space root addChild: segment.

	space show