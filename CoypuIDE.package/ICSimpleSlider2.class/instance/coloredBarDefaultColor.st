as yet unclassified
coloredBarDefaultColor
	"^ Color green alpha: 0.4"
	|direc|
	direc:= self 
		ifHorizontal: [ 1 @ 0 ]
		ifVertical: [ 0 @ -1 ].
	^ ((BlLinearGradientPaint direction:direc ) from: Color
	blue to: (Color green)).