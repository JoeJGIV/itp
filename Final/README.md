# itp

## Joe

# Final Documentation!

## First Collisions
### To get a start, and compose a piece, in Supercollider

# Big Words!
## (Motivation, Philosophy, and Inspiration)
My main motivation to embark on this journey was seeing some of my peers making great art with Supercollider, and I thought that learning the language would be a fun way to bridge the gap between computer science and music.

My design philosophy going in was to just make something basic, but complete, in scope. In doing this I felt I'd naturally grasp the fundamentals of the language.

My inspiration is essentially the same as my motivations, being the creation of the project. Seeing some of what could be done via Rachel, my peers, and several youtube videos, I was inspired to throw myself headlong into the program until I got something cool out of it.

## System Overview
My project is built from several synthdefs and pdefs, which are separated by comments in order to keep the workspace organized.

To put both into laymen terms: these are umbrellas for my synthesizers, effects, and patterns.

Within synthdefs one can define arguments to be manipulated later on, and variables: the building blocks of the sound.

Within pdefs one can specify several things such as: the synth to be played, arguments to be adjusted, divisions of notes, etc.

(If one follows Supercollider's naming conventions they are also able to take advantage of various other features ex: freq to midicps conversion.)

Before any of these defs can be used I must boot the audio server, which is where Supercollider calls all of the sound generators from in order to save on computing power.

I also send the reverb and delay effects to separated named busses, and tell the server to re-initialize them, rather than delete them, when the server is initialized.

## What I Was Able to Accomplish and What Did not Make the cut
While I do have a basic generative system, it's extremely rudimentary, and most of the percussive sounds don't have much depth to them. I feel that my work with effects could also be smoother, as I wanted to utilize more reverb to smooth out the pad, but it raises the level of any synth going through it to a clipping level.

The quantization, and actual algorithmic composition is also a little shaky, as pdefs didn't enter my project until the end. I don't take advantage of any nesting because I didn't want to overcomplicate this first project and I'm still getting a grasp of what can be used to modulate sequences as they run. Again, the project works, but its a little clunky for my liking.

## Sources
While I did not copy/paste any code for this project I utilized Rachel's Supercollider repository in order to learn basic synthesis in Supercollider.
I then binged through a bulk of Eli Fieldsteel's Supercollider tutorial videos, and this is where I learned how to allocate effects busses, as well as how to store the effects as functions on the server.

Again, no code was copied directly, but these are the sources of my knowledge in the program, so I thought they should be mentioned here.

Eli Fieldsteel's tutorial playlist
https://www.youtube.com/playlist?list=PLPYzvS8A_rTaNDweXe6PX4CXSGq4iEWYC

Rachel Rome's Supercollider Repository:
https://github.com/rdwrome/347sp24
