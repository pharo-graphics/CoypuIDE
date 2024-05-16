as yet unclassified
fullExample

	<script>
	| container |
	container := BlElement new
		             layout: BlLinearLayout horizontal;
		             constraintsDo: [ :c |
			             c vertical fitContent.
			             c horizontal fitContent ].

	container addChild: self new.
	0 to: 10 do: [ :i | container addChild: (self new digit: i) ].

	container openInSpace