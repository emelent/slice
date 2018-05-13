extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (PackedScene) var Bullet = preload('res://scenes/Bullet.tscn')
export var wait_time = 3.0
onready var FirePoint = $FirePoint


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$Timer.wait_time = wait_time

func shoot():
	var bullet = Bullet.instance()
	var  right = Vector2(1.0, 0)
	bullet.direction = right.rotated(rotation) * scale.x
	bullet.global_position = FirePoint.global_position
	get_tree().current_scene.add_child(bullet)


func _on_Timer_timeout():
	shoot()
