extends Node2D


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	elif Input.is_key_pressed(KEY_BACKSPACE):
		get_tree().reload_current_scene()
