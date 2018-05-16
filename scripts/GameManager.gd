extends Node2D


var num_players = 3


func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	elif Input.is_key_pressed(KEY_BACKSPACE):
		get_tree().reload_current_scene()
