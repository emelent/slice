extends Node2D

export var preset_player = true

func _ready():
	pass
#	setup()

func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()

func setup():
	pass
#	var loc = $PlayerSpawn.position
#	for player in Players.get_children():
#		if not preset_player:
#			player.position = loc
#		player.set_spawn_location(loc)


func __death_zone_entered(body):
	if not body.is_in_group('killable'):
		return

	if body.has_method('kill'):
		body.kill()
	else:
		body.queue_free()

