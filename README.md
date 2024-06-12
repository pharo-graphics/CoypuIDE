# CoypuIDE


<a href="https://www.pharo.org">
    <img alt="Pharo" src="https://img.shields.io/static/v1?style=for-the-badge&message=Pharo&color=3297d4&logo=Harbor&logoColor=FFFFFF&label=" />
</a>

### Loading latest development version

```Smalltalk
Metacello new
	baseline: 'CoypuIDE';
	repository: 'github://pillar-markup/CoypuIDE/';
	onConflict: [ :ex | ex useIncoming ];
	onUpgrade: [ :ex | ex useIncoming ];
	load.
 ```
