extends Node2D

export var preset_player = true

onready var Players = $Players
onready var SpawnPoints = $SpawnPoints


var num_spawn_points = 0
var stats = {
}

func _ready():
	num_spawn_points = SpawnPoints.get_child_count()
	rand_seed(OS.get_unix_time())
	setup()


func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()


func setup():
	for player in Players.get_children():
		stats[player.character_name] = {
			'deaths': 0,
			'kills': 0
		}
		var point = get_random_spawn_point()
		if not preset_player:
			player.global_position = point
		player.set_spawn_location(point)


func get_random_spawn_point():
	var i = randi() % num_spawn_points
	var point = SpawnPoints.get_child(i)
	return point.global_position

func kill_player(player):
	player.set_spawn_location(get_random_spawn_point())
	player.kill()


