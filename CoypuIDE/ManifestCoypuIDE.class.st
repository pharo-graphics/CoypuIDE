"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestCoypuIDE',
	#superclass : 'PackageManifest',
	#category : 'CoypuIDE-Manifest',
	#package : 'CoypuIDE',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestCoypuIDE class >> ruleBlocWidthV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#ICPianoNoteElement #initializeEvents #false)) #'2025-01-08T21:49:26.541018+01:00') )
]
