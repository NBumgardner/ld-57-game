extends Node

# Used for global signals such as 'Game Paused'
signal game_paused
signal game_unpaused

signal game_started
signal game_ended
signal game_restarted

signal level_load_started(level_path : String)
signal level_load_completed
signal level_transition_started
signal level_transition_completed

signal start_dialogue
signal end_dialogue
