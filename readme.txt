Reflex

Copyright (C) 2011 Jonathan Lamothe <jonathan@jlamothe.net>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or (at
your option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see: http://www.gnu.org/licenses/

* * *

About this program:

Reflex is a simple game which can be implemented on an
Arduino-compatible device.  The game itself is a bit of an experiment
to show that a game doesn't have to be complicated in order to be
enjoyable.

How to play:

The rules are actually quite simple.  There are four players
(although, the number of players can be changed relatively easily).
Each player has a button and a light.  There is also a signal light.
When the signal light turns on, the first player to press their button
scores a point.  If a player presses their button before the light
comes on however, everyone else scores a point instead.  Thus, the
idea of the game is to develop quick reflexes.

When a point is scored, the light of the player(s) who scored the
point will illuminate momentarily, then all players lights will blink
their score.  If they have one point, their light will blink one time;
if they have two points, it'll blink two times; etc.  The player with
the highest score wins.

How to build your own game:

Simply download, compile and install this program onto an
Arduino-compatible device and hook up the buttons and lights as
follows:

BUTTONS:
Player 1: Pin 2
Player 2: Pin 4
Player 3: Pin 6
Player 4: Pin 8
Reset: Reset pin

LIGHTS:
Player 1: Pin 3
Player 2: Pin 5
Player 3: Pin 7
Player 4: Pin 9
Signal light: Pin 13

The buttons are a simple dry contact to the ground pin.  The lights
also run from their output pins to ground.

Pro tip: Most Arduinos (is that the plural of Arduino?) can handle a
maximum output of 40mA on their output pins.  An LED with a 220ohm
resistor works nicely for this purpose.

Other remarks:

As mentioned above, this software is licensed under the GNU GPL, which
means you're free to copy it, share it, modify it, etc.  In fact, I
encourage these things.  Just don't do anything to take those rights
away from anyone else.

Enojy.
