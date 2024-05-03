as yet unclassified
updateAnnulusAngle: newAngle

	annulus geometry: (BlAnnulusSectorGeometry new
			 startAngle: 0;
			 endAngle: newAngle;
			 innerRadius: 0.865)