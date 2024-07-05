Class {
	#name : 'BaselineOfCoypuIDE',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfCoypuIDE',
	#package : 'BaselineOfCoypuIDE'
}

{ #category : 'baselines' }
BaselineOfCoypuIDE >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			baseline: 'Toplo'
			with: [
			spec repository: 'github://pharo-graphics/Toplo:master/src' ].
		spec
			baseline: 'Phausto'
			with: [ spec repository: 'github://lucretiomsp/Phausto:main/' ].
		spec
			baseline: 'Coypu'
			with: [ spec repository: 'github://lucretiomsp/Coypu/' ].

		spec
			package: 'CoypuIDE' with: [ spec requires: 'Toplo' ];
			package: 'Mooflod' with: [ spec requires: #('Toplo' 'Coypu') ];
			package: 'ICIcons' with: [ spec requires: 'Toplo' ].
		spec
			group: 'core' with: #( 'CoypuIDE' 'Mooflod' 'ICIcons' );
			group: 'default' with: #( 'core' ) ]
]
