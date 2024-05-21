as yet unclassified
openVisualizer: aVisualizer

| space |
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	 aVisualizer
transformDo: [ :c | c translateBy: 200 @ 150 ].
	space root addChild: aVisualizer
.
	space show.
	^ aVisualizer
