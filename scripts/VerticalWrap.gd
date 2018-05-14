extends Node2D


onready var TopWrap = $TopWrap
onready var BottomWrap = $BottomWrap


export var offset = 0



func _on_TopWrap_area_entered(area):
	var node = area
	if node.is_in_group('hitbox'):
		node = area.get_parent()
#		node.motion.y = 0
	node.global_position.y = BottomWrap.global_position.y - offset


func _on_BottomWrap_area_entered(area):
	var node = area
	if node.is_in_group('hitbox'):
		node = area.get_parent()
		node.motion.y = 0
	node.global_position.y= TopWrap.global_position.y + offset
