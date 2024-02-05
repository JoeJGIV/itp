# itp

## Joe

# Scratch Game Documentation

## What I did:
For making the scratch game I decided to do something pretty simple. I made a game in which the player controls a wizard with the arrow keys and spacebar in order to cast some spells. I started with making 2 seperate projectile spells using the up and right arrows. One of the just launches a static sprite to the right. The other is slightly more sophisticated in that the sprite of the object changes before being moved to the screens edge. Theres also a spells that switches the background, makes a toad appear, and changes the size of the wizard sprite temporarily.

## How I did it
For the projectiles I have scratch constantly looking for key presses after the flag is clicked. Once these are reported a sprite is then made visible. The fireball srite is called to coordinates near the wizard and goes to the edge. The egg says something and changes costume before doing this. For the toad I went a slightly more sophisticated route using variables. The key presses are looked for in the same way, but the toad is put at the left side of the screen and I specified a location variable. This varible is then changed by 1 on a conditional loop that stops when the screen edge is reached. the costumes are also changed in this loop.

## Problems
Once I got used to scratch I didn't run into many issues. I did read some of the wiki in order to start the process. I'll link the code I found below. My toad coding was the trickiest, because I was looking for a way to use variables in the game. When I had gotten the movement to work I tried adding in the costume changes and the code broke for a bit, but after changing the order of a few blocks it sorted itself out.

## Code
[The sracth wiki page I read](https://en.scratch-wiki.info/wiki/Shooting_Projectiles)
