examples
animatedExample

	<script>
	| elt |
	elt := self new.

	elt openInSpace.

	0 to: 9 do: [ :i |
		1 second wait.
		elt digit: i ].
	1 second wait. 
	elt digit: nil