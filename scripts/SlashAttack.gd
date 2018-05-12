extends Area2D

export var spawn_sound = 'whoosh'

var attacker

func _ready():
	get_tree().current_scene.AudioManager.play(spawn_sound)

func __animation_finished(anim_name):
	queue_free()

