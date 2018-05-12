extends Node2D


func _ready():
	$Particles2D.emitting = true
	$Sprite.frame = randi() % ($Sprite.vframes * $Sprite.hframes)


func __on_Animator_animation_finished(anim_name):
	queue_free()
