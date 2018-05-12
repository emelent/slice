extends Node2D

onready var LeftWrap = $LeftWrap
onready var RightWrap = $RightWrap


export var offset = 0
func _on_LeftWrap_area_entered(area):
	var node = area
	if node.is_in_group('hitbox'):
		node = area.get_parent()
	node.global_position.x= RightWrap.global_position.x - offset



func _on_RightWrap_area_entered(area):
	var node = area
	if node.is_in_group('hitbox'):
		node = area.get_parent()
	node.global_position.x= LeftWrap.global_position.x + offset
