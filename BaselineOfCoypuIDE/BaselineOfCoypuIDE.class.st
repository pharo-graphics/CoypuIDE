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
        "Declaring application packages"
        spec package: 'CoypuIDE'.
        spec package: 'ICIcons'.

         "External Dependencies"
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
            baseline: 'MoofLODforPharo'
            with: [ spec repository: 'github://lucretiomsp/MoofLODforPharo/' ].

        "Linkink external dependencies"
        spec
            package: 'CoypuIDE' with: [ spec requires: 'Toplo' 'MoofLODforPharo' 'Phausto' ];
            package: 'ICIcons' with: [ spec requires: 'Toplo' ].

        "Baseline groups"
        spec
            group: 'core' with: #( 'CoypuIDE' 'ICIcons' );
            group: 'default' with: #( 'core' ) ]
]
