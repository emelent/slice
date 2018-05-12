extends Node2D


var sounds = {}


func _ready():
	for sound in get_children():
		sounds[sound.name] = sound

func play(name):
	var sound = sounds[name]
	if sound:
		sound.play()

