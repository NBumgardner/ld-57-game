extends Node

# Used for global signals such as 'Game Paused'
signal game_paused
signal game_unpaused

signal transitioning_to_new_level

signal level_load_started(level_path : String)
signal level_load_completed
signal level_transition_started
signal level_transition_completed
