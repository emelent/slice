extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_DeathZone_area_entered(area):
	if area.is_in_group('hitbox'):
		var node  = area.get_parent()
		if node.is_in_group('players'):
			get_tree().current_scene.kill_player(node)
