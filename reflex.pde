// -*- mode: c++ -*-

/// @file reflex.pde

// Reflex

// Copyright (C) 2011 Jonathan Lamothe <jonathan@jlamothe.net>

// This program is free software: you can redistribute it and/or
// modify it under the terms of the GNU General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.

// This program is distributed in the hope that it will be useful, but
// WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see: http://www.gnu.org/licenses/

// *** CONFIGURATION PARAMETERS ***

/// @brief Number of players.
#define NUM_PLAYERS 4

/// @brief Output for the signal light.
#define SIGNAL_OUTPUT 13

/// @brief Blinking delay (in ms).
#define BLINK_DELAY 100

/// @brief Winner display delay (in ms).
#define WINNER_DELAY 3000

/// @brief Delay after showing winner (in ms).
#define AFTER_WINNER_DELAY 1000

/// @brief Minimum amount of time before the signal light comes on (in ms).
#define MIN_WAIT 1000

/// @brief Maximum amount of time before the signal light comes on (in ms).
#define MAX_WAIT 5000

/// @brief Number of blinks on startup.
#define BLINKS_ON_STARTUP 5

/// @brief Pins connected to player buttons.
const int input_pin[] = { 2, 4, 6, 8 };

/// @brief Pins connected to player lights.
const int output_pin[] = { 3, 5, 7, 9 };

// *** GLOBAL VARIABLES ***

/// @brief Player scores.
int player_score[NUM_PLAYERS];

/// @brief Time at which the timer was started.
unsigned long timer_ref;

/// @brief Timer duration.
unsigned long timer_duration;

/// @brief 

// *** FUNCTIONS ***

/// @brief Initializes the button pins.
void initialize_buttons()
{
  for(int i = 0; i < NUM_PLAYERS; i++)
    {
      pinMode(input_pin[i], INPUT);
      digitalWrite(input_pin[i], HIGH);
    }
}

/// @brief Initializes the light pins.
void initialize_lights()
{
  for(int i = 0; i < NUM_PLAYERS; i++)
    {
      pinMode(output_pin[i], OUTPUT);
      digitalWrite(output_pin[i], LOW);
    }
  pinMode(SIGNAL_OUTPUT, OUTPUT);
  digitalWrite(SIGNAL_OUTPUT, LOW);
}

/// @brief Resets the score.
void reset_score()
{
  for(int i = 0; i < NUM_PLAYERS; i++)
    player_score[i] = 0;
}

/// @brief Turn all player lights on.
void player_lights_on()
{
  for(int i = 0; i < NUM_PLAYERS; i++)
    digitalWrite(output_pin[i], HIGH);
}

/// @brief Turn all player lights off.
void player_lights_off()
{
  for(int i = 0; i < NUM_PLAYERS; i++)
    digitalWrite(output_pin[i], LOW);
}

/// @brief Turn the signal light on.
void signal_light_on()
{
  digitalWrite(SIGNAL_OUTPUT, HIGH);
}

/// @brief Turn the signal light off.
void signal_light_off()
{
  digitalWrite(SIGNAL_OUTPUT, LOW);
}

/// @brief Turn all lights on.
void all_lights_on()
{
  player_lights_on();
  signal_light_on();
}

/// @brief Turn all lights off.
void all_lights_off()
{
  player_lights_off();
  signal_light_off();
}

/// @brief Blinks all lights.
void blink_all_lights()
{
  all_lights_on();
  delay(BLINK_DELAY);
  all_lights_off();
  delay(BLINK_DELAY);
}

/// @brief Illuminate a player's light.

/// @param player The player number to light.
void light_player(int player)
{
  for(int i = 0; i < NUM_PLAYERS; i++)
    digitalWrite(output_pin[i], (i == player) ? HIGH : LOW);
}

/// @brief Illuminate all players' lights except one.

/// @brief The player to not light.
void light_other_players(int player)
{
  for(int i = 0; i < NUM_PLAYERS; i++)
    digitalWrite(output_pin[i], (i == player) ? LOW : HIGH);
}

/// @brief Blink the lights all fancy-like to signal the start of a
/// game.
void startup_signal()
{
  signal_light_off();
  for(int i = 0; i < NUM_PLAYERS; i++)
    {
      light_player(i);
      delay(BLINK_DELAY);
    }

  player_lights_off();
  signal_light_on();
  delay(BLINK_DELAY);

  signal_light_off();
  for(int i = NUM_PLAYERS - 1; i >= 0; i--)
    {
      light_player(i);
       delay(BLINK_DELAY);
    }

  player_lights_off();
  delay(BLINK_DELAY);

  for(int i = 0; i < BLINKS_ON_STARTUP; i++)
    blink_all_lights();
}

/// @brief Starts a new timer:
void start_timer()
{
  timer_ref = millis();
  timer_duration = random(MIN_WAIT, MAX_WAIT + 1);
}
/// @brief Checks to see if the timer has elapsed:

/// @return true if the timer has elapsed, false otherwise.
boolean timer_elapsed()
{
  return millis() - timer_ref >= timer_duration;
}

/// @brief Checks to see if a player is pressing a button.

/// @return The number of the player who is pressing the button, -1 if
/// no buttons are pressed.
/// @brief Checks the timer and sets the signal light accordingly.
void signal_check()
{
  if(timer_elapsed())
    signal_light_on();
  else
    signal_light_off();
}

/// @brief Checks for a button press.

/// @return If a player button is pressed, the number of that player,
/// -1 if no buttons are pressed.
int scan_for_button()
{
  for(int i = 0; i < NUM_PLAYERS; i++)
    if(digitalRead(input_pin[i]) == LOW)
      return i;
  return -1;
}

/// @brief Give a player a point and turn his/her light on.

/// @param player The number of the player to reward.
void reward_player(int player)
{
  if(player >= 0 && player < NUM_PLAYERS)
    player_score[player]++;
  light_player(player);
  delay(WINNER_DELAY);
}

/// @brief Give all players but one a point and turn their lights on.

/// @param player The number of the player who doesn't get a point.
void penalize_player(int player)
{
  for(int i = 0; i < NUM_PLAYERS; i++)
    if(i != player)
      player_score[i]++;
  light_other_players(player);
  delay(WINNER_DELAY);
}

/// @brief Calculates the highest score.

/// @return The score.
int get_max_score()
{
  int result = 0;
  for(int i = 0; i < NUM_PLAYERS; i++)
    if(player_score[i] > result)
      result = player_score[i];
  return result;
}

/// @brief Blinks the players' scores on their lights.
void blink_score()
{
  int max_score = get_max_score();
  for(int i = 0; i < max_score; i++)
    {
      for(int j = 0; j < NUM_PLAYERS; j++)
	digitalWrite
	  (output_pin[j],
	   (player_score[j] > i) ? HIGH : LOW);
      delay(BLINK_DELAY);
      player_lights_off();
      delay(BLINK_DELAY);
    }
}


/// @brief Called when someone presses a button.

/// @param player The player number who pressed the button.
void button_pressed(int player)
{
  signal_light_off();
  if(timer_elapsed())
    reward_player(player);
  else
    penalize_player(player);
  player_lights_off();
  delay(AFTER_WINNER_DELAY);
  blink_score();
  start_timer();
}

void setup()
{
  randomSeed(analogRead(0));
  initialize_buttons();
  initialize_lights();
  reset_score();
  startup_signal();
  start_timer();
}

void loop()
{
  player_lights_off();
  signal_check();
  int player = scan_for_button();
  if(player >= 0)
    button_pressed(player);
}

// jl
