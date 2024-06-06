as yet unclassified
exampleDefaultPiano

	<script>
	| p |
	p := MfPianoElement new
		     nOctaves: 2;
		     startNote: 'F'.
	p openPiano: p