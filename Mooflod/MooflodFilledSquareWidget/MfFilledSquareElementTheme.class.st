Class {
	#name : #MfFilledSquareElementTheme,
	#superclass : #ToRawTheme,
	#category : #MooflodFilledSquareWidget
}

{ #category : #accessing }
MfFilledSquareElementTheme class >> defaultTokenProperties [
	"define here token properties of the widget theme"

	^ super defaultTokenProperties
	  ,
	  { (ToTokenProperty name: #'background-color' value: Color lightRed) }
]
