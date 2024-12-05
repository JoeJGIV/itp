s.plotTree; //(Check nodes to ensure effects load when server resets. There should be two reverbs and delays!!)
//Execute Synthdefs/Patterns in the order provided before playing the piece!
//FX
//Reverb
(
SynthDef.new("reverb", {
	arg in, out=0, reverbdecay=2;
	var sig;
	sig = In.ar(in, 2)/2.dbamp;
	sig = FreeVerb2.ar(sig[0], sig[0], 0.4, (SinOsc.kr(0.02, mul:1)), 0.4);
	Out.ar(out, sig);
}).add;
)
//Delay
(
SynthDef.new("delay", {
	arg in, out=0, decay=6;
	var sig, delay;
	sig = In.ar(in, 2);
	delay = CombL.ar(sig, 1, 0.5, decay);
	sig = sig.blend(delay, \mix.kr(0.7));
	Out.ar(out, sig);
}).add;
)
//Bus Assignment
(
~reverbBus = Bus.audio(s, 2);
~reverbSynth = Synth("reverb", [\in, ~reverbBus]);
)
(
~delayBus = Bus.audio(s, 2);
~delaySynth = Synth("delay", [\in, ~delayBus]);
)
//Instantiate FX When Rebooting Server (CMD+Period after executing this code!!!)
(
~createReverb = {~reverbSynth = Synth("reverb", [\in, ~reverbBus])};
ServerTree.add(~createReverb);
~createDelay = {~delaySynth = Synth("delay", [\in, ~delayBus])};
ServerTree.add(~createDelay);
)

//Karplus Strings
(SynthDef(\magikarplus, {
	arg impfreq=250, delaytime=0.006, stringdecay=2.0, envdecay=2.0, bpfreq=800, damping=10000, implvl=2.0, level=1.0, lfolvl=250, modfreq=10;
	var impulse, dly, lfo, sig, out;
	impulse = PinkNoise.ar(1);
	impulse = BPF.ar(impulse, impfreq, 0.3);
	impulse = impulse*(EnvGen.kr(Env.perc(0.001, 0.001, implvl), doneAction:0));
	dly = CombC.ar(impulse, 1.0, delaytime, stringdecay, level)*(EnvGen.kr(Env.perc(0.01, envdecay, level), doneAction:2));
	sig = dly;
	lfo = SinOsc.kr(1, SinOsc.kr(modfreq), lfolvl);
	sig = BPF.ar(sig, bpfreq+lfo, 0.1, level) + BPF.ar(sig, (bpfreq+lfo)*1.5, 0.5, level);
	sig = LPF.ar(sig, damping);
	sig = Pan2.ar(sig, 0.0);
	out = Out.ar(\out.ir(0), sig);
}).add;
)
Synth(\magikarplus);

//Kick
(SynthDef(\drum, {
	arg freq=71, ff=250, rq=0.5, noiselvl=0.045, level=0.6, decay=0.5;
	var fund, noise, sig, out;
	fund = SinOsc.ar(freq, mul:1.5);
	fund = fund*EnvGen.kr(Env.perc(0.001, decay, level), doneAction:2);
	noise = WhiteNoise.ar(noiselvl);
	noise = Hasher.ar(noise, 2.0);
	noise = noise*EnvGen.kr(Env.perc(0.001, 0.3, noiselvl));
	noise = LPF.ar(noise, 450);
	sig = fund + noise;
	sig = Pan2.ar(sig, 0.0);
	out = Out.ar(\out.ir(0), sig);
}).add;
)
Synth(\drum);

//Klang Rings Clone
(SynthDef(\bracelets, {
	arg freq=660, decay=1.0, level=0.01, damping=3000, lfolvl=0.01, bd=1.0;
	var sig, excitor, body, lfo, out;
	excitor = WhiteNoise.ar(EnvGen.kr(Env.perc(0.001, 0.01), levelScale:level, doneAction:0));
	lfo = SinOsc.kr(1, WhiteNoise.kr(10), lfolvl, freq);
	body = Klank.ar(`[[freq+lfo, (freq*2)+lfo, (freq*2.5)+lfo, (freq*4)+lfo], [1.0, 0.8, 0.6, 0.4], [bd, bd*0.5, bd*0.25, bd*0.15]], excitor, 1.0, 0.0, 3.0);
	body = LPF.ar(body, damping);
	sig = body*(EnvGen.kr(Env.perc(0.001, decay, curve:-3), doneAction:2));
	sig = Pan2.ar(sig, 0.0);
	out = Out.ar(\out.ir(0), sig);
}).add;
)
Synth(\bracelets);

//Patterns
(
Pdef(
	\karplus,
	Pbind(
		\instrument, \magikarplus,
		\dur, Pseq(
		[1/4], inf),
		\delaytime, Pseq(
			[0.004, 0.002, 0.001, 0.0015], inf),
		\damping, Prand([10000], inf),
		\stringdecay, Pseq([2.0], inf),
		\modfreq, Prand(
			[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 100], inf),
		\level, Pseq(
			[1.01], inf),
		\out, Pxrand(
			[~delayBus, 0], inf),
	);
).quant_(1);
)
Pdef(\karplus).play;
Pdef(\karplus).stop;

(
Pdef(
	\karplus2,
	Pbind(
		\instrument, \magikarplus,
		\dur, Pseq(
		[1/4, 1/8], inf),
		\delaytime, Pseq(
			[0.004, 0.002, 0.001, 0.0025], inf),
		\damping, Prand([10000], inf),
		\stringdecay, Pseq([2.0], inf),
		\modfreq, Prand(
			[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 100], inf),
		\level, Pseq(
			[1.0], inf),
		\out, Prand(
			[~delayBus, 0], inf),
	);
).quant_(1);
)

Pdef(\karplus2).play;
Pdef(\karplus2).stop;

(Pdef(
	\bongo,
	Pbind(
		\instrument, \drum,
		\dur, Pseq(
			[1/2, 1/2, 1/2, 1/4, 1/4], inf),
		\freq, Pseq(
			[71], inf),
		\rq, Prand(
			[0.5, 0.6, 0.7], inf),
		\noiselvl, Pseq(
			[0.0045, 0.005, 0.0055, 0.006], inf),
		\level, Pseq(
			[0.1], inf),
	);
).quant_(1);
)

Pdef(\bongo).play;
Pdef(\bongo).stop;

(Pdef(
	\perc,
	Pbind(
		\instrument, \drum,
		\dur, Pseq(
			[1/8, 1/8, 1/8, 1/4, 1/4], inf),
		\freq, Pseq(
			[800], inf),
		\ff, Prand(
			[800, 900, 12000], inf),
		\rq, Prand(
			[0.5, 0.6, 0.7], inf),
		\noiselvl, Prand(
			[0.06, 0.08], inf),
		\decay, Pseq(
			[0.07], inf),
		\level, Pseq(
			[0.009], inf),
	);
).quant_(1);
)

Pdef(\perc).play;
Pdef(\perc).stop;

(
Pdef(
	\bracepart1,
	Pbind(
		\instrument, \bracelets,
		\dur, Prand(
			[1/4, 1/8], inf),
		\freq, Prand(
			[250, 400], inf),
		\damping, Prand(
			[1000, 1500, 2000, 2500, 3000, 4000, 6000, 8000, 10000], inf),
		\decay, Prand(
			[0.05, 0.06, 0.08, 2, 4], inf),
		\bd, Prand(
			[0.005, 0.006, 0.008, 0.2, 0.4], inf),
		\level, Prand(
			[0.03], inf),
		\out, Pseq(
			[~reverbBus], inf),
	);
).quant_(1);
)

Pdef(\bracepart1).play;
Pdef(\bracepart1).stop;

(
Pdef(
	\bracearp,
	Pbind(
		\instrument, \bracelets,
		\dur, Pseq(
			[1/8], inf),
		\freq, Pseq(
			[220, 440, 660, 770, 880], inf),
		\damping, Prand(
			[3000, 3500, 4000, 6000, 8000, 9000, 10000, 12000], inf),
		\level, Pseq(
			[0.002], inf),
	);
).quant_(1);
)

Pdef(\bracearp).play;
Pdef(\bracearp).stop;

//Play the piece by executing Pdefs as one likes, the piece is meant to be partially improvisatory, but the general order to bring elements in is as follows:
Pdef(\karplus).play;
Pdef(\karplus).stop;

Pdef(\bongo).play;
Pdef(\bongo).stop;

Pdef(\perc).play;
Pdef(\perc).stop;

Pdef(\bracepart1).play;
Pdef(\bracepart1).stop;

Pdef(\karplus2).play;
Pdef(\karplus2).stop;

Pdef(\bracearp).play;
Pdef(\bracearp).stop;

//Start and stop freely! All are quantized. Imrpovise with loops!