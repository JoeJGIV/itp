s.boot
s.plotTree;
ServerTree.removeAll;


//FX
//Reverb
(
SynthDef.new("reverb", {
	arg in, out=0, reverbdecay=3;
	var sig;
	sig = In.ar(in, 2);
	sig = GVerb.ar(sig, 200, reverbdecay, 0.5, 0.5, drylevel:-8, earlyreflevel:-1, taillevel: -7);
	Out.ar(out, sig);
}).add;
)
//Delay
(
SynthDef.new("delay", {
	arg in, out=0, decay=2;
	var sig, delay;
	sig = In.ar(in, 2);
	delay = CombN.ar(sig, 1, 0.33, decay);
	sig = sig.blend(delay, \mix.kr(0.7));
	Out.ar(out, sig);
}).add;
)
//Buses
(
~reverbBus = Bus.audio(s, 2);
~reverbSynth = Synth("reverb", [\in, ~reverbBus]);
~delayBus = Bus.audio(s, 2);
~delaySynth = Synth("delay", [\in, ~delayBus]);
)

(
~createReverb = {~reverbSynth = Synth("reverb", [\in, ~reverbBus])};
ServerTree.add(~createReverb);
~createDelay = {~delaySynth = Synth("delay", [\in, ~delayBus])};
ServerTree.add(~createDelay);
)

//Kick Drum Things
(
SynthDef.new("kick", {
	arg amp=0.75, freq=80;
	var sig, out;
	sig = SinOsc.ar(freq);
	sig = sig * Env.perc(0.001, 0.09).ar(2);
	sig = Pan2.ar(sig, 0.0, amp);
	out = Out.ar(\out.ir(0), sig);
}).add;
)

(
Synth("kick"
	,[\amp, 0.50]
);
)

//Snare Things
(
SynthDef.new("snare", {
	arg amp=0.40, noiselvl=0.22, filterdcy=0.22;
	var sig, out, env;
	sig = SinOsc.ar(165+(SinOsc.ar(100, mul:1)), mul:0.4);
	sig = sig * Env.perc(0.01, 0.01).ar;
	sig = sig + (BPF.ar((WhiteNoise.ar(noiselvl)), 3300, 0.6) * Env.perc(0.02, filterdcy).ar(2));
	sig = Pan2.ar(sig, 0.0, amp);
	out = Out.ar(\out.ir(0), sig);
}).add;
)
Synth("snare");

//Melody
(
SynthDef.new("melody", {
	arg freq=440, amp=0.1, attack=0.01, sustain=0.5, release=0.4, cutoff=500, res=3, fattack=0.01, fsustain=0.5, frelease=0.2, noiselevel=0.05;
	var sig, out, env, noise;
	env = EnvGen.kr(Env([0, amp, 0], [attack, sustain, release], [1, 0, 1]),doneAction: 2);
	sig = (VarSaw.ar([freq, freq+(Rand(0.9, 6))]));
	noise = Hasher.ar((Sweep.ar), noiselevel);
	sig = sig+noise*env;
	sig = MoogFF.ar(sig, (Env.perc(fattack, frelease, cutoff).ar(0) + freq) , res);
	sig = Pan2.ar(sig, 0.0, amp);
	out = Out.ar(\out.ir(0), sig);
}).add;
)
Synth("melody");

(
Synth(
	"melody",
	[
	\out, ~reverbBus,
	]
);
)

//Pad Things
(
SynthDef.new("resonantpad", {
	arg freq=440, warp=1, attack=1, sustain=1, release=1, amp=1, cutoff=1000, rq=0.25, comin=600, comax=3000, rmin=0.08, rmax=0.3;
	var env, sig, out;
	env=EnvGen.kr(Env([0, amp, amp, 0], [attack, sustain, release], [1, 0, 1]),doneAction:2);
	sig=VarSaw.ar(freq, width:warp);
	sig=LPF.ar(sig,
		LFNoise1.kr(0.30).exprange(comin,comax),
		SinOsc.kr(LFSaw.kr(0.6).exprange(0.2, 3)).exprange(rmin,rmax));
	sig=sig*env*amp;
	sig=Splay.ar(sig, 1, amp);
	out=Out.ar(\out.ir(0), sig);
}).add;
)
Synth("resonantpad");


//Chord Progression/Sequencing
(
Pdef(
	\kick,
	Pbind(
		\instrument, "kick",
		\dur, Pseq([2, 2, 2, 2], inf),
		\freq, Prand([80, 81, 82, 79], inf),
		\amp, Prand([0.50, 0.60, 0.40], inf),
	);
).quant_(1);
)
Pdef(\kick).play;
Pdef(\kick).stop;

(
Pdef(
	\snare,
	Pbind(
		\instrument, "snare",
		\dur, Prand([1, 1], inf),
		\amp, Prand([0.40, 0.45, 0.50, 0.55, 0.6]-0.2, inf),
		\filterdcy, Prand([0.22, 0.14, 0.12, 0.1, 0.09, 0.05], inf),
		\noiselvl, Prand([0.22, 0.10, 0.25, 0.28, 0.07], inf),
		\out, Prand([~delayBus, 0], inf),
	);
).quant_(1);
)
Pdef(\snare).play;
Pdef(\snare).stop;

(
Pdef(
	\pad,
	Pbind(
		\instrument, "resonantpad",
		\dur, Prand([4, 6, 8], inf),
		\midinote, Pseq(
		[31, 55, 62, 67, 69],
		[40, 52, 55, 59, 62, 67],
		[31, 55, 60, 62, 65],
		[53, 58, 60, 62],
		inf),
		\amp, Prand([0.2, 0.22, 0.23, 0.24], inf),
		\rq, exprand(0.01,0.3),
		\cutoff, exprand(600, 1000),
		\release, exprand(1.0, 3.0),
	);
).quant_(1);
)
Pdef(\pad).play;
Pdef(\pad).stop;

(
Pdef(
	\melody,
	Pbind(
		\instrument, "melody",
		\dur, Prand([1/2, 1/4], inf),
		\midinote, Prand(
		[64, 67, 69, 71, 74, 76, 79, 84, 86, 88],
		inf),
		\cutoff, Pseq([250, 500, 600, 650, 675, 700, 750, 800, 825, 850, 900, 925, 950, 975, 1000, 1100, 1200, 1300], inf),
		\res, Prand([1, 1.5, 2, 2.5, 3], inf),
		\amp, Prand([0.06, 0.07, 0.08, 0.09], inf),
		\out, Prand([~reverbBus, 0], inf),
	);
).quant_(1);
)
Pdef(\melody).play;
Pdef(\melody).stop;

//Play Controls
Pdef(\kick).play;
Pdef(\kick).stop;

Pdef(\snare).play;
Pdef(\snare).stop;

Pdef(\pad).play;
Pdef(\pad).stop;

Pdef(\melody).play;
Pdef(\melody).stop;