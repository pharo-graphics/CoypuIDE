baselines
baseline: spec

	<baseline>
	spec for: #common do: [ 
		spec 
			package: 'CoypuIDE';
			package: 'Mooflod'.
		spec
			group: 'core' with: #('CoypuIDE' 'Mooflod');
			group: 'default' with: #('core') ]