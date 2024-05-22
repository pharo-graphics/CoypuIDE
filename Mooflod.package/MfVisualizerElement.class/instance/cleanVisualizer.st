as yet unclassified
cleanVisualizer

	self childrenDo: [ :c | c childrenDo: [ :cc | cc removeFromParent ] ]