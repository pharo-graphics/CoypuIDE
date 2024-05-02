examples
basicExample 

	<script> 
	
	| knob |
	knob := self new position: 100@100.

knob openInSpace.

knob callBack: [ :v | v inspect ]