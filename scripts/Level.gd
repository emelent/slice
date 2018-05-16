extends Node2D


export(int, -1, 3) var num_players = -1
export var spawn_players = true
export (PackedScene) var Player = preload('res://scenes/Player.tscn')
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
	if num_players < 0:
		num_players = GameManager.num_players
	else:
		GameManager.num_players = num_players
	setup()


func setup():
	for i in range(num_players):
		var player = Player.instance()
		player.player_number = i + 1
		Players.add_child(player)
		stats[player.character_name] = {
			'deaths': 0,
			'kills': 0
		}
		var point = get_random_spawn_point()
		player.global_position = point
		player.set_spawn_location(point)


func get_random_spawn_point():
	var i = randi() % num_spawn_points
	var point = SpawnPoints.get_child(i)
	return point.global_position

func kill_player(player):
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


