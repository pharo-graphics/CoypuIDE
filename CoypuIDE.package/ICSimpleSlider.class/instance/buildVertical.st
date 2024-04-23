as yet unclassified
buildVertical

	widgetSize y > widgetSize x ifFalse: [
		self widgetSize: widgetSize y @ widgetSize x ].

	self removeParts.
	self initializeParts