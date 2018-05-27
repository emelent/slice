extends Node2D


export(int, -1, 3) var num_players = -1
export var deactivate = [false, false, false]
export var spawn_players = true
export (PackedScene) var Player = preload('res://scenes/Player.tscn')

onready var SlowMoTimer = $SlowMoTimer
onready var Players = $Players
onready var SpawnPoints = $SpawnPoints
onready var HUD = $HUD
onready var SpawnZone = $SpawnZone
onready var LevelEffect = $LevelEffect

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
	var c = 0
	for d in deactivate:
		if d == true:
			c = 1

	GameManager.num_players = GameManager.num_players - c
	print('num_players: ', GameManager.num_players)
	setup()

#func _process(delta):
#	var pos = get_global_mouse_position()
#	pos.x = 1  -  abs(OS.window_size.x - pos.x)/ OS.window_size.x
#	pos.y = abs(OS.window_size.y -  pos.y) / OS.window_size.y
#	LevelEffect.material.set('shader_param/center', pos)

func setup():
	for i in range(num_players):
		if deactivate[i]:
			continue
		var player = Player.instance()
		player.player_number = i + 1
		Players.add_child(player)
		stats[player.character_name] = {
			'deaths': 0,
			'kills': 0,
			'bullets': player.bullet_count
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
		# give killer a bullet
		if player.killer.bullet_count < player.killer.max_bullets:
			player.killer.bullet_count += 1
			stats[player.killer.character_name]['bullets'] = player.killer.bullet_count

		if player.killer == player:
			stats[killer_name]['kills'] -= 1
		else:
			stats[killer_name]['kills'] += 1
			var pos = player.global_position
			pos.x = 1  -  abs(OS.window_size.x - pos.x)/ OS.window_size.x
			pos.y = abs(OS.window_size.y -  pos.y) / OS.window_size.y
			start_slowmo(pos)
	stats[player.character_name]['deaths'] += 1
	HUD.update_score(stats)

func update_bullet_count(player):
	stats[player.character_name]['bullets'] = player.bullet_count
	HUD.update_score(stats)


func add_thing(thing):
	add_child_below_node(SpawnZone, thing)

func start_slowmo(point):
	SlowMoTimer.start()
	Engine.time_scale = 0.3
#	LevelEffect.visible = true
	LevelEffect.material.set('shader_param/center', point)

func _on_SlowMoTimer_timeout():
	Engine.time_scale = 1
#	LevelEffect.visible = false
