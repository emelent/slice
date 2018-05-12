extends Area2D

export var spawn_sound = 'whoosh'

var attacker

func _ready():
	AudioManager.play(spawn_sound)

func __animation_finished(anim_name):
	queue_free()

