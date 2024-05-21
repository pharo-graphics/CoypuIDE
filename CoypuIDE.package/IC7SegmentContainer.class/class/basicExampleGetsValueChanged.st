examples
basicExampleGetsValueChanged

	<script>
	| elt |
	elt := self new
		       value: 12345;
		       openInSpace;
		       yourself.
		
	1 second wait.
	elt value: 12.