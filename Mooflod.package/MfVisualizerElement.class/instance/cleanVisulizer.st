as yet unclassified
cleanVisulizer

	self childrenDo: [ :c | c childrenDo: [ :cc | cc removeFromParent ]. ]