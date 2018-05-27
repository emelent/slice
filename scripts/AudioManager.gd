extends Node2D


var sounds = {}


func _ready():
	for sound in get_children():
		sounds[sound.name] = sound

func play(name):
	if Engine.time_scale < 1: return
	var sound = sounds[name]
	if sound:
		sound.play()

