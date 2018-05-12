extends Node2D

export(float, 0.1, 10) var duration =  1.0
export(PackedScene) var Effect

func _ready():
	$Timer.wait_time = duration
	if Effect:
		add_child(Effect.instance())

func _on_Timer_timeout():
	queue_free()
