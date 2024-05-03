"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestMooflodPatternWidget,
	#superclass : #PackageManifest,
	#category : #'MooflodPatternWidget-Manifest'
}

{ #category : #'code-critics' }
ManifestMooflodPatternWidget class >> ruleEqualsTrueRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#MfPatternElement #addInstrumentToStep #false)) #'2024-04-23T13:57:11.533133+02:00') )
]
