//Random Chord Version
{(SinOsc.ar(Duty.ar(1/8,0,Dxrand(b=[[2,4],[2,4,5,8]];(b*.x allTuples(b*.x b)*4).clump(2)++8)),0,0.9)*LFTri.ar(0.1)/6)}.play

//Mono but cool
play{CombC.ar(SinOsc.ar(Duty.ar(1/8,0,Dseq(b=[[2,4],[2,3,4,8]];flat(b*.x allTuples(b*.x b)*6)++2)),0,0.9)*LFTri.ar(1),LFTri.ar(2),1)/8}

//Final
play{CombC.ar(SinOsc.ar(Duty.ar(1/8,0,Dseq(b=[[2,4],[2,3,4,8]];flat(b*.x allTuples(b*.x b)*6).clump(2)++2)),0,0.9)*LFTri.ar(1),1,1)/8}
