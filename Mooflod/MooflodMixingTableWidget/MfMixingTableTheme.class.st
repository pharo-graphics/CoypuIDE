Class {
	#name : #MfMixingTableTheme,
	#superclass : #ToRawTheme,
	#category : #MooflodMixingTableWidget
}

{ #category : #accessing }
MfMixingTableTheme class >> defaultTokenProperties [
	"define here token properties of the widget theme"

	^ super defaultTokenProperties
	  ,
	  { (ToTokenProperty name: #'background-color' value: Color veryPaleRed ) }
]
