"
I am a parser for AIFF (audio interchange file format) files. I can read uncompressed 8-bit and 16-bit mono, stereo, or multichannel AIFF files. I am a copy of the AIFFFileReader class of the Pharo-Sound package. mmade for convenience.

"
Class {
	#name : 'AiffFileReader',
	#superclass : 'Object',
	#instVars : [
		'in',
		'fileType',
		'channelCount',
		'frameCount',
		'bitsPerSample',
		'samplingRate',
		'channelData',
		'channelDataOffset',
		'markers',
		'pitch',
		'gain',
		'isLooped',
		'skipDataChunk',
		'mergeIfStereo'
	],
	#category : 'CoypuIDE-oscilloscope',
	#package : 'CoypuIDE',
	#tag : 'oscilloscope'
}

{ #category : 'accessing' }
AiffFileReader >> bitsPerSample [

	^ bitsPerSample

]

{ #category : 'accessing' }
AiffFileReader >> channelCount [

	^ channelCount

]

{ #category : 'accessing' }
AiffFileReader >> channelData [

	^ channelData

]

{ #category : 'accessing' }
AiffFileReader >> channelDataOffset [

	^ channelDataOffset

]

{ #category : 'accessing' }
AiffFileReader >> frameCount [

	^ frameCount

]

{ #category : 'accessing' }
AiffFileReader >> gain [

	^ gain

]

{ #category : 'accessing' }
AiffFileReader >> isLooped [

	^ isLooped

]

{ #category : 'accessing' }
AiffFileReader >> isStereo [

	^ channelData size = 2

]

{ #category : 'accessing' }
AiffFileReader >> leftSamples [

	^ channelData at: 1

]

{ #category : 'accessing' }
AiffFileReader >> loopEnd [

	^ markers last last

]

{ #category : 'accessing' }
AiffFileReader >> loopLength [

	^ markers last last - markers first last

]

{ #category : 'accessing' }
AiffFileReader >> markers [

	^ markers

]

{ #category : 'accessing' }
AiffFileReader >> pitch [

	^ pitch

]

{ #category : 'other' }
AiffFileReader >> pitchForKey: midiKey [
	"Convert my MIDI key number to a pitch and return it."

	| indexInOctave octave p |
	indexInOctave := (midiKey \\ 12) + 1.
	octave := (midiKey // 12) + 1.
	"Table generator: (0 to: 11) collect: [:i | 16.3516 * (2.0 raisedTo: i asFloat / 12.0)]"
	p := #(16.3516 17.32391 18.35405 19.44544 20.60173 21.82677
		  23.12466 24.49972 25.95655 27.50000 29.13524 30.86771) at: indexInOctave.
	^ p * (#(0.5 1.0 2.0 4.0 8.0 16.0 32.0 64.0 128.0 256.0 512.0) at: octave)

]

{ #category : 'private' }
AiffFileReader >> readChunk: chunkType size: chunkSize [
	"Read a AIFF chunk of the given type. Skip unrecognized chunks. Leave the input stream positioned chunkSize bytes past its position when this method is called."

	chunkType = 'COMM' ifTrue: [^ self readCommonChunk: chunkSize].
	chunkType = 'SSND' ifTrue: [^ self readSamplesChunk: chunkSize].
	chunkType = 'INST' ifTrue: [^ self readInstrumentChunk: chunkSize].
	chunkType = 'MARK' ifTrue: [^ self readMarkerChunk: chunkSize].
	in skip: chunkSize.  "skip unknown chunks"

]

{ #category : 'private' }
AiffFileReader >> readCommonChunk: chunkSize [
	"Read a COMM chunk. All AIFF files have exactly one chunk of this type."

	| compressionType |
	channelCount := in nextNumber: 2.
	frameCount := in nextNumber: 4.
	bitsPerSample := in nextNumber: 2.
	samplingRate := self readExtendedFloat.
	chunkSize > 18 ifTrue: [
		fileType = 'AIFF'
			ifTrue: [self error: 'unexpectedly long COMM chunk size for AIFF file'].
		compressionType := (in next: 4) asString.
		compressionType = 'NONE' ifFalse: [self error: 'cannot read compressed AIFF files'].
		in skip: (chunkSize - 22)].  "skip the reminder of AIFF-C style chunk"

]

{ #category : 'private' }
AiffFileReader >> readExtendedFloat [
	"Read and answer an Apple extended-precision 80-bit floating point number from the input stream."
	"Details: I could not find the specification for this format, so constants were determined empirically based on assumption of 1-bit sign, 15-bit exponent, 64-bit mantissa. This format does not seem to have an implicit one before the mantissa as some float formats do."

	| signAndExp mantissa sign exp |
	signAndExp := in nextNumber: 2.
	mantissa := in nextNumber: 8.  "scaled by (2 raisedTo: -64) below"
	(signAndExp bitAnd: 16r8000) = 0
		ifTrue: [sign := 1.0]
		ifFalse: [sign := -1.0].
	exp := (signAndExp bitAnd: 16r7FFF) - 16r4000 + 2.  "not sure why +2 is needed..."
	^ (sign * mantissa asFloat * (2.0 raisedTo: exp - 64)) roundTo: 0.00000001

]

{ #category : 'private' }
AiffFileReader >> readFrom: aBinaryStream [
	"Read AIFF data from the given binary stream."
	"Details: An AIFF file consists of a header (FORM chunk) followed by a sequence of tagged data chunks. Each chunk starts with a header consisting of a four-byte tag (a string) and a four byte size. These eight bytes of chunk header are not included in the chunk size. For each chunk, the readChunk:size: method consumes chunkSize bytes of the input stream, parsing recognized chunks or skipping unrecognized ones. If chunkSize is odd, it will be followed by a padding byte. Chunks may occur in any order."

	| sz end chunkType chunkSize p |
	in := aBinaryStream.
	skipDataChunk := false.
	mergeIfStereo := false.

	"read FORM chunk"
	(in next: 4) asString = 'FORM' ifFalse: [^ self error: 'not an AIFF file'].
	sz := in nextNumber: 4.
	end := in position + sz.
	fileType := (in next: 4) asString.

	[in atEnd not and: [in position < end]] whileTrue: [
		chunkType := (in next: 4) asString.
		chunkSize := in nextNumber: 4.
		p := in position.
		self readChunk: chunkType size: chunkSize.
		(in position = (p + chunkSize))
			ifFalse: [self error: 'chunk size mismatch; bad AIFF file?'].
		chunkSize odd ifTrue: [in skip: 1]].  "skip padding byte"

]

{ #category : 'reading' }
AiffFileReader >> readFromFile: fileName [
	"Read the AIFF file of the given name."
	"AIFFFileReader new readFromFile: 'test.aiff'"

	self readFromFile: fileName
		mergeIfStereo: false
		skipDataChunk: false.

]

{ #category : 'reading' }
AiffFileReader >> readFromFile: fileName mergeIfStereo: mergeFlag skipDataChunk: skipDataFlag [
	"Read the AIFF file of the given name. See comment in readFromStream:mergeIfStereo:skipDataChunk:."

	"AIFFFileReader new readFromFile: 'test.aiff' mergeIfStereo: false skipDataChunk: true"

	| f |
	f := fileName asFileReference binaryReadStream.
	[
	self
		readFromStream: f
		mergeIfStereo: mergeFlag
		skipDataChunk: skipDataFlag ] ensure: [ f close ]
]

{ #category : 'reading' }
AiffFileReader >> readFromStream: aBinaryStream mergeIfStereo: mergeFlag skipDataChunk: skipDataFlag [
	"Read an AIFF file from the given binary stream. If mergeFlag is true and the file contains stereo data, then the left and right channels will be mixed together as the samples are read in. If skipDataFlag is true, then the data chunk to be skipped; this allows the other chunks of a file to be processed in order to extract format information quickly without reading the data."

	mergeIfStereo := mergeFlag.
	skipDataChunk := skipDataFlag.
	isLooped := false.
	gain := 1.0.
	self readFrom: aBinaryStream.

]

{ #category : 'private' }
AiffFileReader >> readInstrumentChunk: chunkSize [

	| midiKey detune lowNote highNote lowVelocity highVelocity
	  sustainMode sustainStartID sustainEndID
	  releaseMode releaseStartID releaseEndID |

	midiKey := in next.
	detune := in next.
	lowNote := in next.
	highNote := in next.
	lowVelocity := in next.
	highVelocity := in next.
	gain := in nextNumber: 2.
	sustainMode := in nextNumber: 2.
	sustainStartID := in nextNumber: 2.
	sustainEndID := in nextNumber: 2.
	releaseMode := in nextNumber: 2.
	releaseStartID := in nextNumber: 2.
	releaseEndID := in nextNumber: 2.
	isLooped := sustainMode = 1.
	(isLooped and: [markers notNil]) ifTrue: [
		((markers first last > frameCount) or:
		 [markers last last > frameCount]) ifTrue: [
			"bad loop data; some sample CD files claim to be looped but aren't"
			isLooped := false]].
	pitch := self pitchForKey: midiKey.

]

{ #category : 'private' }
AiffFileReader >> readMarkerChunk: chunkSize [

	| markerCount id position labelBytes label |
	markerCount := in nextNumber: 2.
	markers := Array new: markerCount.
	1 to: markerCount do: [:i |
		id := in nextNumber: 2.
		position := in nextNumber: 4.
		labelBytes := in next.
		label := (in next: labelBytes) asString.
		labelBytes even ifTrue: [in skip: 1].
		markers at: i put: (Array with: id with: label with: position)].


]

{ #category : 'private' }
AiffFileReader >> readMergedStereoChannelDataFrom: s [
	"Read stereophonic channel data from the given stream, mixing the two channels to create a single monophonic channel. Each frame contains two samples."

	| buf w1 w2 |
	buf := channelData at: 1.
	bitsPerSample = 8
		ifTrue: [
			1 to: frameCount do: [:i |
				w1 := s next.
				w1 > 127 ifTrue: [w1 := w1 - 256].
				w2 := s next.
				w2 > 127 ifTrue: [w2 := w2 - 256].
				buf at: i put: ((w1 + w2) bitShift: 7)]]
		ifFalse: [
			1 to: frameCount do: [:i |
				w1 := (s next bitShift: 8) + s next.
				w1 > 32767 ifTrue: [w1 := w1 - 65536].
				w2 := (s next bitShift: 8) + s next.
				w2 > 32767 ifTrue: [w2 := w2 - 65536].
				buf at: i put: ((w1 + w2) bitShift: -1)]].

]

{ #category : 'private' }
AiffFileReader >> readMonoChannelDataFrom: s [
	"Read monophonic channel data from the given stream. Each frame contains a single sample."

	| buf w |
	buf := channelData at: 1.  "the only buffer"
	bitsPerSample = 8
		ifTrue: [
			1 to: frameCount do: [:i |
				w := s next.
				w > 127 ifTrue: [w := w - 256].
				buf at: i put: (w bitShift: 8)]]
		ifFalse: [
			1 to: frameCount do: [:i |
				w := (s next bitShift: 8) + s next.
				w > 32767 ifTrue: [w := w - 65536].
				buf at: i put: w]].

]

{ #category : 'private' }
AiffFileReader >> readMultiChannelDataFrom: s [
	"Read multi-channel data from the given stream. Each frame contains channelCount samples."

	| w |
	bitsPerSample = 8
		ifTrue: [
			1 to: frameCount do: [:i |
				1 to: channelCount do: [:ch |
					w := s next.
					w > 127 ifTrue: [w := w - 256].
					(channelData at: ch) at: i put: (w bitShift: 8)]]]
		ifFalse: [
			1 to: frameCount do: [:i |
				1 to: channelCount do: [:ch |
					w := (s next bitShift: 8) + s next.
					w > 32767 ifTrue: [w := w - 65536].
					(channelData at: ch) at: i put: w]]].

]

{ #category : 'private' }
AiffFileReader >> readSamplesChunk: chunkSize [
	"Read a SSND chunk. All AIFF files with a non-zero frameCount contain exactly one chunk of this type."

	| offset blockSize bytesOfSamples s |
	offset := in nextNumber: 4.
	blockSize := in nextNumber: 4.
	((offset ~= 0) or: [blockSize ~= 0])
		ifTrue: [^ self error: 'this AIFF reader cannot handle blocked sample chunks'].
	bytesOfSamples := chunkSize - 8.
	bytesOfSamples = (channelCount * frameCount * (bitsPerSample // 8))
		ifFalse: [self error: 'actual sample count does not match COMM chunk'].

	channelDataOffset := in position.  "record stream position for start of data"
	skipDataChunk ifTrue: [in skip: (chunkSize - 8). ^ self].  "if skipDataChunk, skip sample data"

	(mergeIfStereo and: [channelCount = 2])
		ifTrue: [
			channelData := Array with: (SoundBuffer newMonoSampleCount: frameCount)]
		ifFalse: [
			channelData :=
				(1 to: channelCount) collect: [:i | SoundBuffer newMonoSampleCount: frameCount]].

	(bytesOfSamples < (Smalltalk garbageCollectMost - 300000))
		ifTrue: [s := ReadStream on: (in next: bytesOfSamples)]  "bulk-read, then process"
		ifFalse: [s := in].  "not enough space to buffer; read directly from file"

	"mono and stereo are special-cased for better performance"
	channelCount = 1 ifTrue: [^ self readMonoChannelDataFrom: s].
	channelCount = 2 ifTrue: [
		mergeIfStereo
			ifTrue: [channelCount := 1. ^ self readMergedStereoChannelDataFrom: s]
			ifFalse: [^ self readStereoChannelDataFrom: s]].
	self readMultiChannelDataFrom: s.

]

{ #category : 'private' }
AiffFileReader >> readStereoChannelDataFrom: s [
	"Read stereophonic channel data from the given stream. Each frame contains two samples."

	| left right w |
	left := channelData at: 1.
	right := channelData at: 2.
	bitsPerSample = 8
		ifTrue: [
			1 to: frameCount do: [:i |
				w := s next.
				w > 127 ifTrue: [w := w - 256].
				left at: i put: (w bitShift: 8).
				w := s next.
				w > 127 ifTrue: [w := w - 256].
				right at: i put: (w bitShift: 8)]]
		ifFalse: [
			1 to: frameCount do: [:i |
				w := (s next bitShift: 8) + s next.
				w > 32767 ifTrue: [w := w - 65536].
				left at: i put: w.
				w := (s next bitShift: 8) + s next.
				w > 32767 ifTrue: [w := w - 65536].
				right at: i put: w]].

]

{ #category : 'accessing' }
AiffFileReader >> rightSamples [

	^ channelData at: 2

]

{ #category : 'accessing' }
AiffFileReader >> samplingRate [

	^ samplingRate

]

{ #category : 'other' }
AiffFileReader >> sound [
	"Answer the sound represented by this AIFFFileReader. This method should be called only after readFrom: has been done."

	| snd rightSnd |
	snd := SampledSound
		samples: (channelData at: 1)
		samplingRate: samplingRate.
	self isStereo ifTrue: [
		rightSnd := SampledSound
			samples: (channelData at: 2)
			samplingRate: samplingRate.
		snd := MixedSound new
			add: snd pan: 0;
			add: rightSnd pan: 1.0].
	^ snd

]
