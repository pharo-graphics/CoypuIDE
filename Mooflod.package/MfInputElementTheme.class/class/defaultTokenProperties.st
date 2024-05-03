accessing
defaultTokenProperties
"define here token properties of the widget theme"
	^ super defaultTokenProperties , {
		  (ToTokenProperty
			   name: #'background-color'
			   value: (Color lightGreen  ))}.