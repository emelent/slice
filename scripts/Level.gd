extends Node2D

export var preset_player = true

onready var Players = $Players
onready var SpawnPoints = $SpawnPoints
onready var HUD = $HUD

var num_spawn_points = 0
var stats = {
}

signal score_updated
func _ready():
	num_spawn_points = SpawnPoints.get_child_count()
	rand_seed(OS.get_unix_time())
	setup()



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
	if player.immortal: return
	player.set_spawn_location(get_random_spawn_point())
	player.kill()

	# update score
	if player.killer:
		var killer_name = player.killer.character_name
		if player.killer == player:
			stats[killer_name]['kills'] -= 1
		else:
			stats[killer_name]['kills'] += 1
	stats[player.character_name]['deaths'] += 1
	HUD.update_score(stats)


