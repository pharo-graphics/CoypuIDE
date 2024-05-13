as yet unclassified
exampleDefaultPiano

	<script>
	| p |
	p := MfPianoElement new
		     nOctaves: 2;
		     startNote: 'E'.
	p openPiano: p