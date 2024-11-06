// rune_b
// by John Oestmann, Oct 2024
// Code and music released under MIT License and Public Domain/CC0 respectively
(
{
	var layer1, layer2, layer3, layer4, layer5, layer6, audio, cycle, rain;

	layer1 = SinOsc.ar(freq: SinOsc.ar(0.05,mul: 2, add: 46.midicps), mul: 0.27) // Tone
	    * Lag.ar(Pulse.ar(freq:  4, mul: 0.5, add: 0.5), lagTime: 0.001); // Vol

	layer2 = SinOsc.ar(freq: 70.midicps, mul: 0.1)
	* Lag.ar(Saw.ar(SinOsc.ar(0.25,mul: 7, add: 8),mul: 0.5,add: 0.5),lagTime: 0.0001);

	layer3 = SinOsc.ar(freq: 75.midicps, mul: 0.1)
	* Lag.ar(Saw.ar(SinOsc.ar(0.24,mul: 7, add: 8),mul: 0.5,add: 0.5),lagTime: 0.0001);

	layer4 = SinOsc.ar(freq: 77.midicps, mul: 0.1)
	* Lag.ar(Saw.ar(SinOsc.ar(0.23,mul: 7, add: 8),mul: 0.5,add: 0.5),lagTime: 0.0001);

	layer5 = SinOsc.ar(freq: 82.midicps, mul: 0.1)
	* Lag.ar(Saw.ar(SinOsc.ar(0.1,mul: 7, add: 8),mul: 0.5,add: 0.5),lagTime: 0.0001);

	layer6 = SinOsc.ar(freq: 80.midicps, mul: 0.1)
	* Lag.ar(Saw.ar(SinOsc.ar(0.18,mul: 7, add: 8),mul: 0.5,add: 0.5),lagTime: 0.0001);

	// Panning and individual fades
	cycle = Pan2.ar(layer1,-0.3, level: EnvGen.ar(Env.circle(levels: [0,1,1,0,0],times: [25,35,25,15],curve: 2)));

	rain = (Pan2.ar(layer2, 0.3, level: SinOsc.ar(0.05,phase: pi, mul: 0.1,add: 0.1)))
	+ (Pan2.ar(layer3, 0.1, level: SinOsc.ar(0.04,phase: pi, mul: 0.1,add: 0.1)))
	+ (Pan2.ar(layer4, -0.1, level: SinOsc.ar(0.03,phase: pi, mul: 0.1,add: 0.1)))
	+ (Pan2.ar(layer5, 0.6, level: SinOsc.ar(0.018,phase: 1.5*pi, mul: 0.04,add: 0.04)))
	+ (Pan2.ar(layer6, 0.2, level: SinOsc.ar(0.02,phase: 3*pi, mul: 0.06,add: 0.06)));

	// Overall fades
	cycle = cycle * EnvGen.ar(Env.circle(levels: [0,1,1,0,0], times: [15,200,25,30], curve: 'lin'));
	rain = rain * EnvGen.ar(Env.circle(levels: [0,0,1,1,0], times: [30,15,200,25], curve: 'lin'));

	audio = cycle + rain;

}.play;
)

//Analysis by Joe Gatti

//Layer 1
{SinOsc.ar(freq: SinOsc.ar(0.05,mul: 2, add: 46.midicps), mul: 0.27) * Lag.ar(Pulse.ar(freq:  4, mul: 0.5, add: 0.5), lagTime: 0.001)}.play

{SinOsc.ar(freq: SinOsc.ar(0.05,mul: 2, add: 46.midicps), mul: 0.27)}.play //Fundamental of the kick sound in the track

{Lag.ar(Pulse.ar(freq:  4, mul: 0.5, add: 0.5), lagTime: 0.001)}.play //Lag here is smoothing out the edges of the pulse wave. Lag and Pulse are being used in tandem as the sound's "amplifier"/"envelope"

{(Pulse.ar(freq:4, mul: 0.5, add: 0.5))}.play //Pulse without the lag. Much brighter and sharper... would likely take over a mix in context of the piece

//I like to think of the remaining tonal layers as having 3 main components-Fundamental, Lag.ar, and an amplifier:

//Layer 2
{SinOsc.ar(freq: 70.midicps, mul: 0.1) * Lag.ar(Saw.ar(SinOsc.ar(0.25,mul: 7, add: 8),mul: 0.5,add: 0.5),lagTime: 0.0001)}.play

{SinOsc.ar(freq: 70.midicps, mul: 0.1)}.play //Fundamental of layer 2/ woodblock esque layer

{Lag.ar(Saw.ar(SinOsc.ar(0.25,mul: 7, add: 8),mul: 0.5,add: 0.5),lagTime: 0.0001)}.play //The "amplifier"
//This one differs from Layer1 firstly in contour/tone in its use of a saw instead of a pulse wave, but also differs through the frequency of the saw wave being modulated by a sineosc.

{SinOsc.ar(freq: 70.midicps, mul: 0.1) * Saw.ar(SinOsc.ar(0.25,mul: 7, add: 8),mul: 0.5,add: 0.5)}.play //Without lag for context.
//Here lag.ar is much more subtle, maybe because the tone is more constant.
///To my ear lag sounds like its reducing volume when the saw is at it's slowest, resulting in a smoother sound ideal for this ambient setting.
////Partially psycho-acoustic because the wave is getting smoothed by lag, but any decrease in sudden pops works wonders

//Layer 3
{SinOsc.ar(freq: 75.midicps, mul: 0.1) * Lag.ar(Saw.ar(SinOsc.ar(0.24,mul: 7, add: 8),mul: 0.5,add: 0.5),lagTime: 0.0001)}.play

{SinOsc.ar(freq: 75.midicps, mul: 0.1)}.play //Fundamental of Layer 3

{Lag.ar(Saw.ar(SinOsc.ar(0.24,mul: 7, add: 8),mul: 0.5,add: 0.5),lagTime: 0.0001)}.play //Amplifier
//The primary difference between layers moving forward is the frequency value of the SinOsc (modulator of Saw.ar). Every value is different in order to prevent overlap/summing of signals overwhelming the piece.

//No direct correlation between note frequency and modulator frequency... Maybe this was just felt out by the composer?
{SinOsc.ar(freq: 75.midicps, mul: 0.1) * Saw.ar(SinOsc.ar(0.24,mul: 7, add: 8),mul: 0.5,add: 0.5)}.play // Layer 3 Without Lag

//Layer 4
{SinOsc.ar(freq: 77.midicps, mul: 0.1) * Lag.ar(Saw.ar(SinOsc.ar(0.23,mul: 7, add: 8),mul: 0.5,add: 0.5),lagTime: 0.0001)}.play

{SinOsc.ar(freq: 77.midicps, mul: 0.1)}.play //Fundamental of Layer 4

{Lag.ar(Saw.ar(SinOsc.ar(0.23,mul: 7, add: 8),mul: 0.5,add: 0.5),lagTime: 0.0001)}.play //Amplifier

{SinOsc.ar(freq: 77.midicps, mul: 0.1) * (Saw.ar(SinOsc.ar(0.23,mul: 7, add: 8),mul: 0.5,add: 0.5))}.play //Without Lag


//Layer 5
{SinOsc.ar(freq: 82.midicps, mul: 0.1) * Lag.ar(Saw.ar(SinOsc.ar(0.1,mul: 7, add: 8),mul: 0.5,add: 0.5),lagTime: 0.0001)}.play

{SinOsc.ar(freq: 82.midicps, mul: 0.1)}.play //Fundamental of Layer 5

{Lag.ar(Saw.ar(SinOsc.ar(0.1,mul: 7, add: 8),mul: 0.5,add: 0.5),lagTime: 0.0001)}.play //Amplifier

{SinOsc.ar(freq: 77.midicps, mul: 0.1) * (Saw.ar(SinOsc.ar(0.23,mul: 7, add: 8),mul: 0.5,add: 0.5))}.play //Without Lag


//Layer 6
{SinOsc.ar(freq: 80.midicps, mul: 0.1) * Lag.ar(Saw.ar(SinOsc.ar(0.18,mul: 7, add: 8),mul: 0.5,add: 0.5),lagTime: 0.0001)}.play

{SinOsc.ar(freq: 80.midicps, mul: 0.1)}.play //Fundamental of Layer 6

{Lag.ar(Saw.ar(SinOsc.ar(0.18,mul: 7, add: 8),mul: 0.5,add: 0.5),lagTime: 0.0001)}.play //Amplifier

{SinOsc.ar(freq: 77.midicps, mul: 0.1) * (Saw.ar(SinOsc.ar(0.23,mul: 7, add: 8),mul: 0.5,add: 0.5))}.play //Wihtout Lag

//Lag example from: https://doc.sccode.org/Classes/Lag.html
(
{
    SinOsc.ar(                              // sine wave
        Lag.kr(                             // lag the modulator
            LFPulse.kr(4, 0, 0.5, 50, 400), // frequency modulator
            Line.kr(0, 1, 15)               // modulate lag time
        ),
        0,                                  // phase
        0.3                                 // sine amplitude
    )
}.play
)
//Lag Removed from the modulator
(
{
	SinOsc.ar((LFPulse.kr(4, 0, 0.5, 50, 400)),0,0.3)
}.play
)

//The next varible, audio, is used to sum previous variables together, so I'll save the analysis of that variable until after rain.

//Cycle
cycle = Pan2.ar(layer1,-0.3, level: EnvGen.ar(Env.circle(levels: [0,1,1,0,0],times: [25,35,25,15],curve: 2)));
//Here cycle primarily includes induvidual expansion/stereoization for our kick drum (Layer 1) using Pan2

//Env is using the method "circle" in order to make the envelope cycle through its values
//The times here are extremely large, so that the code only needs to be executed once for the track to play fully
//Curve:2 returns an exponentially curved envelope

//Cycle is then used again in the code
cycle = cycle * EnvGen.ar(Env.circle(levels: [0,1,1,0,0], times: [15,200,25,30], curve: 'lin'));
//Here cycle being multiplied by an even larger circle envelope (200 seconds to reach it's first peak!)
//This creates the contrasting dections of the song where the kick is playing, and silent.

//Rain
rain = (Pan2.ar(layer2, 0.3, level: SinOsc.ar(0.05,phase: pi, mul: 0.1,add: 0.1)))
	+ (Pan2.ar(layer3, 0.1, level: SinOsc.ar(0.04,phase: pi, mul: 0.1,add: 0.1)))
	+ (Pan2.ar(layer4, -0.1, level: SinOsc.ar(0.03,phase: pi, mul: 0.1,add: 0.1)))
	+ (Pan2.ar(layer5, 0.6, level: SinOsc.ar(0.018,phase: 1.5*pi, mul: 0.04,add: 0.04)))
	+ (Pan2.ar(layer6, 0.2, level: SinOsc.ar(0.02,phase: 3*pi, mul: 0.06,add: 0.06)));

//Here I think that rain is the composer's name for the woodblock-esque SinOsc's in the track
//All of these tonal layers are fed into induvidual Pan2 inputs
//The position of each layer is static, with only one layer inhabiting the left side (I'm assuming this is because Layer1 takes so much headroom)

//The levels are modulated. Hooray LFO's!!

//Each layers SinOsc Varies

//Induvidual frequencies and phases to ensure no overlap
//The two highest frequency layers have the lowest mul and add values, to tuck them in the mix/make them more subtle to our ears


//Rain once more
rain = rain * EnvGen.ar(Env.circle(levels: [0,0,1,1,0], times: [30,15,200,25], curve: 'lin'));

//In the same fashion as cycle, rain is multiplied by an extremely long envelope for dividing the piece into sections
//Notice the envelopes only overlap in level within their 3rd section
//200 second fade after the rain "solo" so it sustains through layer 1's restatement, and then fades after.

//cycle levels: [0,1,1,0,0] times: [15,200,25,30]
//rain levels:  [0,0,1,1,0], times: [30,15,200,25]

//Looking at the two envgens next to eachother, the piece's structure becomes clear.


//Finally audio is used to sum these pan2 sections together. This is an easy way to esnure all elements begin at the exact same time with no discrepancies between performances.

//What I would've changed

//While I think that this Supercollider Piece is wonderful, and sounds very good, I would definitely use a different approach if I were to make an ambient piece of a similar timbre. (This is all disregarding the composer's wish for minimalism).

//I mainly would've enclosed each element into a synthdef, so I could manipulate arguments on the fly. I enjoy improvisatory music, and being able to perform something with this program really sparks my interest

//New layer 1
(
SynthDef.new("kick", {
	arg freq=4, lagtime=0.001, maxlvl=1.0, fadein=15, sustain=200, stepdwn=25, fadeout=30;
	var fund, out;
	fund = SinOsc.ar(SinOsc.ar(0.05, mul:2, add:46.midicps), mul:0.27);
	fund = fund * Lag.ar(Pulse.ar(freq, mul: 0.5, add: 0.5), lagtime);
	fund = Pan2.ar(fund, 0.0, (EnvGen.ar(Env.circle(levels: [0,maxlvl,maxlvl,0,0], times: [fadein,maxlvl,stepdwn,fadeout], curve: 'lin'))));
	out = Out.ar(\out.ir(0), fund);
}).add;
)

Synth("kick");

//New layers 2-6 (using layer 2 as the model of my def)
(
SynthDef.new("woodblock", {
	arg freq=70.midicps, modfreq=0.25, lagtime=0.0001, pan=0.3, sinfreq=0.05, sinphase=pi, mul=0.1, offset=0.1;
	var fund, out;
	fund = SinOsc.ar(freq, mul: 0.1);
	fund = fund * Lag.ar(Saw.ar(SinOsc.ar(0.25,mul: 7, add: 8),mul: 0.5,add: 0.5),lagTime: 0.0001);
	fund = Pan2.ar(fund, pan, (SinOsc.ar(sinfreq, sinphase, mul, offset)));
	out = Out.ar(\out.ir(0), fund);
}).add;
)

Synth("woodblock");

//Now to use the Synth defs with Patterns!

(
Pdef(
	\kick,
	Pbind(
		\instrument, "kick",
		\freq, [4],
		\lagtime, Prand([0.001,0.002,0.003,0.004], inf), //example of the advantage of using synthdef... modulating lagtime to add a push/pull to the pulse
		\maxlvl, [0.07],
		\fadein, [1],
		\sustain, [60],
		\stepdwn, [15],
		\fadeout, [30],
	);
);
)

(
Pdef(
	\layer2,
	Pbind(
		\instrument, "woodblock",
		\freq, Pseq([70.midicps], 1),
		\modfreq, [0.25],
		\pan, [0.3],
		\sinfreq, [0.05],
		\sinphase, [pi],
		\mul, [0.1],
		\offset, [0.1],
	);
);
)

(
Pdef(
	\layer3,
	Pbind(
		\instrument, "woodblock",
		\freq, Pseq([75.midicps], 1),
		\modfreq, [0.25],
		\pan, [-0.3],
		\sinfreq, [0.05],
		\sinphase, Prand([pi, 1.5*pi, 3*pi], 1),
		\mul, [0.1],
		\offset, [0.1],
	);
);
)


(
Pdef(
	\layer4,
	Pbind(
		\instrument, "woodblock",
		\freq, Pseq([77.midicps], 1),
		\modfreq, [0.25],
		\pan, [0.5],
		\sinfreq, [0.05],
		\sinphase, Prand([pi, 1.5*pi, 3*pi], 1),
		\mul, [0.1],
		\offset, [0.1],
	);
);
)

(
Pdef(
	\layer5,
	Pbind(
		\instrument, "woodblock",
		\freq, Pseq([82.midicps], 1),
		\modfreq, [0.25],
		\pan, [0.7],
		\sinfreq, [0.05],
		\sinphase, Prand([pi, 1.5*pi, 3*pi], 1),
		\mul, [0.04],
		\offset, [0.1],
	);
);
)

(
Pdef(
	\layer6,
	Pbind(
		\instrument, "woodblock",
		\freq, Pseq([80.midicps], 1),
		\modfreq, [0.25],
		\pan, [-0.7],
		\sinfreq, [0.05],
		\sinphase, Prand([pi, 1.5*pi, 3*pi], 1),
		\mul, [0.06],
		\offset, [0.1],
	);
);
)

Pdef(\kick).play;
Pdef(\kick).stop;

Pdef(\layer2).play;
Pdef(\layer2).stop;

Pdef(\layer3).play;
Pdef(\layer3).stop;

Pdef(\layer4).play;
Pdef(\layer4).stop;

Pdef(\layer5).play;
Pdef(\layer5).stop;

Pdef(\layer6).play;
Pdef(\layer6).stop;