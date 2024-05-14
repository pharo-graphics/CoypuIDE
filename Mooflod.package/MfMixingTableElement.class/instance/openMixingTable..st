as yet unclassified
openMixingTable: aTable
"create a space to display the mixing table widget"
	| space |
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	aTable transformDo: [ :c | c translateBy: 180 @ 150 ].
	space root addChild: aTable.
	space toTheme: MfMixingTableTheme new.
	space applyAllSkinInstallers.
	space show.
	^ aTable